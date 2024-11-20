import 'package:app_giang_vien_vku/components/BackgroundAppCompoment.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/view/setting/setting_widget/setting_app_bar.dart';
import 'package:app_giang_vien_vku/view/setting/setting_widget/setting_grid_quick_access.dart';
import 'package:app_giang_vien_vku/view/setting/setting_widget/setting_list_other_tool.dart';
import 'package:app_giang_vien_vku/view/setting/setting_widget/setting_profile.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  final Logger _logger = Logger();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final settingViewModel = Provider.of<SettingViewModel>(context);
    final List otherToolsGrid = [
      [CupertinoIcons.phone, "Liên hệ giảng viên", () {}],
      [CupertinoIcons.archivebox, "Khảo sát ý kiến", () {}],
    ];

    final List otherToolsGrid2 = [
      [CupertinoIcons.archivebox, "Thư góp ý", () {}],
      [CupertinoIcons.hand_thumbsup, "Báo cáo lỗi", () {}],
    ];
    final List otherToolsGrid3 = [];

    return Scaffold(
      body: BackgroundAppCompoment(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu cài đặt
              const SettingAppBarWidget(),
              // Thông tin tài khoản
              const SizedBox(height: AppSize.sm),
              const SettingProfileWidget(),
              const SizedBox(height: AppSize.xs),
              // Các tiện ích nhanh
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
                child: Text(
                  'Các tiện ích nhanh',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeMd, AppSize.fontSizeLg),
                        color: AppColors.white,
                      ),
                ),
              ),
              // Grid các tiện ích nhanh
              SettingGridQuickAccessButton(),
              // Các công cụ khác
              ListToolWidget(
                controller: _scrollController,
                otherTools: otherToolsGrid,
                iconHeader: CupertinoIcons.question_circle_fill,
                text: 'Các công cụ khác',
              ),
              ListToolWidget(
                controller: _scrollController,
                otherTools: otherToolsGrid2,
                iconHeader: CupertinoIcons.question_circle_fill,
                text: 'Hỗ trợ và trợ giúp',
              ),
              ListToolWidget(
                controller: _scrollController,
                otherTools: otherToolsGrid3,
                iconHeader: CupertinoIcons.gear_alt_fill,
                text: "Cài đặt và hiển thị",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.xs, vertical: AppSize.xs),
                child: TextButton(
                  onPressed: () async {
                    await settingViewModel.handleLogout(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.md),
                    decoration: BoxDecoration(
                      color: AppColors.fifthPrimary,
                      borderRadius: BorderRadius.circular(AppSize.sm),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Đăng xuất',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeMd, AppSize.fontSizeLg),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration shadowBoxDecoration() {
    return BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(AppSize.sm),
      boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 5, offset: Offset(0.0, 3.0))],
    );
  }
}
