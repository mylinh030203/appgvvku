import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/notice/widget/course_cancel_makeup_widget.dart';
import 'package:app_giang_vien_vku/view/course_details/widget/course_details_widgets.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCancelAndMakeUpScreen extends StatelessWidget {
  const CourseCancelAndMakeUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await homeViewModel.fetchDSHocPhan(homeViewModel.nienKhoa.toString(), homeViewModel.hocky.toString());
    // });
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    return Scaffold(
      body: RefreshIndicator(
        edgeOffset: 0,
        color: AppColors.secondPrimary,
        onRefresh: () async => await homeViewModel.fetchDSHocPhanNoYear(),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      AppBarComponent(
                        showBackArrow: true,
                        title: Text(
                          "Thông báo nghỉ học phần",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeXl),
                                color: AppColors.secondPrimary,
                              ),
                        ),
                        isLeadingIconWhite: AppColors.secondPrimary,
                      ),
                      // Thông tin cơ bản học phần
                      CourseInfomationWidget(thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!),

                      // const SpaceComponent(height: AppSize.sm),
                      // CourseCancellationFormWidget(formKey: _formKey),
                      const CourseCancelAndMakeUpWidget()
                    ],
                  ),
                ),
                BotttomButtonsCompoment(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
                  outlineString: "Báo nghỉ",
                  outLinedOnPress: () => AppHelperFunctions.navigateToScreenName(context, RoutesName.cancellationFormNotice),
                  elevatedString: "Báo bù",
                  elevatedOnPress: () async => AppHelperFunctions.navigateToScreenName(context, RoutesName.makeUpFormNotice),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
