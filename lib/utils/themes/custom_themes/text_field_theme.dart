import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';

import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.gray,
    suffixIconColor: AppColors.gray,
    // constraints: const BoxConstraints.expand(height: AppSize.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: AppSize.fontSizeMd, color: AppColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: AppSize.fontSizeSm, color: AppColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: AppColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.gray),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.gray),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.black),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.danger),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AppColors.danger),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AppColors.gray,
    suffixIconColor: AppColors.gray,
    // constraints: const BoxConstraints.expand(height: AppSize.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: AppSize.fontSizeMd, color: AppColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: AppSize.fontSizeSm, color: AppColors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: AppColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.gray),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.gray),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.danger),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(AppSize.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AppColors.danger),
    ),
  );
}
