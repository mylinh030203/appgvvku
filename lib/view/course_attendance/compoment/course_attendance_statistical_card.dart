import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/view/course_attendance/compoment/course_attendance_card.dart';
import 'package:app_giang_vien_vku/view/course_attendance/course_attendance_screen.dart';
import 'package:app_giang_vien_vku/view_model/course_attendance/course_attendance.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseAttendanceStatisticalCard extends StatelessWidget {
  const CourseAttendanceStatisticalCard({
    super.key,
    required this.loaiDiemDanh,
    required this.soLuongSVByLoai,
    required this.siso,
  });
  final LoaiDiemDanh loaiDiemDanh;
  final int soLuongSVByLoai;
  final int siso;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSize.sm),
            decoration: BoxDecoration(color: CourseAttendanceCard.loaiDiemDanhToColor(loaiDiemDanh), borderRadius: BorderRadius.circular(AppSize.xs)),
            child: Center(
              child: Text(
                CourseAttendanceCard.loaiDiemDanhToString(loaiDiemDanh),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSize.md),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSize.sm),
            decoration: BoxDecoration(color: AppColors.gray, borderRadius: BorderRadius.circular(AppSize.xs)),
            child: Center(
              child: Text(
                "$soLuongSVByLoai",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSize.md),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppSize.sm),
            decoration: BoxDecoration(color: AppColors.gray, borderRadius: BorderRadius.circular(AppSize.xs)),
            child: Center(
              child: Text(
                "${double.parse((soLuongSVByLoai / siso * 100).toStringAsFixed(1))} % ",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
