import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:flutter/widgets.dart';

enum ScreenSize { SMALL, MEDIUM, LARGE }

class ScreenInfo {
  static final ScreenInfo _instance = ScreenInfo._internal();
  late ScreenSize screenSize;
  late bool isMobileSmall;
  late bool isMobileMedium;

  factory ScreenInfo() {
    return _instance;
  }

  ScreenInfo._internal();

  void initialize(BuildContext context) {
    if (AppInfo.isMobileSmall(context)) screenSize = ScreenSize.SMALL;
    if (AppInfo.isMobileMedium(context)) screenSize = ScreenSize.MEDIUM;
    if (AppInfo.isMobileLarge(context)) screenSize = ScreenSize.LARGE;
  }
}
