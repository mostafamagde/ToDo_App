import 'package:flutter/material.dart';

class SettingProuider extends ChangeNotifier {
  ThemeMode currenttheme= ThemeMode.light;

  bool isDark(){
    return currenttheme == ThemeMode.dark;
  }
void changeMode( ThemeMode mode){
    if(currenttheme == mode) return;
    currenttheme = mode;
    notifyListeners();
}
}