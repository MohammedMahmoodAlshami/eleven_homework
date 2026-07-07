import 'package:flutter/material.dart';
import '../services/theme_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemePreferences _preferences = ThemePreferences();
  ThemeMode _themeMode = ThemeMode.system;
  
  bool _isInitialized = false;

  ThemeProvider() {
    // Note: To prevent UI flicker, we typically try to load this before runApp
    // but we also have a fallback here.
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isInitialized => _isInitialized;

  Future<void> initializeTheme(bool? isDarkFromPrefs) async {
    if (isDarkFromPrefs != null) {
      _themeMode = isDarkFromPrefs ? ThemeMode.dark : ThemeMode.light;
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final bool isCurrentlyDark = _themeMode == ThemeMode.dark;
    _themeMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    
    await _preferences.saveThemeMode(!isCurrentlyDark);
  }
}
