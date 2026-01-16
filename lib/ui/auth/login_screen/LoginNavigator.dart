import 'package:flutter/cupertino.dart';

abstract class LoginNavigator {
  void showLoading({required String message, required String title});

  void hideLoading();

  void showError({required String message, required String title});

  void navigateToHome();
}
