import 'package:evently_app/models/ContainerForProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/LanguageProvider.dart';
import '../../utilites/AppColors.dart';
import '../../utilites/AppFonts.dart';

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return ContainerForProfileScreen(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            (languageProvider.localeLanguage == "ar")
                ? AppLocalizations.of(context)!.arabic
                : AppLocalizations.of(context)!.english,
            style: AppFonts.bold20blue,
          ),
          Icon(
            Icons.arrow_drop_down_outlined,
            size: 30,
            color: AppColors.appPrimaryColor,
          ),
        ],
      ),
    );
  }
}
