import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Event.dart';

class FirebaseUtiles {
  static CollectionReference<Event> getEvents() {
    return FirebaseFirestore.instance.collection("Events").withConverter<Event>(
        fromFirestore: (snapshot, options) => Event.fromJson(snapshot.data()!),
        toFirestore: (event, options) => event.toJson()
    );
  }
  //the function of type future void because it takes some time to store the data
  static Future<void> addEventToFireStore(Event event){
    //her we get our collection
    var eventRef = getEvents();
    //here we create a document reference
    DocumentReference<Event> docRef = eventRef.doc();
    event.id = docRef.id;
    print("${docRef.id} this is the id of the added document to the fireStore");
    //here we added the document to the collection
    return docRef.set(event);
  }
}
