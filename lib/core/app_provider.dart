import 'package:flutter/material.dart';

class SettingProuider extends ChangeNotifier {
  ThemeMode currentTheme= ThemeMode.light;

  bool isDark(){
    return currentTheme == ThemeMode.dark;
  }
void changeMode( ThemeMode mode){
    if(currentTheme == mode) return;
    currentTheme = mode;
    notifyListeners();
}
}