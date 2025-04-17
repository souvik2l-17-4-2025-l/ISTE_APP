import 'package:flutter/material.dart';

class themeprovider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void toggletheme() {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}