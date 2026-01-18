import 'package:evently_app/ui/auth/login_screen/LoginNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../FirebaseUtiles.dart';
import '../../../models/LocalUser.dart';
import '../../../models/User.dart';
import '../../../sharedPreferance/UserSharedPreferance.dart';

class LoginViewModel {
  late LoginNavigator navigator;
  TextEditingController emailController = TextEditingController(text: "mohanad@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "Messi@2015");
  final formKey = GlobalKey<FormState>();

  void validate() async {
    if (formKey.currentState!.validate()) {
      try {
        navigator.showLoading(message: "Fetching your data", title: "Loading");
        var credentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        Users? user = await FirebaseUtiles.getUser(credentials.user!.uid);
        await UserSharedPreferance.setEmail(user!.email);
        await UserSharedPreferance.setName(user.name);
        await UserSharedPreferance.setLoggingStatus(true);
        await UserSharedPreferance.setUserId(user.id);
        LocalUser.name = user.name;
        LocalUser.email = user.email;
        LocalUser.uId = user.id;
        navigator.hideLoading();
        navigator.navigateToHome();
      } on FirebaseAuthException {
        navigator.hideLoading();
        navigator.showError(
          message: "Invalid email or password",
          title: "Error",
        );
      } catch (e) {
        navigator.showError(message: "Unknown Error", title: "Error");
      }
    }
  }
}
