
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{

  //todo: data
  ThemeMode appThemeMode = ThemeMode.light;

  //todo: methods
  void changeThemeMode(ThemeMode newThemeMode){
    if(appThemeMode == newThemeMode) return;
    appThemeMode = newThemeMode;
    notifyListeners();
  }

  bool isDarkMode(){
    return appThemeMode == ThemeMode.dark;
  }

  bool isLightMode(){
    return appThemeMode == ThemeMode.light;
  }
}