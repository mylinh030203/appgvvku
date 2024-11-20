import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';

import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.secondPrimary,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: AppColors.secondPrimary),
      padding: EdgeInsets.symmetric(vertical: AppValues.getResponsive(AppSize.sm, AppSize.sm, AppSize.md)),
      textStyle: TextStyle(fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeSm, AppSize.fontSizeMd), color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blue),
      padding: EdgeInsets.symmetric(vertical: AppValues.getResponsive(AppSize.sm, AppSize.sm, AppSize.md)),
      textStyle: TextStyle(fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeSm, AppSize.fontSizeMd), color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
