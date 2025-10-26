import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/LocalUser.dart';
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
  bool favoritePage;
  EventsListView({super.key, this.favoritePage = false});
  @override
  State<EventsListView> createState() => _EventsListViewState();
}

class _EventsListViewState extends State<EventsListView> {



  @override
  void initState() {
    super.initState();
    final eventProvider = Provider.of<EventsProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (eventProvider.events.isEmpty) {
        eventProvider.getEvents(allowLoading: true,uId: LocalUser.uId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("this is the build of the EventsListView");
    var eventProvider = Provider.of<EventsProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    List<Event> events = widget.favoritePage ? eventProvider.favoriteEvents : eventProvider.selectedTitle;
    return Consumer<EventsProvider>(builder: (context, eventProvider, child) {
      //print("this is the value of the is loading boolean ${eventProvider.isLoading}");
      if(eventProvider.isLoading){
        //print("iam in the loading process");
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.appPrimaryColor,
          ),
        );
      }
      if(eventProvider.selectedTitle.isEmpty){
        return Center(
          child: Text(AppLocalizations.of(context)!.no_data_found),
        );
      }
      return ListView.builder(
        itemCount:  events.length,
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
                image: AssetImage(events[index].image),
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
                      Text(
                        DateFormat.d().format(
                          events[index].date,
                        ),
                      ),
                      Text(
                        DateFormat.MMM().format(
                          events[index].date,
                        ),
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
                          events[index].title,
                          style: themeProvider.appTheme == AppTheme.lightTheme
                              ? AppFonts.bold14Black
                              : AppFonts.bold14White,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          eventProvider.addFavorite(events[index],context,uId: LocalUser.uId!);
                        },
                        child: events[index].isFavorite
                            ? ImageIcon(
                          AssetImage(AppImages.favoriteIconFilled),
                          color: AppColors.appPrimaryColor,
                          size: 35,
                        )
                            : ImageIcon(
                          AssetImage(AppImages.heartIcon),
                          color: AppColors.appPrimaryColor,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },);
  }
}
