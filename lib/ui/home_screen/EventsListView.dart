import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/FirebaseUtiles.dart';
import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/utilites/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/Event.dart';
import '../../providers/EventsProvider.dart';
import '../../utilites/AppFonts.dart';
import '../../utilites/AppImages.dart';

class EventsListView extends StatefulWidget {
  EventsListView({super.key});

  @override
  State<EventsListView> createState() => _EventsListViewState();
}

class _EventsListViewState extends State<EventsListView> {
  @override
  Widget build(BuildContext context) {
    var eventProvider = Provider.of<EventsProvider>(context);
    if (eventProvider.events.isEmpty) {
      eventProvider.getStoredEvents();
    }
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ListView.builder(
      itemCount: eventProvider.events.length,
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
              image: AssetImage(eventProvider.events[index].image),
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
                  color: themeProvider.appTheme == AppTheme.lightTheme
                      ? AppColors.greyColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(DateFormat.d().format(eventProvider.events[index].date)),
                    Text(
                      DateFormat.MMM().format(eventProvider.events[index].date),
                      style: AppFonts.bold14Primary,
                    ),
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
                  color: themeProvider.appTheme == AppTheme.lightTheme
                      ? AppColors.greyColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        eventProvider.events[index].title,
                        style: themeProvider.appTheme == AppTheme.lightTheme
                            ? AppFonts.bold14Black
                            : AppFonts.bold14White,
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
