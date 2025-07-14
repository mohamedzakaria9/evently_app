import 'package:evently_app/theme/AppTheme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData appTheme = AppTheme.lightTheme;

  void changeAppTheme({required ThemeData theme}){
    if(appTheme == theme){
      return;
    }
    appTheme = theme;
    notifyListeners();
  }
}