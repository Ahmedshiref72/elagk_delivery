import 'package:elagk_delivery/drawer/data/models/drawer/menu_item.dart';
import 'package:elagk_delivery/drawer/data/models/drawer/menu_items.dart';
import 'package:elagk_delivery/drawer/presentation/screens/about_us_screen.dart';
import 'package:elagk_delivery/drawer/presentation/screens/contact_us_screen.dart';
import 'package:elagk_delivery/drawer/presentation/screens/profile_screen.dart';
import 'package:elagk_delivery/home/presentation/screens/home_screen.dart';
import 'package:elagk_delivery/shared/global/app_colors.dart';
import 'package:elagk_delivery/shared/local/shared_preference.dart';
import 'package:elagk_delivery/shared/utils/app_constants.dart';
import 'package:elagk_delivery/shared/utils/app_routes.dart';
import 'package:elagk_delivery/shared/utils/app_values.dart';
import 'package:elagk_delivery/shared/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  MyMenuItem currentItem = MenuItems.homepage;

  getScreen(MyMenuItem currentItem) {
    switch (currentItem) {
      case MenuItems.homepage:
        return const HomeScreen();
      case MenuItems.profile:
        return const ProfileScreen();
      case MenuItems.contactUs:
        return const ContactUsScreen();
      case MenuItems.aboutUs:
        return const AboutUsScreen();

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()
      async{
        if (_key.currentState!.isDrawerOpen) {
          Navigator.of(context).pop();
          return false;
        }
        return true;
      },
      child: ZoomDrawer(
        menuBackgroundColor: AppColors.primary,
        isRtl: true,
        menuScreen: Builder(
          builder: (context) => Stack(
            children: [
              MenuScreen(
                currentItem: currentItem,
                onSelectedItem: (item) {
                  setState(() => currentItem = item);
                  ZoomDrawer.of(context)!.close();
                },
              ),
            ],
          ),
        ),
        mainScreenTapClose: false,
        mainScreen: getScreen(currentItem),
        style: DrawerStyle.defaultStyle,
        borderRadius: AppSize.s100,
        angle: AppSize.s0,
        slideWidth: mediaQueryWidth(context) * AppSize.s0_7,
      ),
    );
  }
}
