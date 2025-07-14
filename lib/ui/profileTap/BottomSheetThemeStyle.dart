import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:evently_app/ui/profileTap/SelectedItem.dart';
import 'package:evently_app/ui/profileTap/UnSelectedItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/AppTheme.dart';

class BottomSheetThemeStyle extends StatelessWidget {
  const BottomSheetThemeStyle({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
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
              provider.changeAppTheme(theme: AppTheme.lightTheme);
            },
            child: (provider.appTheme == AppTheme.lightTheme)
                ? SelectedItem(text: AppLocalizations.of(context)!.light)
                : UnSelectedItem(text: AppLocalizations.of(context)!.light),
          ),
          InkWell(
            onTap: () {
              provider.changeAppTheme(theme: AppTheme.darkTheme);
            },
            child: (provider.appTheme == AppTheme.darkTheme)
                ? SelectedItem(text: AppLocalizations.of(context)!.dark)
                : UnSelectedItem(text: AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }
}
