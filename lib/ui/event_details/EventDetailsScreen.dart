import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/Event.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/ui/event_details/CustomContainer.dart';
import 'package:evently_app/utilites/AppFonts.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/ThemeProvider.dart';
import '../../utilites/AppColors.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var event = ModalRoute.of(context)!.settings.arguments as Event;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppFonts.regular24Primary,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: AppColors.appPrimaryColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ///todo: add the edit functionality
            },
            icon: Image.asset(AppImages.editIcon),
          ),
          IconButton(
            onPressed: () {
              ///todo: add the delete functionality
            },
            icon: Image.asset(AppImages.deleteIcon),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.035,
          vertical: height * 0.015,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //event image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(event.image),
              ),
              SizedBox(height: height * 0.02),
              //event title
              Text(event.title, style: AppFonts.regular24Primary),
              SizedBox(height: height * 0.02),
              CustomContainer(
                iconPath: AppImages.eventDateIcon,
                title:
                    "${event.date.day} ${DateFormat.MMMM().format(event.date)} ${event.date.year}",
                title_2: "${event.time}",
              ),
              SizedBox(height: height * 0.02),
              CustomContainer(
                iconPath: AppImages.locationIcon,
                title: "Location",
                suffixIcon: AppImages.rightArrowIcon,
              ),
              SizedBox(height: height * 0.02),
              //location of the event
              Container(
                width: width,
                height: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.appPrimaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GoogleMap(
                    style: "this is the style",
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        event.latLng.latitude,
                        event.latLng.longitude,
                      ),
                      // Cairo example
                      zoom: 17,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("1"),
                        position: LatLng(
                          event.latLng.latitude,
                          event.latLng.longitude,
                        ),
                      ),
                    },
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                AppLocalizations.of(context)!.description,
                style: themeProvider.appTheme == AppTheme.lightTheme
                    ? AppFonts.medium16Black
                    : AppFonts.medium16White,
              ),
              Text(
                event.description,
                style: themeProvider.appTheme == AppTheme.lightTheme
                    ? AppFonts.medium16Black
                    : AppFonts.medium16White,
              ),
              SizedBox(height: height*0.02,)
            ],
          ),
        ),
      ),
    );
  }
}
