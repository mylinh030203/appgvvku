import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/view/home/home_screen.dart';
import 'package:app_giang_vien_vku/view/schedule/schedule_screen.dart';
import 'package:app_giang_vien_vku/view/setting/setting.dart';
import 'package:app_giang_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../constants/AppInfo.dart';

// class NavigationMenu extends StatefulWidget {
//   @override
//   _NavigationMenuState createState() => _NavigationMenuState();
// }

class NavigationMenu extends StatelessWidget {
  static const TextStyle optionStyleMedium = TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  static const TextStyle optionStyleSmall = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const ScheduleScreen(),
    Container(),
    Container(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<BotttomNavigatorService>(
        builder: (context, value, child) => Center(
          child: _widgetOptions.elementAt(value.selectedScreenIndex),
        ),
      ),
      bottomNavigationBar: Consumer<BotttomNavigatorService>(
        builder: (context, value, child) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmall ? 5 : 10.0, vertical: 8),
              child: GNav(
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: isSmall ? 5 : 10, vertical: 12),
                //easeInCirc
                //easeInCubic
                //easeInQuad
                curve: Curves.easeInCirc,
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.thirdPrimary,
                color: Colors.black,
                tabs: [
                  GButton(
                    textStyle: isSmall ? optionStyleSmall : optionStyleMedium,
                    icon: CupertinoIcons.home,
                    text: 'Trang chủ',
                  ),
                  GButton(
                    textStyle: isSmall ? optionStyleSmall : optionStyleMedium,
                    icon: CupertinoIcons.calendar,
                    text: 'Lịch',
                  ),
                  GButton(
                    textStyle: isSmall ? optionStyleSmall : optionStyleMedium,
                    rippleColor: AppColors.secondPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    icon: CupertinoIcons.qrcode_viewfinder,
                    text: '',
                    backgroundColor: AppColors.secondPrimary,
                  ),
                  GButton(
                    textStyle: isSmall ? optionStyleSmall : optionStyleMedium,
                    icon: CupertinoIcons.person,
                    text: 'Sinh viên',
                  ),
                  GButton(
                    textStyle: isSmall ? optionStyleSmall : optionStyleMedium,
                    icon: CupertinoIcons.settings,
                    text: 'Cài đặt',
                  ),
                ],
                selectedIndex: value.selectedScreenIndex,
                onTabChange: (index) => value.setScreen(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
