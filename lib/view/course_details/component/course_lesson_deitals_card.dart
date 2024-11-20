import 'dart:convert';

import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/lich_trinh_hoc_phan.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/utils/utils.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CourseLessonDetailsCard extends StatelessWidget {
  CourseLessonDetailsCard({
    super.key,
    required this.controller,
    required this.index,
    required this.length,
    required this.mapdiemdanh,
    required this.lichTrinhHocPhan,
    required this.tkb,
  });
  final ScrollController controller;
  final int index;
  final int length;
  final Map mapdiemdanh;
  final LichTrinhHocPhan lichTrinhHocPhan;
  final ThoiKhoaBieu tkb;

  void _scrollToSelectedContent(bool isExpanded, double previousOffset, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
      // make sure that your widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      controller.animateTo(isExpanded ? (box.size.height) : previousOffset, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  List<String> popUpMenuItemStr = [
    "Chỉnh sửa nội dung buổi học",
    "Mã QR hiện tại",
    "Điểm danh trực tiếp",
  ];

  @override
  Widget build(BuildContext context) {
    bool isNewCourseLesson = DateTime.now().difference(lichTrinhHocPhan.ngayDay).inDays == 0;

    final courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);

    // final GlobalKey expansionTileKey = GlobalKey();
    // double previousOffset = 0;
    var titleColor = index % 2 == 0 ? AppColors.white : AppColors.gray.withOpacity(0.6);
    var popupMenuButton = PopupMenuButton(
        iconColor: AppColors.black,
        itemBuilder: (context) => List.generate(
              index == 1 && isNewCourseLesson ? popUpMenuItemStr.length : 1,
              (index) => PopupMenuItem(
                value: index,
                child: Text(
                  popUpMenuItemStr[index],
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeMd),
                      ),
                ),
              ),
            ),
        onSelected: (int value) async => await _onPressSelectedTitle(context, value));
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: AppSize.sm),
      backgroundColor: titleColor,
      childrenPadding: const EdgeInsets.only(left: AppSize.sm),
      trailing: popupMenuButton,

      collapsedBackgroundColor: titleColor,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSize.xs),
        child: Text(
          lichTrinhHocPhan.noiDung,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
              ),
        ),
      ),
      subtitle: Row(
        children: [
          const Icon(CupertinoIcons.time, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
          const SizedBox(width: AppSize.xs),
          Text(
            "Ngày dạy: ${DateFormat('dd-MM-yyyy HH:mm:ss').format(lichTrinhHocPhan.ngayDay.add(const Duration(hours: 7)))}",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeMd),
                ),
          ),
        ],
      ),

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Điểm danh sinh viên",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                  ),
            ),
            const SizedBox(height: AppSize.sm),
            Text(
              "SV vắng : ${mapdiemdanh[LoaiDiemDanh.VANG]?.length}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (mapdiemdanh[LoaiDiemDanh.VANG]?.length != 0)
              Text(
                "${mapdiemdanh[LoaiDiemDanh.VANG]?.map((student) => student).join('\n')}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (mapdiemdanh[LoaiDiemDanh.VANG]?.length != 0) const SizedBox(height: AppSize.xs),
            Text(
              "SV đi trễ : ${mapdiemdanh[LoaiDiemDanh.DI_TRE]?.length}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (mapdiemdanh[LoaiDiemDanh.DI_TRE]?.length != 0)
              Text(
                "${mapdiemdanh[LoaiDiemDanh.DI_TRE]?.map((student) => student).join('\n')}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            if (mapdiemdanh[LoaiDiemDanh.DI_TRE]?.length != 0) const SizedBox(height: AppSize.xs),
            Text(
              "SV vắng phép : ${mapdiemdanh[LoaiDiemDanh.VANG_PHEP]?.length}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            if (mapdiemdanh[LoaiDiemDanh.VANG_PHEP]?.length != 0)
              Text(
                "${mapdiemdanh[LoaiDiemDanh.VANG_PHEP]?.map((student) => student).join('\n')}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            const SizedBox(height: AppSize.sm),
          ],
        ),
      ],
      // onExpansionChanged: (isExpanded) {
      //   if (isExpanded) previousOffset = controller.offset;
      //   _scrollToSelectedContent(isExpanded, previousOffset, expansionTileKey);
      //   Future.delayed(const Duration(milliseconds: 100), () {
      //     controller.animateTo(AppInfo.getScreenHeight(context), duration: const Duration(milliseconds: 500), curve: Curves.linear);
      //   });
      // },
    );
  }

  Future<void> _onPressSelectedTitle(BuildContext context, int seletedIndex) async {
    final courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    courseDetailsViewModel.courseDetailService.setSelectedLTHP(index - 1);
    switch (seletedIndex) {
      case 0:
        break;
      case 1:
        AppHelperFunctions.navigateToScreenName(context, RoutesName.course_attendance);
        break;
      case 2:
        await courseDetailsViewModel.getThongTinBuoiHocQR();
        await courseDetailsViewModel.getQrBase64();

        final qrBase64 = courseDetailsViewModel.courseDetailService.qrBase64;
        if (qrBase64 != null && qrBase64.contentBase64 != "") {
          courseDetailsViewModel.startCourseDetailTimer();
          AppHelperFunctions.navigateToScreenName(context, RoutesName.course_lesson_details);
        } else {
          Utils.toastWarn("Không có thông tin điểm danh qr", context);
        }
        break;
    }
  }
}
