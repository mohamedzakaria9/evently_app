import 'package:evently_app/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../models/ContainerForProfileScreen.dart';
import '../../theme/AppTheme.dart';
import '../../utilites/AppColors.dart';
import '../../utilites/AppFonts.dart';
class ThemeContainer extends StatelessWidget {
  ThemeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ContainerForProfileScreen(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          (themeProvider.appTheme == AppTheme.lightTheme)
              ? AppLocalizations.of(context)!.light
              : AppLocalizations.of(context)!.dark,
          style: AppFonts.bold20blue,
        ),
        Icon(
          Icons.arrow_drop_down_outlined,
          size: 30,
          color: AppColors.appPrimaryColor,
        ),
      ],
    ),);
  }
}
