import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/services/namhoc_hocky.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseInfomationWidget extends StatelessWidget {
  const CourseInfomationWidget({super.key, required this.thoiKhoaBieu});
  final ThoiKhoaBieu thoiKhoaBieu;

  @override
  Widget build(BuildContext context) {
    var namhocHockyServices = context.read<NamHocHocKyService>();

    bool isInProgress = namhocHockyServices.tuanHienTai >= thoiKhoaBieu.tuanBatDau && namhocHockyServices.tuanHienTai <= thoiKhoaBieu.tuanKetThuc;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tên học phần
            Row(
              children: [
                Expanded(
                  child: Text(
                    thoiKhoaBieu.tenThoiKhoaBieu,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, 18.0),
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                  child: Text(
                    isInProgress
                        ? 'Đang diễn ra'
                        : namhocHockyServices.tuanHienTai <= thoiKhoaBieu.tuanBatDau
                            ? 'Sắp diễn ra'
                            : 'Đã kết thúc',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: isInProgress ? AppColors.sixthPrimary.withOpacity(0.6) : AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeSm, AppSize.fontSizeMd),
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.sm),
            // TKB Học phần
            Row(
              children: [
                const Icon(CupertinoIcons.time, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Thứ ${thoiKhoaBieu.thu} | Tiết ${thoiKhoaBieu.tietBatDau} -> ${thoiKhoaBieu.tietKetThuc} | Tuần ${thoiKhoaBieu.getDisplayWeek()}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.xs),
            // Phòng học
            Row(
              children: [
                const Icon(CupertinoIcons.location, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  thoiKhoaBieu.phong,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),

            // Row(
            //   children: [
            //     const Icon(CupertinoIcons.person_3, color: AppColors.secondPrimary),
            //     const SizedBox(width: AppSize.sm),
            //     Text(
            //       '80',
            //       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            //             fontWeight: FontWeight.w600,
            //             fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
            //           ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
