import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class CourseCancelAndMakeupWidget extends StatelessWidget {
  const CourseCancelAndMakeupWidget({
    super.key,
    required this.thoiKhoaBieu,
  });

  final ThoiKhoaBieu thoiKhoaBieu;

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
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Báo nghỉ - Báo bù",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: () => AppHelperFunctions.navigateToScreenName(context, RoutesName.courseCancelAndMakeUpScreen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
                    decoration: BoxDecoration(color: AppColors.secondPrimary, borderRadius: BorderRadius.circular(AppSize.xs)),
                    child: Text(
                      "Xem chi tiết",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeMd, AppSize.fontSizeMd),
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.xs),
            Row(
              children: [
                const Icon(CupertinoIcons.bookmark, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
                const SizedBox(width: AppSize.sm),
                Text(
                  "Số tiết đã báo nghỉ:",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  "${thoiKhoaBieu.caculateSoTietBaoNghi()}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.fifthPrimary.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
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
                  "Số tiết đã báo bù: ",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeMd),
                      ),
                ),
                const SizedBox(width: AppSize.sm),
                Text(
                  "${thoiKhoaBieu.caculateSoTietBaoBu()}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.fifthPrimary.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
