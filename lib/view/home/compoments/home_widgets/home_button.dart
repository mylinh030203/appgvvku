import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.iconColor,
    required this.iconSize,
  });
  final IconData icon;
  final Color? iconColor;
  final double iconSize;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkmode(context);
    bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.md),
              color: AppColors.white,
              border: Border.all(width: 1, color: AppColors.gray),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? AppSize.sm : AppSize.md,
              vertical: isSmall ? AppSize.sm : AppSize.md,
            ),
            child: Icon(icon, color: iconColor, size: iconSize),
          ),
        ),
        const SizedBox(height: AppSize.sm),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: isSmall
                  ? 10
                  : isMedium
                      ? 12
                      : 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
