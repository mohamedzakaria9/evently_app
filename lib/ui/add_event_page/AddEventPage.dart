import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/CustomElevatedButton.dart';
import 'package:evently_app/models/CustomTextFormField.dart';
import 'package:evently_app/models/Event.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../fireBase_utiles/FirebaseUtiles.dart';
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
    AppImages.eatingImage,
    AppImages.holidayImage,
    AppImages.exhibitionImage,
    AppImages.workshopImage,
    AppImages.bookClubImage,
  ];

  List<String> titleList = [
    "Sport",
    "Birthday",
    "Meeting",
    "Gaming",
    "Eating",
    "Holiday",
    "Exhibition",
    "WorkShop",
    "Book Club",
  ];

  final _formKey = GlobalKey<FormState>();

  int currentIndex = 0;
  String? currentDate;
  String? currentTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
                          titleList[index],
                          style: AppFonts.bold16Primary,
                        ),
                      ),
                    ),
                    itemCount: titleList.length,
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
                        var date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2026, 1, 1),
                        );
                        if (date == null) {
                          currentDate = null;
                        } else {
                          currentDate = DateFormat.yMMMd().format(date);
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
                        var time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time == null) {
                          currentTime = null;
                        } else {
                          currentTime = "${time.hour} : ${time.minute}";
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
                      Text("Cairo , Egypt", style: AppFonts.medium16Primary),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.appPrimaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  content: Text(
                    AppLocalizations.of(context)!.add_event,
                    style: AppFonts.medium20White,
                  ),
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseUtiles.addEventToFireStore(
                        Event(
                          title: titleController.text,
                          description: descriptionController.text,
                          category: titleList[currentIndex],
                          image: imagesList[currentIndex],
                          date: currentDate!,
                          time: currentTime!,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Event Added Successfully')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Can't Add Event")),
                      );
                    }
                  },
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
