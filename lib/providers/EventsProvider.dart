import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../FirebaseUtiles.dart';
import '../l10n/app_localizations.dart';
import '../models/Event.dart';
import '../utilites/AppColors.dart';

class EventsProvider extends ChangeNotifier {
  List<Event> events = [];
  List<Event> selectedTitle = [];
  List<Event> favoriteEvents = [];
  int currentIndex = 0;
  List<String> titles = [];
  bool isLoading = false;
  Set<Marker> eventsLocations = {};

  Future<void> getStoredEvents({
    bool shouldNotify = true,
    required String uId,
  }) async {
    var eventsCollection = FirebaseUtiles.getEvents(uId);
    QuerySnapshot<Event> eventsDocs = await eventsCollection.get();
    events = eventsDocs.docs.map((event) {
      print(DateFormat.MMM().format(event.data().date));
      print(event.data().date.runtimeType);
      return event.data();
    }).toList();
    events.sort((event_1, event_2) {
      return event_1.date.compareTo(event_2.date);
    });
    //print("this is from get all events");
    //printEventsList(events);
    selectedTitle = events;
    //favoriteEvents.removeRange(0, favoriteEvents.length-1);
    favoriteEvents.clear();
    for (var event in events) {
      if (event.isFavorite) {
        favoriteEvents.add(event);
      }
    }
    if (events.isEmpty) {
      //print("i didn't find any thing");
    } else {
      if (shouldNotify) {
        notifyListeners();
      }
    }
  }

  Future<void> getEventCategory({
    required bool allowLoading,
    required String uId,
  }) async {
    isLoading = allowLoading;
    notifyListeners();
    await getStoredEvents(shouldNotify: false, uId: uId);
    selectedTitle = events
        .where((element) => element.category == titles[currentIndex])
        .toList();

    isLoading = false;
    notifyListeners();
  }

  void getEvents({required bool allowLoading, required String uId}) async {
    isLoading = allowLoading;
    notifyListeners();
    // print("this is print from the get Events function");
    // print("this is the current index for the $currentIndex");
    if (currentIndex == 0) {
      await getStoredEvents(uId: uId);
    } else {
      await getEventCategory(allowLoading: true, uId: uId);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getLocations({required String uId}) async{
    await getStoredEvents(uId: uId);
    for (var event in events) {
      eventsLocations.add(
        Marker(
          markerId: MarkerId(event.id!),
          position: LatLng(event.latLng.latitude, event.latLng.longitude),
        ),
      );
    }
    notifyListeners();
  }

  void addFavorite(
    Event event,
    BuildContext context, {
    required String uId,
  }) async {
    CollectionReference events = FirebaseUtiles.getEvents(uId);
    await events
        .doc(event.id)
        .update({"isFavorite": !event.isFavorite})
        .then((value) {
          //Duration(milliseconds: 500);

          // print("this is the print from the add favorite in the then function");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Event Updated Successfully'),
              backgroundColor: AppColors.appPrimaryColor,
            ),
          );
        })
        .timeout(
          Duration(milliseconds: 3000),
          onTimeout: () {
            if (context.mounted) {
              // print("this is the print from the add favorite in the timeout function");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Event Updated Successfully'),
                  backgroundColor: AppColors.appPrimaryColor,
                ),
              );
            }
          },
        );
    if (currentIndex == 0) {
      getStoredEvents(uId: uId);
    } else {
      // print("this is the print from the else condition in the add favorite before call");
      getEventCategory(allowLoading: false, uId: uId);
      // print("this is the print from the else condition in the add favorite after call");
    }
  }

  void setIndex(index) {
    currentIndex = index;
    notifyListeners();
  }

  void loadTitle(BuildContext context) {
    titles = [
      AppLocalizations.of(context)!.all,
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
  }

  void printEventsList(List<Event> events) {
    for (var element in events) {
      print("this is the title of the event : ${element.title}");
      print("this is the description of the event : ${element.description}");
      print("this is the category of the event : ${element.category}");
      print("this is the favorite state of the event : ${element.isFavorite}");
    }
  }

  void clearData() {
    events = [];
    selectedTitle = [];
    favoriteEvents = [];
    currentIndex = 0;
    titles = [];
    isLoading = false;
    notifyListeners();
  }
}
