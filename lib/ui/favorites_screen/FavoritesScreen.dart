import 'package:evently_app/ui/home_screen/EventsListView.dart';
import 'package:evently_app/utilites/AppFonts.dart';
import 'package:flutter/material.dart';

import '../../utilites/AppColors.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: TextFormField(
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(Icons.search_outlined,color: AppColors.appPrimaryColor,size: 30,),
                      SizedBox(width: 10,),
                      Text("Search For Event",style: AppFonts.bold14Primary,)
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appPrimaryColor),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appPrimaryColor),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            ),
            Expanded(child: EventsListView())
          ],
        ),
      ),
    );
  }
}
