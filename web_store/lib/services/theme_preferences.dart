import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String _themeKey = 'app_theme_mode';

  Future<void> saveThemeMode(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDarkMode);
      developer.log('Saved theme mode: ${isDarkMode ? "Dark" : "Light"}', name: 'ThemePreferences');
    } catch (e) {
      developer.log('Error saving theme mode: $e', name: 'ThemePreferences', error: e);
    }
  }

  Future<bool?> getThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool(_themeKey);
      developer.log('Loaded theme mode: ${isDark == null ? "System Default" : (isDark ? "Dark" : "Light")}', name: 'ThemePreferences');
      return isDark;
    } catch (e) {
      developer.log('Error getting theme mode: $e', name: 'ThemePreferences', error: e);
      return null;
    }
  }
}
