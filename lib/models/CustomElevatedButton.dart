import 'package:flutter/material.dart';

import '../utilites/AppColors.dart';
class CustomElevatedButton extends StatelessWidget {
  Widget content;
  Color backGroundColor;
  VoidCallback onPress;
  Color borderSideColor;
  CustomElevatedButton({
    super.key,
    required this.content,
    this.backGroundColor = AppColors.appPrimaryColor,
    required this.onPress,
    this.borderSideColor = Colors.transparent
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(vertical: height * 0.013),
        shadowColor: Colors.transparent,
        side: BorderSide(
          color: borderSideColor
        )
      ),
      child: content,
    );
  }
}
