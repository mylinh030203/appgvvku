import 'package:app_giang_vien_vku/constants/AppColor.dart';
// ignore: unused_import
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeDividerWidget extends StatelessWidget {
  const HomeDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkmode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Divider(
            color: isDark ? AppColors.gray : AppColors.gray2,
            thickness: 2,
            indent: AppSize.lg,
            endIndent: 5,
          ),
        ),
        Consumer<HomeViewModel>(
          builder: (context, value, child) => GestureDetector(
            onTap: () => value.pressShowMoreButton(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.eighthPrimary),
              child: Icon(value.showMoreButton ? CupertinoIcons.arrowtriangle_up_fill : CupertinoIcons.arrowtriangle_down_fill, size: 20, color: AppColors.secondPrimary),
            ),
          ),
        ),
        Flexible(
          child: Divider(
            color: isDark ? AppColors.gray : AppColors.gray2,
            thickness: 2,
            indent: 5,
            endIndent: AppSize.lg,
          ),
        ),
      ],
    );
  }
}
