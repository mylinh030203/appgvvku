import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/view/home/compoments/stack_decoration/circular_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/AppInfo.dart';

class HomeCourseCardWidget extends StatelessWidget {
  const HomeCourseCardWidget({super.key, required this.tkb, required this.onPress});

  final ThoiKhoaBieu tkb;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkmode(context);

    bool isSmall = AppInfo.isMobileSmall(context);

    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          color: AppColors.secondPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: isDark ? Colors.white : Colors.black,
                offset: const Offset(0.0, 0.0), //Offset
                blurRadius: 3.0,
                spreadRadius: 0.0), //BoxShadow
            BoxShadow(color: isDark ? Colors.black : Colors.white, offset: const Offset(0.0, 0.0), blurRadius: 2.0, spreadRadius: 1.0), //BoxShadow
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            Positioned(
                bottom: -50,
                right: -10,
                child: TCircularContainer(
                  width: AppSize.productItemHeight,
                  height: AppSize.productItemHeight,
                  backgroundColor: AppColors.white.withOpacity(0.2),
                )),
            Positioned(
                top: -100,
                left: -20,
                child: TCircularContainer(
                  backgroundColor: AppColors.white.withOpacity(0.2),
                  width: AppSize.imageCarouselHeight,
                  height: AppSize.imageCarouselHeight,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.lg, vertical: AppSize.xs),
              child: Column(
                children: [
                  const SizedBox(height: AppSize.spaceBtwItems),
                  // Tên học phần
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${tkb.tenThoiKhoaBieu} ",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppColors.white,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeXl),
                              ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  // Phòng học và Thời gian (Tiết học)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.clock, color: AppColors.white, size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd)),
                            const SizedBox(width: AppSize.sm),
                            Text(
                              "Thứ ${tkb.thu}, ${tkb.tietBatDau} -> ${tkb.tietKetThuc}",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.white, fontSize: isSmall ? 14 : 16),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.placemark,
                              color: AppColors.white,
                              size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                            ),
                            const SizedBox(width: AppSize.xs),
                            Text(
                              tkb.phong,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.white, fontSize: isSmall ? 14 : 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSize.sm),
                  // Lịch theo tuần
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.calendar,
                        color: AppColors.white,
                        size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                      ),
                      const SizedBox(width: AppSize.sm),
                      Text(
                        tkb.getDisplayWeek(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.white, fontSize: isSmall ? 14 : 16),
                      ),
                    ],
                  ),
                  // const SizedBox(height: AppSize.sm),
                  // Tên giảng viên
                  // Row(
                  //   children: [
                  //     Icon(
                  //       CupertinoIcons.person,
                  //       color: AppColors.white,
                  //       size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
                  //     ),
                  //     const SizedBox(width: AppSize.sm),
                  //     Text(
                  //       tkb.giangVienDay,
                  //       style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: AppColors.white, fontSize: isSmall ? 14 : 16),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
