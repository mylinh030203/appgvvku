// ignore: must_be_immutable
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/view/course_attendance/compoment/course_attendance_card.dart';
import 'package:app_giang_vien_vku/view/course_attendance/compoment/course_attendance_statistical_card.dart';
import 'package:app_giang_vien_vku/view/course_details/course_details_screen.dart';
import 'package:app_giang_vien_vku/view_model/course_attendance/course_attendance.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';

class CourseAttendantWidget extends StatelessWidget {
  CourseAttendantWidget({super.key});
  bool _isInitialized = false;
  @override
  Widget build(BuildContext context) {
    CourseAttendanceViewModel courseAttendanceViewModel = Provider.of<CourseAttendanceViewModel>(context, listen: false);
    if (!_isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await courseAttendanceViewModel.setSinhvienDiemDanh();

        // Only call this once after the first frame is built
      });
      _isInitialized = true; // Mark as initialized
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.md),
          boxShadow: [
            BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 2, offset: const Offset(0.0, 1.0)),
          ],
        ),
        child: Column(
          children: [
            // Tên thông tin
            SizedBox(
              width: double.infinity,
              child: Text(
                "Điểm danh sinh viên trực tiếp",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),
            const SizedBox(height: AppSize.md),
            Consumer<CourseAttendanceViewModel>(builder: (context, value, child) {
              var dsSinhVien = value.attendanceService.dsSVDiemDanh;
              switch (dsSinhVien.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Text(dsSinhVien.message.toString());
                case Status.COMPLETED:
                  var dsDiemDanh = dsSinhVien.data!.dsSinhVienDiemDanh!;
                  return ListView.builder(
                    itemCount: dsDiemDanh.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CourseAttendanceCard(index: index, diemDanh: dsDiemDanh[index]);
                    },
                  );

                case null:
                  return Container();
                // TODO: Handle this case.
              }
            }),
            const SizedBox(height: AppSize.spaceBtwItems),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Thống kê",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                        ),
                  ),
                ),
                Consumer<CourseAttendanceViewModel>(
                  builder: (context, value, child) => Text(
                    "Sĩ số lớp: ${value.attendanceService.dsSVDiemDanh.status == Status.COMPLETED ? value.attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh!.length : 0}",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                        ),
                  ),
                ),
                const SizedBox(width: AppSize.sm)
              ],
            ),

            const SizedBox(height: AppSize.spaceBtwItems),
            Consumer<CourseAttendanceViewModel>(builder: (context, value, child) {
              var dsSinhVien = value.attendanceService.dsSVDiemDanh;
              if (dsSinhVien.status == Status.COMPLETED) {
                int siso = dsSinhVien.data!.dsSinhVienDiemDanh!.length;
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.sm),
                  itemCount: dsLoaiDiemDanh.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CourseAttendanceStatisticalCard(
                      loaiDiemDanh: dsLoaiDiemDanh[index],
                      soLuongSVByLoai: value.soluongdiemDanh[index],
                      siso: siso,
                    );
                  },
                );
              }
              return const Text("Có lỗi xảy ra");
            }),
          ],
        ),
      ),
    );
  }

  List dsLoaiDiemDanh = [
    LoaiDiemDanh.CO_MAT,
    LoaiDiemDanh.VANG,
    LoaiDiemDanh.VANG_PHEP,
    LoaiDiemDanh.DI_TRE,
  ];
}
