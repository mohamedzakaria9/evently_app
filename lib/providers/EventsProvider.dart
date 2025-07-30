import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../FirebaseUtiles.dart';
import '../l10n/app_localizations.dart';
import '../models/Event.dart';

class EventsProvider extends ChangeNotifier{
  List<Event> events = [];
  List<Event> selectedTitle = [];
  int currentIndex = 0;
  List<String> titles = [];
  void getStoredEvents() async {
    var eventsCollection = FirebaseUtiles.getEvents();
    QuerySnapshot<Event> eventsDocs = await eventsCollection.get();
    events = eventsDocs.docs.map((event) {
      //event.doc.data()!.date = DateFormat('MMM d, y', 'en_US').parse(event.doc.data()!.date);
      // print("this is the time of the event : ${event.doc.data()!.time}");
      print(DateFormat.MMM().format(event.data().date));
      print(event.data().date.runtimeType);
      return event.data();
    }).toList();
    events.sort((event_1, event_2) {
      return event_1.date.compareTo(event_2.date);
    },);
    //print("this is from get all events");
    //printEventsList(events);
    selectedTitle = events;
    if(events.isEmpty){
      print("i didn't find any thing");
    }else{
      notifyListeners();
    }
  }

  void getEventCategory(){
    //print("this is after call the get Stored evetns from the get event category");
    printEventsList(events);
    selectedTitle = events.where((element) => element.category == titles[currentIndex],).toList();
    //print("this is from select category");
    //printEventsList(events);
    notifyListeners();
  }

  void getEvents(){
    //print("this is the current index for the $currentIndex");
    currentIndex == 0 ? getStoredEvents() : getEventCategory();
  }
  void setIndex(index){
    currentIndex = index;
    notifyListeners();
  }

  void loadTitle(BuildContext context){
    titles =  [
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
  void printEventsList(List<Event> events){
    for (var element in events) {
      print("this is the title of the event : ${element.title}");
      print("this is the description of the event : ${element.description}");
      print("this is the category of the event : ${element.category}");
    }
  }
}
