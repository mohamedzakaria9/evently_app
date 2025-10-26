import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/Event.dart';
import 'package:evently_app/models/User.dart';

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

  static void addEvent(Event event) async {
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

  static CollectionReference<Users> getUsers() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<Users>(
          fromFirestore: (snapshot, options) => Users.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<Users?> getUser(String id) async{
    try{
      var user = await getUsers().doc(id).get();
      if(user.exists){
        return user.data();
      }else{
        return null;
      }
    }catch(e){
      print("there  is an error in the getUser $e");
    }
    return null;
  }

  static Future<void> addUser(Users user) async{
    try {
      var userRef = getUsers();
      await userRef.doc(user.id).set(user);
      print("User added successfully to firestore");
    } catch (e) {
      print("❌ Failed to add user: $e");
    }
  }
}
