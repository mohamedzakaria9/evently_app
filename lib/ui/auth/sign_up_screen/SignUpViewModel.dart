import 'package:evently_app/ui/auth/sign_up_screen/SignUpNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../FirebaseUtiles.dart';
import '../../../models/User.dart';

class Signupviewmodel{
  late SignUpNavigator navigator;
  void validate({required String email,required String password,required String name}) async{
    try {
      var credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Users user = Users(
        id: credentials.user!.uid,
        name: name,
        email: email,
      );
      FirebaseUtiles.addUser(user);
      navigator.showSuccess("Email Created Successfully!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.showError("Weak Password");
        //print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator.showError("The account already exists for that email.");
      }
    } catch (e) {
      navigator.showError("Error can't create Email");
      print(e.toString());
    }
  }
}