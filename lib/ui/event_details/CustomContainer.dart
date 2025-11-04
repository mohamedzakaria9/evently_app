import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilites/AppColors.dart';
import '../../utilites/AppFonts.dart';

class CustomContainer extends StatelessWidget {
  String iconPath;
  String title;
  String? title_2;
  String? suffixIcon;

  CustomContainer({
    super.key,
    required this.iconPath,
    required this.title,
    this.title_2,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.appPrimaryColor, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.015,
            ),
            decoration: BoxDecoration(
              color: AppColors.appPrimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              iconPath,
              color: themeProvider.appTheme == AppTheme.lightTheme
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          ),
          SizedBox(width: width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFonts.medium16Primary),
              title_2 == null
                  ? Container()
                  : Text(
                      title_2!,
                      style: themeProvider.appTheme == AppTheme.lightTheme
                          ? AppFonts.medium16Black
                          : AppFonts.medium16White,
                    ),
            ],
          ),
          Spacer(),
          suffixIcon == null
              ? Container()
              : ImageIcon(
                  AssetImage(suffixIcon!),
                  color: AppColors.appPrimaryColor,
                ),
        ],
      ),
    );
  }
}
