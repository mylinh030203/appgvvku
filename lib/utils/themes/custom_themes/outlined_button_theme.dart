import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:flutter/material.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.blue),
          textStyle: TextStyle(fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeSm, AppSize.fontSizeMd), color: Colors.black, fontWeight: FontWeight.w600),
          padding: EdgeInsets.symmetric(vertical: AppValues.getResponsive(AppSize.sm, AppSize.sm, AppSize.md), horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Colors.blueAccent),
          textStyle: TextStyle(fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeSm, AppSize.fontSizeMd), color: Colors.white, fontWeight: FontWeight.w600),
          padding: EdgeInsets.symmetric(vertical: AppValues.getResponsive(AppSize.sm, AppSize.sm, AppSize.md), horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));
}
