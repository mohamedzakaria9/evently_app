import 'package:evently_app/ui/auth/sign_up_screen/SignUpNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../FirebaseUtiles.dart';
import '../../../models/User.dart';

class Signupviewmodel {
  late SignUpNavigator navigator;
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordTextEditingControler = TextEditingController();
  TextEditingController emailTextEditingControler = TextEditingController();
  TextEditingController nameTextEditingControler = TextEditingController();

  void validate() async {
    if (formKey.currentState!.validate()) {
      try {
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailTextEditingControler.text,
              password: passwordTextEditingControler.text,
            );
        Users user = Users(
          id: credentials.user!.uid,
          name: nameTextEditingControler.text,
          email: emailTextEditingControler.text,
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
}
