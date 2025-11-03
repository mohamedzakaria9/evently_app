import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferance {

  static getUserId() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("uId");
  }

  static setUserId(String uId) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uId", uId);
  }

  static setLoggingStatus(bool logInStatus) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggingIn", logInStatus);
  }

  static Future<bool?> isLoggedIn() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggingIn");
  }

  static setEmail(String email) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
  }
  static setName(String name) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
  }
  static Future<String?> getEmail() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }
  static Future<String?> getName() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name=  prefs.getString("name");
    return name;
  }
}