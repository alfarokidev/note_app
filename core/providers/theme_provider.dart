import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  static const String _themeKey = 'theme_mode';

  @override
  ThemeMode build() {
    _loadTheme();
    return ThemeMode.system;
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    state = ThemeMode.values[themeIndex];
  }

  void setTheme(ThemeMode themeMode) async {
    state = themeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, themeMode.index);
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.light:
        setTheme(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        setTheme(ThemeMode.system);
        break;
      case ThemeMode.system:
        setTheme(ThemeMode.light);
        break;
    }
  }
}