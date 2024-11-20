import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseFinalExamWidget extends StatelessWidget {
  const CourseFinalExamWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            // Tên học phần
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Lịch thi học phần",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Utils.toastDev(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
                    decoration: BoxDecoration(color: AppColors.secondPrimary, borderRadius: BorderRadius.circular(AppSize.xs)),
                    child: Text(
                      'Xem Chi tiết',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                          ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.sm),
            Row(
              children: [
                const Icon(CupertinoIcons.calendar, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  'TKB:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Thứ 3 | 15/12/2023',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                )
              ],
            ),
            const SizedBox(height: AppSize.sm),

            Row(
              children: [
                const Icon(CupertinoIcons.time, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Giờ:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  '13h30',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                )
              ],
            ),
            const SizedBox(height: AppSize.sm),
            Row(
              children: [
                const Icon(CupertinoIcons.bookmark, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Hình thức thi:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Vấn đáp',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                )
              ],
            ),
            const SizedBox(height: AppSize.sm),
            Row(
              children: [
                const Icon(CupertinoIcons.placemark, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Phòng thi:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  'KA305',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                )
              ],
            ),
            const SizedBox(height: AppSize.sm),
            Row(
              children: [
                const Icon(CupertinoIcons.flag, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Trạng thái:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Đã kết thúc',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.danger,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                )
              ],
            ),

            const SizedBox(height: AppSize.sm),
            Row(
              children: [
                const Icon(CupertinoIcons.person_2, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  'Hội đồng coi thi:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.sm),

            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: AppSize.xs),
              itemCount: 1,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                  decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.sm)),
                  child: Center(
                    child: Text(
                      'ThS. Trần Đình Sơn',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                          ),
                    ),
                  ),
                );
              },
            ),

            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.md),
            //   decoration: BoxDecoration(color: AppColors.secondPrimary, borderRadius: BorderRadius.circular(AppSize.sm)),
            //   child: Center(
            //     child: Text(
            //       'Xem chi tiết lịch thi',
            //       style: Theme.of(context).textTheme.titleLarge?.copyWith(
            //             color: AppColors.white,
            //             fontWeight: FontWeight.w800,
            //             fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
            //           ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
