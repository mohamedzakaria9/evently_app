import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/CustomTextFormField.dart';
import 'package:evently_app/ui/home_screen/EventsListView.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';

import '../../utilites/AppColors.dart';
import '../../utilites/AppFonts.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Customtextformfield(
                borderColor: AppColors.appPrimaryColor,
                prefixIcon: AppImages.searchIcon,
                prefixIconColor: AppColors.appPrimaryColor,
                labelText: AppLocalizations.of(context)!.search_for_event,
                labelTextStyle: AppFonts.bold14Primary,
                validate: (text){
                  return null;
                },
              ),
            ),
            Expanded(child: EventsListView()),
          ],
        ),
      ),
    );
  }
}
