import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/utilites/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilites/AppFonts.dart';
import '../../utilites/AppImages.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: height * 0.01,
            horizontal: width * 0.03,
          ),
          height: height * 0.23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.appPrimaryColor),
            image: DecorationImage(
              image: AssetImage(AppImages.sportImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.003,
                  horizontal: width * 0.015,
                ),
                decoration: BoxDecoration(
                  color: themeProvider.appTheme == AppTheme.lightTheme ? AppColors.greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Column(
                  children: [
                    Text("21"),
                    Text("Nov", style: AppFonts.bold14Primary),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.006,
                  horizontal: width * 0.03,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: themeProvider.appTheme == AppTheme.lightTheme ? AppColors.greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Hello my dear friend",
                        style: themeProvider.appTheme == AppTheme.lightTheme ? AppFonts.bold14Black : AppFonts.bold14White,
                      ),
                    ),
                    ImageIcon(
                      AssetImage(AppImages.heartIcon),
                      color: AppColors.appPrimaryColor,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
