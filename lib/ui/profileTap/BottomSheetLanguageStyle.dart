import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/LanguageProvider.dart';
import 'package:evently_app/ui/profileTap/SelectedItem.dart';
import 'package:evently_app/ui/profileTap/UnSelectedItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetLanguageStyle extends StatelessWidget {
  const BottomSheetLanguageStyle({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.change_language(
                AppLocalizations.of(context)!.arabic,
                context,
              );
            },
            child: (provider.localeLanguage == "ar")
                ? SelectedItem(text: AppLocalizations.of(context)!.arabic)
                : UnSelectedItem(text: AppLocalizations.of(context)!.arabic),
          ),
          InkWell(
            onTap: () {
              provider.change_language(
                AppLocalizations.of(context)!.english,
                context,
              );
            },
            child: (provider.localeLanguage == "en")
                ? SelectedItem(text: AppLocalizations.of(context)!.english)
                : UnSelectedItem(text: AppLocalizations.of(context)!.english),
          ),
        ],
      ),
    );
  }
}
