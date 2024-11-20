import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/home/compoments/home_widgets/home_button.dart';
import 'package:app_giang_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

class HomeGridButtonWidget extends StatelessWidget {
  const HomeGridButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final botttomNavigatorService = Provider.of<BotttomNavigatorService>(context, listen: false);
    final settingViewModel = Provider.of<SettingViewModel>(context, listen: false);

    List gridButtonHome = [
      [CupertinoIcons.calendar, "Thời khóa biểu", () => botttomNavigatorService.onRedirectScreen(BottomNavScreen.THOIKHOABIEU)],
      [CupertinoIcons.qrcode_viewfinder, "Quét Mã", () => botttomNavigatorService.onRedirectScreen(BottomNavScreen.QUETQR)],
      [
        CupertinoIcons.person_crop_circle_badge_checkmark,
        "Điểm danh",
        () {
          settingViewModel.setSelectedOption(FunctionOptions.DIEM_DANH);
          AppHelperFunctions.navigateToScreenName(context, RoutesName.course_list);
        }
      ],
      [
        CupertinoIcons.text_bubble,
        "Báo nghỉ",
        () {
          settingViewModel.setSelectedOption(FunctionOptions.BAO_NGHI);
          AppHelperFunctions.navigateToScreenName(context, RoutesName.course_list);
        }
      ],
      [
        CupertinoIcons.pin,
        "Báo bù",
        () {
          settingViewModel.setSelectedOption(FunctionOptions.BAO_BU);
          AppHelperFunctions.navigateToScreenName(context, RoutesName.course_list);
        }
      ],
      [CupertinoIcons.bookmark, "Nhập điểm", () {}],
      [CupertinoIcons.group_solid, "Lớp chủ nhiệm", () {}],
      // [CupertinoIcons.doc_on_doc, "Nhận bảng điểm", () {}],
      // [CupertinoIcons.rectangle_stack_badge_person_crop, "Gửi minh chứng", () {}],
      // [CupertinoIcons.compass, "Khám phá", () {}]
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.md),
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          int itemCount = gridButtonHome.length;
          int crossAxisCount = 4;
          double childAspectRatio = AppValues.getResponsive(0.6, 0.7, 0.75);
          // Chiều cao của mỗi item trong grid, tính dựa trên tỷ lệ và chiều rộng của mỗi item
          double itemHeight = (MediaQuery.of(context).size.width - (AppSize.md * 2)) / crossAxisCount / childAspectRatio;
          int rowCount = (itemCount / crossAxisCount).ceil();
          double expandedHeight = itemHeight * rowCount;
          double collapsedHeight = itemHeight;
          return AnimatedContainer(
            curve: Curves.easeInOut,
            height: value.showMoreButton ? expandedHeight : collapsedHeight,
            width: double.infinity,
            duration: const Duration(milliseconds: 500),
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: AppSize.xs, horizontal: 0),
                shrinkWrap: true,
                itemCount: itemCount,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, childAspectRatio: childAspectRatio),
                itemBuilder: (context, index) {
                  return HomeButtonWidget(
                    icon: gridButtonHome[index][0],
                    iconSize: AppSize.iconMd,
                    iconColor: AppColors.secondPrimary,
                    text: gridButtonHome[index][1],
                    onPressed: gridButtonHome[index][2],
                  );
                }),
          );
        },
      ),
    );
  }
}
