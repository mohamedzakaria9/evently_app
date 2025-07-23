import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Event.dart';

class FirebaseUtiles {
  static CollectionReference getEvents(){
    return FirebaseFirestore.instance.collection("Events");
  }

  static final eventRef = getEvents().withConverter<Event>(
          fromFirestore:(snapshot, options) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
  );
}
