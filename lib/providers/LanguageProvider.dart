import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier{
  String localeLanguage = "en";
  void change_language(String language,BuildContext context){
    if(language == AppLocalizations.of(context)!.arabic){
      localeLanguage = "ar";
    }else{
      localeLanguage = "en";
    }
    notifyListeners();
  }
}