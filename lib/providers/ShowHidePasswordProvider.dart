import 'package:flutter/material.dart';

class ShowHidePasswordProvider extends ChangeNotifier{
  bool isPassword = true;
  void showHidePassword(){
    isPassword = !isPassword;
    notifyListeners();
  }
}