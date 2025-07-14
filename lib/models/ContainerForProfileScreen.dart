import 'package:flutter/material.dart';

import '../utilites/AppColors.dart';
class ContainerForProfileScreen extends StatelessWidget {
  Widget child;
  ContainerForProfileScreen({super.key , required this.child});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.appPrimaryColor),
      ),
      child: child
    );;
  }
}
