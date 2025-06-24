import 'package:flutter/material.dart';
import 'package:todo/core/theme/theme.dart';

class ThemProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    themeData = darkMode;
  } 

  void toggleTheme() {
    if(_themeData == lightMode) {
      themeData = darkMode;
    }
     else {
      themeData = lightMode;
     }
  }
}