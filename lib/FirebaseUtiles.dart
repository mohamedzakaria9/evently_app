import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/Event.dart';

class FirebaseUtiles {
  static CollectionReference<Event> getEvents() {
    return FirebaseFirestore.instance
        .collection("Events")
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static void addEvent(Event event) async{
    try {
      var eventRef = getEvents();
      var eventDoc = eventRef.doc();
      event.id = eventDoc.id;
      print("✅ Event added to Firebase successfully with ID: ${event.id}");
      await eventDoc.set(event);
    } catch (e) {
      print("❌ Failed to add event: $e");
    }
  }
}
