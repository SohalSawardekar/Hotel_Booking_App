import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeNotifier() {
    _loadThemeFromPrefs(); // Load theme when the app starts
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _saveThemeToPrefs(); // Save the new theme mode to preferences
    notifyListeners();
  }

  // Save the theme mode to SharedPreferences
  void _saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  // Load the theme mode from SharedPreferences
  void _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default to light mode
    notifyListeners();
  }
}
