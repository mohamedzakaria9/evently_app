import 'package:evently_app/utilites/AppFonts.dart';
import 'package:flutter/material.dart';

import '../utilites/AppColors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(color: AppColors.appPrimaryColor),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.whiteColor,
    ),
    textTheme: TextTheme(
      bodyLarge: AppFonts.bold20Black,
      bodyMedium: AppFonts.bold20blue,
      bodySmall: AppFonts.medium16Grey,
      labelLarge: AppFonts.bold24Grey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.appPrimaryColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      selectedLabelStyle: AppFonts.bold14White,
      unselectedLabelStyle: AppFonts.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.appPrimaryColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackGroundColor,
    appBarTheme: AppBarTheme(
      //color: AppColors.darkBackGroundColor,
      backgroundColor: AppColors.darkBackGroundColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.darkBackGroundColor,
    ),
    textTheme: TextTheme(
      bodyLarge: AppFonts.bold20White,
      bodyMedium: AppFonts.bold20blue,
      bodySmall: AppFonts.medium16Grey,
      labelLarge: AppFonts.bold24Grey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackGroundColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
      selectedLabelStyle: AppFonts.bold14White,
      unselectedLabelStyle: AppFonts.bold12White,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkBackGroundColor,
    ),
  );
}
