import 'package:evently_app/FirebaseUtiles.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/CustomElevatedButton.dart';
import 'package:evently_app/models/CustomTextFormField.dart';
import 'package:evently_app/models/Event.dart';
import 'package:evently_app/providers/LocationProvider.dart';
import 'package:evently_app/ui/add_event_page/GoogleMapsPage.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/LocalUser.dart';
import '../../providers/EventsProvider.dart';
import '../../utilites/AppColors.dart';
import '../../utilites/AppFonts.dart';

class AddEventPage extends StatefulWidget {
  AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  List<String> imagesList = [
    AppImages.sportImage,
    AppImages.birthDayImage,
    AppImages.meetingImage,
    AppImages.gamingImage,
    AppImages.workshopImage,
    AppImages.bookClubImage,
    AppImages.exhibitionImage,
    AppImages.holidayImage,
    AppImages.eatingImage,
  ];

  final _formKey = GlobalKey<FormState>();
  LatLng? chosenLocation;
  int currentIndex = 0;
  var currentDate;
  var currentTime;
  DateTime? date;
  TimeOfDay? time;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var eventsProvider = Provider.of<EventsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<LocationProvider>(
          builder: (context, value, child) {
            return IconButton(
              onPressed: () {
                value.clearLocation();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.appPrimaryColor),
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppFonts.regular24Primary,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(imagesList[currentIndex]),
                ),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.08,
                  child: ListView.builder(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        currentIndex = index;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: height * 0.02,
                          horizontal: width * 0.01,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: AppColors.appPrimaryColor,
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          titles[index],
                          style: AppFonts.bold16Primary,
                        ),
                      ),
                    ),
                    itemCount: titles.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: AppFonts.medium16Black,
                ),
                SizedBox(height: height * 0.01),
                Customtextformfield(
                  prefixIcon: AppImages.titleIcon,
                  labelText: AppLocalizations.of(context)!.title,
                  textEditingController: titleController,
                  validate: (text) {
                    if (text == "") {
                      //print("$text this is what title contains it's not null");
                      return "Enter title";
                    } else {
                      //print("$text this is what title contains  null");
                      return null;
                    }
                  },
                ),
                SizedBox(height: height * 0.01),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: AppFonts.medium16Black,
                ),
                SizedBox(height: height * 0.01),
                Customtextformfield(
                  prefixIcon: AppImages.titleIcon,
                  maxLines: 4,
                  labelText: AppLocalizations.of(context)!.description,
                  textEditingController: descriptionController,
                  validate: (text) {
                    if (text == "") {
                      //print("$text this is what description contains it's not null");
                      return "Enter description";
                    } else {
                      //print("$text this is what description contains  null");
                      return null;
                    }
                  },
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    ImageIcon(AssetImage(AppImages.eventDateIcon)),
                    SizedBox(width: width * 0.02),
                    Text(
                      AppLocalizations.of(context)!.event_date,
                      style: AppFonts.medium16Black,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2026, 1, 1),
                        );
                        if (date == null) {
                          currentDate = null;
                        } else {
                          currentDate = DateFormat.yMMMd().format(date!);
                        }
                        setState(() {});
                      },
                      child: Text(
                        currentDate == null
                            ? AppLocalizations.of(context)!.choose_date
                            : currentDate!,
                        style: AppFonts.medium16Primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    ImageIcon(AssetImage(AppImages.eventTimeIcon)),
                    SizedBox(width: width * 0.02),
                    Text(
                      AppLocalizations.of(context)!.event_time,
                      style: AppFonts.medium16Black,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () async {
                        // print(
                        //   "this is the current time var before pick up: $time",
                        // );
                        time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        // print(
                        //   "this is the current time after the pick up $time",
                        // );
                        if (time == null) {
                          currentTime = null;
                        } else {
                          // print(
                          //   "this is the current time var before : $currentTime",
                          // );
                          currentTime = time!.format(context);
                          // print(
                          //   "this is the current time var after : $currentTime",
                          // );
                        }
                        setState(() {});
                      },
                      child: Text(
                        currentTime == null
                            ? AppLocalizations.of(context)!.choose_time
                            : currentTime!,
                        style: AppFonts.medium16Primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: AppFonts.medium16Black,
                ),
                SizedBox(height: height * 0.01),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.appPrimaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Consumer<LocationProvider>(
                    builder: (context, value, child) {
                      return InkWell(
                        onTap: () async {
                          LatLng? location = await Navigator.push<LatLng>(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GoogleMapsPage();
                              },
                            ),
                          );
                          value.updateLocation(location!);
                          chosenLocation = value.location;
                          print(
                            "this is the location variable ${location!.latitude} and ${location.longitude}",
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.01,
                                horizontal: width * 0.02,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.appPrimaryColor,
                              ),
                              child: ImageIcon(
                                AssetImage(AppImages.locationIcon),
                                color: AppColors.whiteColor,
                              ),
                            ),
                            SizedBox(width: width * 0.02),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                value.location == null
                                    ? AppLocalizations.of(
                                        context,
                                      )!.choose_location
                                    : "Chosen Location is ${value.location!.latitude} and ${value.location!.longitude}",
                                style: AppFonts.medium16Primary,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.appPrimaryColor,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.02),
                Consumer<LocationProvider>(
                  builder: (context, value, child) {
                    return CustomElevatedButton(
                      content: Text(
                        AppLocalizations.of(context)!.add_event,
                        style: AppFonts.medium20White,
                      ),
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          FirebaseUtiles.addEvent(
                            Event(
                              title: titleController.text,
                              image: imagesList[currentIndex],
                              category: eventsProvider.titles[currentIndex + 1],
                              description: descriptionController.text,
                              date: date!,
                              time: currentTime!,
                              latLng: chosenLocation!,
                            ),
                            LocalUser.uId!,
                          );
                          eventsProvider.getEvents(
                            allowLoading: true,
                            uId: LocalUser.uId!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Event Added Successfully'),
                              backgroundColor: AppColors.appPrimaryColor,
                            ),
                          );

                          Navigator.pop(context);
                          value.clearLocation();
                        }
                      },
                    );
                  }
                ),
                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
