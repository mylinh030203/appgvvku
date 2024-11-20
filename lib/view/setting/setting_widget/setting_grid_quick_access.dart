import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/imageString.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingGridQuickAccessButton extends StatelessWidget {
  SettingGridQuickAccessButton({super.key});
  // final Function(int) onRedirectScreen;

  @override
  Widget build(BuildContext context) {
    final botttomNavigatorService = Provider.of<BotttomNavigatorService>(context, listen: false);
    List gridQuickAcess = [
      [ImageString.calendar_icon, "Thời khóa biểu", () => botttomNavigatorService.onRedirectScreen(BottomNavScreen.THOIKHOABIEU)],
      [ImageString.lop_do_an_icon, "Lớp đồ án", () {}],
      // [ImageString.tien_do_hoc_tap_icon, "Tiến độ học tập", () {}],
      // [ImageString.diem_hoc_phan_icon, "Điểm học phần", () => AppHelperFunctions.navigateToScreenName(context, RoutesName.checkmark)],
      // [ImageString.hoc_phi_icon, "Học phí", () => AppHelperFunctions.navigateToScreenName(context, RoutesName.tuition)],
      // [ImageString.ket_qua_ren_luyen_icon, "Kết quả rèn luyện", () {}],
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
      child: GridView.builder(
          itemCount: gridQuickAcess.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppSize.sm, // Spacing between rows
              crossAxisSpacing: AppSize.sm, // Spacing between columns
              crossAxisCount: 2,
              childAspectRatio: 2),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSize.sm),
                boxShadow: [BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 5, offset: Offset(0.0, 3.0))],
              ),
              child: TextButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSize.md)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // No border radius
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () => gridQuickAcess[index][2](),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(gridQuickAcess[index][0], width: AppSize.iconLg),
                    const SizedBox(height: AppSize.sm),
                    Text(
                      gridQuickAcess[index][1],
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                          ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
