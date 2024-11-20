import 'package:app_giang_vien_vku/components/AppBarComponent.dart';

import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/utils/imageString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingAppBarWidget extends StatelessWidget {
  const SettingAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarComponent(
      title: Container(
        padding: EdgeInsets.only(top: AppSize.sm),
        child: Image.asset(ImageString.vku_logo, width: AppSize.iconLg * 2.7, height: AppSize.iconLg * 1.2, fit: BoxFit.fill),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.gear_alt_fill, color: AppColors.white)),
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search, color: AppColors.white)),
      ],
    );
  }
}
