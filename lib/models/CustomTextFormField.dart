import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/AppTheme.dart';
import '../utilites/AppColors.dart';
import '../utilites/AppFonts.dart';

//this is the validation fucntion
typedef validation = String? Function(String?);

class Customtextformfield extends StatelessWidget {
  Color borderColor;
  String prefixIcon;
  Color prefixIconColor;
  String labelText;
  TextStyle labelTextStyle;
  String? suffixIcon;
  bool isSuffixIcon;
  bool password;
  validation validate;
  TextEditingController? textEditingController;

  Customtextformfield({
    this.borderColor = AppColors.darkGery,
    required this.prefixIcon,
    this.prefixIconColor = AppColors.darkGery,
    required this.labelText,
    this.labelTextStyle = AppFonts.medium16DarkGrey,
    this.isSuffixIcon = false,
    this.suffixIcon,
    this.password = false,
    required this.validate,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: themeProvider.appTheme == AppTheme.lightTheme
                ? borderColor
                : AppColors.appPrimaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: themeProvider.appTheme == AppTheme.lightTheme
                ? borderColor
                : AppColors.appPrimaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: ImageIcon(
          AssetImage(prefixIcon),
          color: themeProvider.appTheme == AppTheme.lightTheme
              ? prefixIconColor
              : prefixIconColor == AppColors.darkGery
              ? AppColors.whiteColor
              : prefixIconColor,
        ),
        label: Text(
          labelText,
          style: (themeProvider.appTheme == AppTheme.lightTheme)
              ? labelTextStyle
              : labelTextStyle == AppFonts.medium16DarkGrey
              ? AppFonts.medium16White
              : labelTextStyle,
        ),
        suffixIcon: isSuffixIcon
            ? ImageIcon(
                AssetImage(suffixIcon!),
                color: themeProvider.appTheme == AppTheme.lightTheme
                    ? prefixIconColor
                    : AppColors.whiteColor,
              )
            : null,
      ),
      obscureText: password,
      obscuringCharacter: "*",
      validator: validate,
    );
  }
}
