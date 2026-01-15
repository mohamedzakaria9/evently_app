import 'package:evently_app/FirebaseUtiles.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/CustomElevatedButton.dart';
import 'package:evently_app/models/CustomTextFormField.dart';
import 'package:evently_app/models/LocalUser.dart';
import 'package:evently_app/providers/ShowHidePasswordProvider.dart';
import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/sharedPreferance/UserSharedPreferance.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../Routes.dart';
import '../../../models/User.dart';
import '../../../utilites/AppColors.dart';
import '../../../utilites/AppFonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    //print("this is print from the build method");
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppImages.appLogo, height: height * 0.3),
                Customtextformfield(
                  textEditingController: emailController,
                  prefixIcon: AppImages.emailIcon,
                  labelText: AppLocalizations.of(context)!.email,
                  validate: (text) {
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text!);
                    if (emailValid) {
                      return null;
                    } else {
                      return "please enter a valid email";
                    }
                  },
                ),
                SizedBox(height: height * 0.03),
                Consumer<ShowHidePasswordProvider>(
                  builder: (context, showHidePasswordProvider, child) {
                    print(
                      "this is print from the consumer of the password provider",
                    );
                    return Customtextformfield(
                      textEditingController: passwordController,
                      prefixIcon: AppImages.passwordIcon,
                      labelText: AppLocalizations.of(context)!.password,
                      isSuffixIcon: true,
                      suffixIcon: AppImages.showHidePasswordIcon,
                      suffixIconOnPress:
                          showHidePasswordProvider.showHidePassword,
                      password: showHidePasswordProvider.isPassword,
                      validate: (text) {
                        if (text!.length < 6) {
                          return "The password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.forget_password}?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.appPrimaryColor,
                        decorationThickness: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                CustomElevatedButton(
                  onPress: validate,
                  content: Text(
                    AppLocalizations.of(context)!.login,
                    style: AppFonts.medium20White,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.do_not_have_an_account}?",
                      style: themeProvider.appTheme == AppTheme.lightTheme
                          ? AppFonts.medium16Black
                          : AppFonts.medium16White,
                    ),
                    SizedBox(width: width * 0.01),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.SignUpScreen);
                        emailController.text = "";
                        passwordController.text = "";
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.appPrimaryColor,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 35,
                        color: AppColors.appPrimaryColor,
                        endIndent: 15,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: AppFonts.medium16Primary,
                    ),
                    Expanded(
                      child: Divider(
                        indent: 15,
                        color: AppColors.appPrimaryColor,
                        endIndent: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                CustomElevatedButton(
                  backGroundColor: Colors.transparent,
                  borderSideColor: AppColors.appPrimaryColor,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.googleIcon),
                      SizedBox(width: width * 0.02),
                      Text(
                        AppLocalizations.of(context)!.login_with_google,
                        style: AppFonts.medium20Primary,
                      ),
                    ],
                  ),
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate()async{
      if (_formKey.currentState!.validate()) {
        try {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.loading,
            title: 'Loading',
            text: 'Fetching your data',
          );
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
          Navigator.pop(context);
          if (context.mounted) {
            Navigator.popAndPushNamed(context, Routes.Home);
          }
        } on FirebaseAuthException {
          if (context.mounted) {
            Navigator.pop(context);
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "Error",
              text: "Invalid email or password",
            );
          }
        } catch (e) {
          if (context.mounted) {
            Navigator.pop(context);
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "Error",
              text: "Unknown Error",
            );
          }
        }
      }
  }
}
