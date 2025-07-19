import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:flutter/material.dart';

import '../../Routes.dart';
import '../../utilites/AppColors.dart';
import '../favorites_screen/FavoritesScreen.dart';
import '../maps_screen/MapsScreen.dart';
import '../profileTap/ProfileTap.dart';
import 'HomeScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    MapsScreen(),
    FavoritesScreen(),
    ProfileTap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.AddEventPage);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(color: AppColors.whiteColor, width: 5),
        ),
        child: ImageIcon(
          AssetImage(AppImages.addIcon),
          size: 40,
          color: AppColors.whiteColor,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          bottomNavigationBarItem(
            icon: currentIndex == 0
                ? AppImages.homeIconFilled
                : AppImages.homeIcon,
            label: AppLocalizations.of(context)!.home,
          ),
          bottomNavigationBarItem(
            icon: currentIndex == 1
                ? AppImages.mapIconFilled
                : AppImages.mapIcon,
            label: AppLocalizations.of(context)!.maps,
          ),
          bottomNavigationBarItem(
            icon: currentIndex == 2
                ? AppImages.heartIconFilled
                : AppImages.heartIcon,
            label: AppLocalizations.of(context)!.favorites,
          ),
          bottomNavigationBarItem(
            icon: currentIndex == 3
                ? AppImages.profileIconFilled
                : AppImages.userIcon,
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }

  BottomNavigationBarItem bottomNavigationBarItem({
    required String icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(icon), color: AppColors.whiteColor),
      label: label,
    );
  }
}
