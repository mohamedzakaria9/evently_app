import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../utilites/AppFonts.dart';
class UnSelectedItem extends StatelessWidget {
  String text;
  UnSelectedItem({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
