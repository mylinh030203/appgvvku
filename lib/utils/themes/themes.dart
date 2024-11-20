import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/app_bar_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/checkbox_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/chip_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/elevated_button_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/expansion_tile_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/outlined_button_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/text_field_theme.dart';
import 'package:app_giang_vien_vku/utils/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    disabledColor: AppColors.gray,
    brightness: Brightness.light,
    primaryColor: AppColors.secondPrimary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColors.eighthPrimary,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    expansionTileTheme: TExpansionTileTheme.lightExpansionTileThemeData,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    disabledColor: AppColors.gray,
    brightness: Brightness.dark,
    primaryColor: AppColors.secondPrimary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: AppColors.backGroundColor,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
