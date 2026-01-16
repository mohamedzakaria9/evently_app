import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/CustomElevatedButton.dart';
import 'package:evently_app/models/CustomTextFormField.dart';
import 'package:evently_app/providers/ShowHidePasswordProvider.dart';
import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/ui/auth/sign_up_screen/SignUpNavigator.dart';
import 'package:evently_app/ui/auth/sign_up_screen/SignUpViewModel.dart';
import 'package:evently_app/utilites/AlertDialoge.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../../theme/AppTheme.dart';
import '../../../utilites/AppColors.dart';
import '../../../utilites/AppFonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements SignUpNavigator {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordTextEditingControler = TextEditingController();
  TextEditingController emailTextEditingControler = TextEditingController();
  TextEditingController nameTextEditingControler = TextEditingController();
  Signupviewmodel viewModel = Signupviewmodel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.register,
            style: themeProvider.appTheme == AppTheme.lightTheme
                ? TextStyle(color: AppColors.whiteColor)
                : TextStyle(color: AppColors.appPrimaryColor),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: themeProvider.appTheme == AppTheme.lightTheme
                  ? AppColors.blackColor
                  : AppColors.appPrimaryColor,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppImages.appLogo, height: height * 0.2),
              Customtextformfield(
                prefixIcon: AppImages.userNameIcon,
                labelText: AppLocalizations.of(context)!.name,
                textEditingController: nameTextEditingControler,
                validate: (text) {
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              Customtextformfield(
                textEditingController: emailTextEditingControler,
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
              SizedBox(height: height * 0.02),
              Consumer<ShowHidePasswordProvider>(
                builder: (context, showHidePasswordProvider, child) {
                  return Customtextformfield(
                    textEditingController: passwordTextEditingControler,
                    prefixIcon: AppImages.passwordIcon,
                    labelText: AppLocalizations.of(context)!.password,
                    isSuffixIcon: true,
                    suffixIconOnPress:
                        showHidePasswordProvider.showHidePassword,
                    suffixIcon: AppImages.showHidePasswordIcon,
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
              SizedBox(height: height * 0.02),
              Consumer<ShowHidePasswordProvider>(
                builder: (context, showHidePasswordProvider, child) {
                  return Customtextformfield(
                    prefixIcon: AppImages.passwordIcon,
                    labelText: AppLocalizations.of(context)!.re_Password,
                    isSuffixIcon: true,
                    suffixIcon: AppImages.showHidePasswordIcon,
                    suffixIconOnPress:
                        showHidePasswordProvider.showHidePassword,
                    password: showHidePasswordProvider.isPassword,
                    validate: (text) {
                      if (passwordTextEditingControler.text != text) {
                        return "Password don't match";
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                onPress: validate,
                content: Text(
                  AppLocalizations.of(context)!.create_account,
                  style: AppFonts.medium20White,
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.already_have_an_account}?",
                    style: themeProvider.appTheme == AppTheme.lightTheme
                        ? AppFonts.medium16Black
                        : AppFonts.medium16White,
                  ),
                  SizedBox(width: width * 0.01),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppFonts.bold16Primary.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  validate() async {
    {
      if (_formKey.currentState!.validate()) {
        viewModel.validate(
          email: emailTextEditingControler.text,
          password: passwordTextEditingControler.text,
          name: nameTextEditingControler.text,
        );
      }
    }
    ;
  }

  @override
  void hideMessage() {
    // TODO: implement hideMessage
    Navigator.pop(context);
  }

  @override
  void showError(String message) {
    AlertDialoge.showError(context: context, message: message);
  }

  @override
  void showSuccess(String message) {
    AlertDialoge.showSuccess(context: context, message: message);
  }
}
