import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/utils/imageString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingProfileWidget extends StatelessWidget {
  const SettingProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.xs),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSize.sm),
          boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 5, offset: Offset(0.0, 3.0))],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
          child: Row(
            children: [
              CircleAvatar(
                radius: AppSize.iconMd,
                backgroundImage: AssetImage(ImageString.icon_user),
              ),
              SizedBox(width: AppSize.spaceBtwItems),
              Expanded(
                child: Text(
                  'TRẦN VĂN KHOA',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                      ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: AppColors.gray2, shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.chevron_down, size: AppSize.iconMd, color: AppColors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
