import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../FirebaseUtiles.dart';
import '../models/Event.dart';

class EventsProvider extends ChangeNotifier{
  List<Event> events = [];

  void getStoredEvents() async {
    var eventsCollection = FirebaseUtiles.getEvents();
    QuerySnapshot<Event> eventsDocs = await eventsCollection.get();
    events = eventsDocs.docChanges.map((event) {
      //event.doc.data()!.date = DateFormat('MMM d, y', 'en_US').parse(event.doc.data()!.date);
      // print("this is the time of the event : ${event.doc.data()!.time}");
      print(DateFormat.MMM().format(event.doc.data()!.date));
      print(event.doc.data()!.date.runtimeType);
      return event.doc.data()!;
    }).toList();

    notifyListeners();
  }
}