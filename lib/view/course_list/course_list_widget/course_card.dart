import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DSHocPhanCard extends StatelessWidget {
  const DSHocPhanCard({super.key, required this.index, required this.tkb, required this.indexRow, required this.length});
  final int indexRow;
  final int index;
  final int length;
  final ThoiKhoaBieu tkb;

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    int tuanHienTai = getWeekByDay(DateTime.now(), homeViewModel.namHocHocKyService.namhocHockyHienTai!.ngayBatDau);

    bool isInProgress = tuanHienTai >= tkb.tuanBatDau && tuanHienTai <= tkb.tuanKetThuc;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.md),
      decoration: BoxDecoration(
        color: (indexRow + index) % 2 != 0 ? AppColors.white : AppColors.gray3.withOpacity(0.05),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${indexRow + 1}.${index + 1} ${tkb.tenThoiKhoaBieu}",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                          ),
                    ),
                    const SizedBox(height: AppSize.xs),
                    Row(
                      children: [
                        Text(
                          "Trạng thái:",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.sixthPrimary,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                              ),
                        ),
                        const SizedBox(width: AppSize.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                          decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                          child: Text(
                            isInProgress
                                ? 'Đang diễn ra'
                                : tuanHienTai <= tkb.tuanBatDau
                                    ? 'Sắp diễn ra'
                                    : 'Đã kết thúc',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: isInProgress ? AppColors.sixthPrimary.withOpacity(0.6) : AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                                ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: AppSize.sm),
              ElevatedButton(
                onPressed: () {
                  homeViewModel.hocphanService.setThoiKhoaBieu(tkb);
                  AppHelperFunctions.navigateToScreenName(context, RoutesName.course_details);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.md),
                  child: Text(
                    "Lịch trình",
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
          const SizedBox(height: AppSize.md),
          Row(
            children: [
              const Icon(CupertinoIcons.time, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
              const SizedBox(width: AppSize.sm),
              Text(
                'TKB:',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                    ),
              ),
              const SizedBox(width: AppSize.sm),
              Text(
                'Thứ ${tkb.thu} | Tiết ${tkb.tietBatDau} -> ${tkb.tietKetThuc} | Tuần ${tkb.getDisplayWeek()}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                    ),
              )
            ],
          ),
          const SizedBox(height: AppSize.xs),
          Row(
            children: [
              const Icon(CupertinoIcons.placemark, color: AppColors.secondPrimary, size: AppSize.fontSizeXl),
              const SizedBox(width: AppSize.sm),
              Text(
                'Phòng học:',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                    ),
              ),
              const SizedBox(width: AppSize.sm),
              Text(
                tkb.phong,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                    ),
              )
            ],
          ),

          // Row(
          //   children: [
          //     const Icon(CupertinoIcons.person_solid, color: AppColors.secondPrimary),
          //     const SizedBox(width: AppSize.sm),
          //     Text(
          //       'Giảng viên giảng',
          //       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          //             fontWeight: FontWeight.w600,
          //             fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
          //           ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: AppSize.xs),
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
          //   decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
          //   child: Center(
          //     child: Text(
          //       'ThS. Trần Đình Sơn',
          //       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          //             fontWeight: FontWeight.w600,
          //             fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
          //           ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
