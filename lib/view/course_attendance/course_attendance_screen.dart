import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/view/course_attendance/widget/course_attendance_widget.dart';

import 'package:app_giang_vien_vku/view/course_details/widget/course_details_widgets.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CourseAttendanceScreen extends StatelessWidget {
  CourseAttendanceScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarComponent(
              showBackArrow: true,
              isLeadingIconWhite: AppColors.secondPrimary,
              title: Text(
                "Điểm danh học phần",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                      color: AppColors.secondPrimary,
                    ),
              ),
            ),
            // Thông tin cơ bản học phần
            CourseInfomationWidget(thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!),

            // Điểm danh sinh viên trực tiếp
            CourseAttendantWidget(),

            const SizedBox(height: AppSize.md),
          ],
        ),
      ),
      bottomNavigationBar: BotttomButtonsCompoment(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
        outlineString: "Hủy",
        outLinedOnPress: () {},
        elevatedString: "Xác nhận",
        elevatedOnPress: () {},
      ),
    );
  }
}
