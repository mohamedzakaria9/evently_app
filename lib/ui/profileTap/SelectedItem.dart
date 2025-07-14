import 'package:flutter/material.dart';
import '../../utilites/AppColors.dart';
import '../../utilites/AppFonts.dart';
class SelectedItem extends StatelessWidget {
  String text;
  SelectedItem({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Icon(Icons.check, color: AppColors.appPrimaryColor),
        ],
      ),
    );
  }
}
