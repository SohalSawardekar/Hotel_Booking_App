// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hotel_booking/constants/ImportFiles.dart';
import 'package:hotel_booking/screens/bookings/bookingConfirmation.dart';
import 'package:hotel_booking/screens/feedback.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Typedefs for Success and Failure callbacks (UPI Turbo)
typedef void OnSuccess<T>(T result);
typedef void OnFailure<T>(T error);

class PaymentPage extends StatefulWidget {
  final String roomId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalAmount;
  final String availableRoomId;

  const PaymentPage({
    super.key,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.totalAmount,
    required this.availableRoomId,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  late String paymentDocId; // For storing document ID
  late UpiTurbo _upiTurbo; // For UPI Turbo

  final MethodChannel _channel =
      MethodChannel('upi_turbo'); // UPI Turbo channel

  @override
  void initState() {
    super.initState();

    // Initialize Razorpay
    _razorpay = Razorpay();

    // Initialize UPI Turbo with MethodChannel
    _upiTurbo = UpiTurbo(_channel);

    // Set Razorpay event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Open Razorpay checkout on initialization
    _openCheckout();
  }

  // Function to open Razorpay checkout
  void _openCheckout() {
    var options = {
      'key': 'rzp_test_Pjb30t4hoYGOFf',
      'amount': widget.totalAmount * 100, // Amount in paise
      'name': 'Hotel Booking',
      'description': 'Payment for Room Booking',
      'external': {
        'wallets': ['paytm', 'gpay'] // Allowing UPI and Paytm wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  // Handle Razorpay payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");

    // Get current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    try {
      // Add payment details to Firestore
      DocumentReference paymentDocRef =
          await FirebaseFirestore.instance.collection('Payment').add({
        'totalAmount': widget.totalAmount,
        'transactionId': response.paymentId, // Transaction ID
        'timestamp': FieldValue.serverTimestamp(),
        'userId': currentUser?.uid,
        'userEmail': currentUser?.email, // Optional
      });

      // Store payment document ID
      paymentDocId = paymentDocRef.id;

      // Navigate to BookingConfirmationPage with payment ID
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationPage(
            paymentId: paymentDocId,
            roomId: widget.roomId,
            checkInDate: widget.checkInDate,
            checkOutDate: widget.checkOutDate,
          ),
        ),
      );
    } catch (e) {
      print("Error storing payment info: $e");
    }
  }

  // Handle Razorpay payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");

    // Show error dialog with retry option
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Failed'),
        content: Text(response.message ?? 'Something went wrong.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openCheckout(); // Retry payment
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AvailabilityPage(
                    roomType: widget.roomId,
                    checkInDate: widget.checkInDate,
                    checkOutDate: widget.checkOutDate,
                    adults: widget.adults,
                    children: widget.children,
                    totalAmount: widget.totalAmount,
                  ),
                ),
              );
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Handle external wallet selection
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  // UPI Turbo functionality: Linking new UPI account
  void _linkNewUpiAccount() {
    _upiTurbo.linkNewUpiAccount(
      customerMobile: "1234567890",
      onSuccess: (accounts) {
        print("UPI Account Linked Successfully: ${accounts.length} accounts");
      },
      onFailure: (error) {
        print("Failed to link UPI account: ${error.errorDescription}");
      },
    );
  }

  // Manage UPI accounts via UPI Turbo
  void _manageUpiAccounts() {
    _upiTurbo.manageUpiAccounts(
      customerMobile: "1234567890",
      onFailure: (error) {
        print("Failed to manage UPI accounts: ${error.errorDescription}");
      },
    );
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear Razorpay listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: _manageUpiAccounts, // Manage UPI accounts
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Processing Payment...'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _linkNewUpiAccount, // Link UPI account
              child: const Text('Link New UPI Account'),
            ),
          ],
        ),
      ),
    );
  }
}

// UpiTurbo class for handling UPI accounts
class UpiTurbo {
  late MethodChannel _channel;
  bool _isTurboPluginAvailable = true;

  UpiTurbo(this._channel) {
    _checkTurboPluginAvailable();
  }

  void _checkTurboPluginAvailable() async {
    try {
      final Map<dynamic, dynamic> response =
          await _channel.invokeMethod('isTurboPluginAvailable');
      _isTurboPluginAvailable = response["isTurboPluginAvailable"] ?? false;
    } on PlatformException catch (error) {
      _isTurboPluginAvailable = false;
      print("Error checking Turbo Plugin availability: ${error.message}");
    }
  }

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
      var requestParams = {"customerMobile": customerMobile, "color": color};
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
      var requestParams = {"customerMobile": customerMobile, "color": color};
      await _channel.invokeMethod('manageUpiAccounts', requestParams);
    } on PlatformException catch (error) {
      onFailure(Error(
          errorCode: error.code,
          errorDescription: error.message ?? "Unknown error"));
    }
  }

  List<UpiAccount> _parseUpiAccounts(String jsonString) {
    if (jsonString.isEmpty) {
      return <UpiAccount>[];
    }
    List<dynamic> json = jsonDecode(jsonString);
    List<UpiAccount> accounts = [];
    for (var account in json) {
      accounts.add(UpiAccount.fromJson(account));
    }
    return accounts;
  }

  void _emitFailure(OnFailure<Error> onFailure) {
    onFailure(Error(
        errorCode: "TURBO_PLUGIN_UNAVAILABLE",
        errorDescription: "Turbo Plugin is unavailable"));
  }
}

class UpiAccount {
  String upiId;
  String displayName;
  String accountType;

  UpiAccount({
    required this.upiId,
    required this.displayName,
    required this.accountType,
  });

  factory UpiAccount.fromJson(Map<dynamic, dynamic> json) {
    return UpiAccount(
      upiId: json['upiId'] ?? '',
      displayName: json['displayName'] ?? '',
      accountType: json['accountType'] ?? '',
    );
  }
}

class Error {
  String errorCode;
  String errorDescription;

  Error({required this.errorCode, required this.errorDescription});
}
