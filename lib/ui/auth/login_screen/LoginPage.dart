import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/CustomElevatedButton.dart';
import 'package:evently_app/models/CustomTextFormField.dart';
import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Routes.dart';
import '../../../utilites/AppColors.dart';
import '../../../utilites/AppFonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
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
                Customtextformfield(
                  prefixIcon: AppImages.passwordIcon,
                  labelText: AppLocalizations.of(context)!.password,
                  isSuffixIcon: true,
                  suffixIcon: AppImages.showHidePasswordIcon,
                  password: true,
                  validate: (text) {
                    if (text!.length < 6) {
                      return "The password must be at least 6 characters";
                    } else {
                      return null;
                    }
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
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.popAndPushNamed(context, Routes.Home);
                    }
                  },
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
                      style: themeProvider.appTheme == AppTheme.lightTheme ? AppFonts.medium16Black : AppFonts.medium16White,
                    ),
                    SizedBox(width: width * 0.01),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, Routes.SignUpScreen);
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
                      SizedBox(width: width*0.02,),
                      Text(AppLocalizations.of(context)!.login_with_google,style: AppFonts.medium20Primary,),
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
}
