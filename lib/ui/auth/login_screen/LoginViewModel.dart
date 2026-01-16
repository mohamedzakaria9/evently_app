import 'package:evently_app/ui/auth/login_screen/LoginNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../FirebaseUtiles.dart';
import '../../../models/LocalUser.dart';
import '../../../models/User.dart';
import '../../../sharedPreferance/UserSharedPreferance.dart';

class LoginViewModel {
  late LoginNavigator navigator;

  void validate({required String email, required String password}) async {
    try {
      navigator.showLoading(message: "Fetching your data", title: "Loading");
      var credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
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
      navigator.showError(message: "Invalid email or password", title: "Error");
    } catch (e) {
      navigator.showError(message: "Unknown Error", title: "Error");
    }
  }
}
