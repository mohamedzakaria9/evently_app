import 'package:flutter/cupertino.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AlertDialoge {
  static void showError({
    required BuildContext context,
    required String message,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: message,
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: message,
      onConfirmBtnTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  static void showLoading({
    required BuildContext context,
    required String message,
    required String title,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: title,
      text: message,
    );
  }

  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);
  }
}
