import 'package:evently_app/Routes.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/LocalUser.dart';
import 'package:evently_app/sharedPreferance/UserSharedPreferance.dart';
import 'package:evently_app/ui/profileTap/BottomSheetLanguageStyle.dart';
import 'package:evently_app/ui/profileTap/LanguageContainer.dart';
import 'package:evently_app/utilites/AppFonts.dart';
import 'package:evently_app/utilites/AppImages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/EventsProvider.dart';
import '../../utilites/AppColors.dart';
import 'BottomSheetThemeStyle.dart';
import 'ThemeContainer.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                ),
              ),
              width: width,
              padding: EdgeInsets.symmetric(
                vertical: height * 0.015,
                horizontal: width * 0.03,
              ),
              child: Row(
                children: [
                  Image.asset(AppImages.profilePageImage),
                  SizedBox(width: width*0.03,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalUser.name ?? "Can't load name",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: height*0.005,),
                        Text(
                          LocalUser.email ?? "Can't load email",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BottomSheetLanguageStyle();
                          },
                        );
                      },
                      child: LanguageContainer(),
                    ),
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BottomSheetThemeStyle();
                          },
                        );
                      },
                      child: ThemeContainer(),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redColor,
                        padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.04),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      child: InkWell(
                        onTap: ()async{
                          await FirebaseAuth.instance.signOut();
                          await UserSharedPreferance.setLoggingStatus(false);
                          final eventProvider = Provider.of<EventsProvider>(context, listen: false);
                          eventProvider.clearData();
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(context, Routes.LoginScreen,(route) {
                            return false;
                          },);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: AppColors.whiteColor,
                            ),
                            SizedBox(width: width * 0.02),
                            Text("Logout", style: AppFonts.regular20White),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.04,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
