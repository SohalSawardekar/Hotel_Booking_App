import 'dart:convert';
import 'package:flutter/services.dart';
// ignore: unused_import
// import 'package:hotel_booking/error.dart';

// Typedefs for Success and Failure callbacks
typedef void OnSuccess<T>(T result);
typedef void OnFailure<T>(T error);

class UpiTurbo {
  // Declare the method channel for communicating with native code
  late MethodChannel _channel;

  // Flag to check if Turbo Plugin is available
  bool _isTurboPluginAvailable = true;

  // Constructor that takes a method channel as a parameter
  UpiTurbo(MethodChannel channel) {
    _channel = channel;
    _checkTurboPluginAvailable();
  }

  // Method to check if the Turbo UPI plugin is available
  void _checkTurboPluginAvailable() async {
    try {
      final Map<dynamic, dynamic> response =
          await _channel.invokeMethod('isTurboPluginAvailable');
      _isTurboPluginAvailable = response["isTurboPluginAvailable"] ?? false;
    } on PlatformException catch (error) {
      // If there's a platform exception, assume the plugin is unavailable
      _isTurboPluginAvailable = false;
      print("Error checking Turbo Plugin availability: ${error.message}");
    }
  }

  // Method to link a new UPI account
  void linkNewUpiAccount({
    required String customerMobile,
    String? color,
    required OnSuccess<List<UpiAccount>> onSuccess,
    required OnFailure<Error> onFailure,
  }) async {
    if (!_isTurboPluginAvailable) {
      _emitFailure(onFailure);
      return;
    }

    try {
      var requestParams = {
        "customerMobile": customerMobile,
        "color": color,
      };

      final Map<dynamic, dynamic> response =
          await _channel.invokeMethod('linkNewUpiAccount', requestParams);

      if (response.containsKey('data') && response['data'].isNotEmpty) {
        onSuccess(_parseUpiAccounts(response['data']));
      } else {
        onFailure(Error(
            errorCode: "NO_ACCOUNT_FOUND",
            errorDescription: "No UPI account found"));
      }
    } on PlatformException catch (error) {
      onFailure(Error(
          errorCode: error.code,
          errorDescription: error.message ?? "Unknown error"));
    }
  }

  // Method to manage UPI accounts (redirects user to the UPI management UI)
  void manageUpiAccounts({
    required String customerMobile,
    String? color,
    required OnFailure<Error> onFailure,
  }) async {
    if (!_isTurboPluginAvailable) {
      _emitFailure(onFailure);
      return;
    }

    try {
      var requestParams = {
        "customerMobile": customerMobile,
        "color": color,
      };

      await _channel.invokeMethod('manageUpiAccounts', requestParams);
    } on PlatformException catch (error) {
      onFailure(Error(
          errorCode: error.code,
          errorDescription: error.message ?? "Unknown error"));
    }
  }

  // Private method to parse UPI account data from a JSON string
  List<UpiAccount> _parseUpiAccounts(String jsonString) {
    if (jsonString.isEmpty) {
      return <UpiAccount>[];
    }

    List<dynamic> jsonDecoded = json.decode(jsonString);
    return jsonDecoded
        .map((jsonItem) => UpiAccount.fromJson(jsonItem))
        .toList();
  }

  // Private method to handle failures if the Turbo plugin is unavailable
  void _emitFailure(OnFailure<Error> onFailure) {
    onFailure(Error(
      errorCode: "TURBO_PLUGIN_UNAVAILABLE",
      errorDescription: "The Turbo UPI plugin is not available on this device",
    ));
  }
}

// UpiAccount Model (can be expanded as needed)
class UpiAccount {
  String upiId;
  String accountName;
  String bankName;

  UpiAccount({
    required this.upiId,
    required this.accountName,
    required this.bankName,
  });

  // Factory method to create an instance of UpiAccount from a JSON map
  factory UpiAccount.fromJson(Map<String, dynamic> json) {
    return UpiAccount(
      upiId: json['samarthkamat80@oksbi'] ?? '',
      accountName: json['Samarth Kamat'] ?? '',
      bankName: json['SBI'] ?? '',
    );
  }

  // Method to convert UpiAccount to JSON
  Map<String, dynamic> toJson() {
    return {
      'upiId': upiId,
      'accountName': accountName,
      'bankName': bankName,
    };
  }
}

// Error model for handling errors
class Error {
  String errorCode;
  String errorDescription;

  Error({required this.errorCode, required this.errorDescription});
}
