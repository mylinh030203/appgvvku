import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/view_model/course_attendance/course_attendance.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseAttendanceCard extends StatelessWidget {
  const CourseAttendanceCard({super.key, required this.index, required this.diemDanh});

  final int index;
  final SinhVienDiemDanh diemDanh;

  @override
  Widget build(BuildContext context) {
    CourseAttendanceViewModel courseAttendanceViewModel = Provider.of(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
      decoration: BoxDecoration(color: index % 2 != 0 ? AppColors.white : AppColors.gray.withOpacity(0.75)),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diemDanh.hoTen,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                      ),
                ),
                const SizedBox(height: AppSize.xs),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "MSV: ${diemDanh.maSV}",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                            ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Lớp: ${diemDanh.lopSinhHoat}",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.xs),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Điểm điểm danh: ", // Bold text
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: AppValues.getResponsive(
                            AppSize.fontSizeXs,
                            AppSize.fontSizeSm,
                            AppSize.fontSizeSm,
                          ),
                        ),
                  ),
                  TextSpan(
                    text: "${diemDanh.diemTruDD < 0 ? 0 : diemDanh.diemTruDD}", // Bold text
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.danger,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                        ),
                  ),
                ])),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () => courseAttendanceViewModel.changeLoaiDiemDanh(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppSize.md),
                decoration: BoxDecoration(color: loaiDiemDanhToColor(diemDanh.loaiDiemDanh), borderRadius: BorderRadius.circular(AppSize.xs)),
                child: Center(
                  child: Text(
                    loaiDiemDanhToString(diemDanh.loaiDiemDanh),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Map directly between LoaiDiemDanh and Colors
  static Map<LoaiDiemDanh, Color> loaiDiemDanhColorMap = {
    LoaiDiemDanh.CO_MAT: AppColors.sixthPrimary.withOpacity(0.6),
    LoaiDiemDanh.DI_TRE: AppColors.fifthPrimary,
    LoaiDiemDanh.VANG_PHEP: AppColors.secondPrimary,
    LoaiDiemDanh.VANG: AppColors.danger,
  };

// Map directly between LoaiDiemDanh and Strings
  static Map<LoaiDiemDanh, String> loaiDiemDanhStringMap = {
    LoaiDiemDanh.CO_MAT: "Có mặt",
    LoaiDiemDanh.DI_TRE: "Đi trễ",
    LoaiDiemDanh.VANG_PHEP: "Vắng phép",
    LoaiDiemDanh.VANG: "Vắng",
  };

// Convert LoaiDiemDanh to Color
  static Color loaiDiemDanhToColor(LoaiDiemDanh loaidiemdanh) {
    return loaiDiemDanhColorMap[loaidiemdanh] ?? AppColors.sixthPrimary.withOpacity(0.6); // Default color
  }

// Convert LoaiDiemDanh to String
  static String loaiDiemDanhToString(LoaiDiemDanh loaidiemdanh) {
    return loaiDiemDanhStringMap[loaidiemdanh] ?? "Có mặt"; // Default string
  }
}
