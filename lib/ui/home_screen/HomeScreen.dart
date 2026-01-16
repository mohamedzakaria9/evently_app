import 'package:evently_app/models/LocalUser.dart';
import 'package:evently_app/providers/EventsProvider.dart';
import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/ui/home_screen/EventsListView.dart';
import 'package:evently_app/utilites/AppColors.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilites/AppFonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventsProvider>(context);
    eventProvider.loadTitle(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return DefaultTabController(
      length: eventProvider.titles.length,
      child: Scaffold(
        //backgroundColor: AppColors.darkBackGroundColor,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            //side: BorderSide(color: red),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          toolbarHeight: height * 0.14,
          primary: true,
          actionsPadding: EdgeInsets.symmetric(horizontal: width * 0.03),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back ✨", style: AppFonts.regular14White),
              Text(LocalUser.name!, style: AppFonts.bold24Grey),
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  ImageIcon(
                    AssetImage(AppImages.mapIcon),
                    color: AppColors.whiteColor,
                  ),
                  Text("Cairo , Egypt", style: AppFonts.medium14White),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                themeProvider.changeAppTheme(
                  theme: themeProvider.appTheme == AppTheme.lightTheme
                      ? AppTheme.darkTheme
                      : AppTheme.lightTheme,
                );
              },
              icon: ImageIcon(
                AssetImage(AppImages.themeChangeIcon),
                color: AppColors.whiteColor,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: width * 0.089,
              height: height * 0.039,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("EN", style: AppFonts.bolc14MainAppColor),
            ),
          ],
          bottom: TabBar(

            dividerHeight: 0,
            indicatorColor: Colors.transparent,
            onTap: (index) {
              eventProvider.setIndex(index);
              eventProvider.getEvents(allowLoading: true,uId: LocalUser.uId!);
            },
            labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
            tabs: eventProvider.titles.map((title) {
              return Tab(
                child: Container(
                  margin: EdgeInsets.only(bottom: width * 0.01),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.003,
                  ),
                  decoration: BoxDecoration(
                    color: eventProvider.currentIndex == eventProvider.titles.indexOf(title)
                        ? themeProvider.appTheme == AppTheme.lightTheme
                              ? AppColors.whiteColor
                              : AppColors.appPrimaryColor
                        : Colors.transparent,
                    border: Border.all(
                      color: themeProvider.appTheme == AppTheme.lightTheme
                          ? AppColors.whiteColor
                          : AppColors.appPrimaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    title,
                    style: eventProvider.currentIndex == eventProvider.titles.indexOf(title)
                        ? themeProvider.appTheme == AppTheme.lightTheme
                              ? AppFonts.medium16Primary
                              : AppFonts.medium16White
                        : AppFonts.medium14White,
                  ),
                ),
              );
            }).toList(),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
          ),
        ),
        body: EventsListView(),
      ),
    );
  }
}
