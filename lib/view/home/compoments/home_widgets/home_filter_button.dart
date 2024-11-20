import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFilterWidget extends StatelessWidget {
  const HomeFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final settingViewModel = Provider.of<SettingViewModel>(context, listen: false);
    return Row(
      children: [
        Expanded(
          child: Text(
            'Học phần của bạn',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeMd, AppSize.fontSizeXl),
                  color: AppColors.secondPrimary,
                ),
          ),
        ),
        IconButton(
          onPressed: () {
            settingViewModel.setSelectedOption(FunctionOptions.NONE);
            AppHelperFunctions.navigateToScreenName(context, RoutesName.course_list);
          },
          icon: Icon(
            CupertinoIcons.list_bullet,
            color: AppColors.secondPrimary,
            size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
          ),
        ),
      ],
    );
  }
}
