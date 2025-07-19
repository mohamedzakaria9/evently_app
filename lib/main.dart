import 'package:evently_app/Routes.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/LanguageProvider.dart';
import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/theme/AppTheme.dart';
import 'package:evently_app/ui/add_event_page/AddEventPage.dart';
import 'package:evently_app/ui/auth/login_screen/LoginPage.dart';
import 'package:evently_app/ui/auth/sign_up_screen/SignUpPage.dart';
import 'package:evently_app/ui/favorites_screen/FavoritesScreen.dart';
import 'package:evently_app/ui/home_screen/Home.dart';
import 'package:evently_app/ui/home_screen/HomeScreen.dart';
import 'package:evently_app/ui/maps_screen/MapsScreen.dart';
import 'package:evently_app/ui/profileTap/ProfileTap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: {
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      },
      locale: Locale(provider.localeLanguage),
      supportedLocales: [Locale("en"), Locale("ar")],
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.Home,
      routes: {
        Routes.Home: (context) => Home(),
        Routes.HomeScreen: (context) => HomeScreen(),
        Routes.ProfileTap: (context) => ProfileTap(),
        Routes.FavoritesScreen: (context) => FavoritesScreen(),
        Routes.MapsScreen: (context)=>MapsScreen(),
        Routes.LoginScreen: (context)=>LoginPage(),
        Routes.SignUpScreen:(context)=>SignUpPage(),
        Routes.AddEventPage:(context)=>AddEventPage()
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: (themeProvider.appTheme == AppTheme.lightTheme)
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }
}
