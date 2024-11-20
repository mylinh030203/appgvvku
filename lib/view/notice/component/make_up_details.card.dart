import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/baonghi_baobu.local.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/services/namhoc_hocky.service.dart';
import 'package:app_giang_vien_vku/view_model/course_notice/course_makeup.view_model.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_giang_vien_vku/view_model/schedule/schedule.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MakeUpDetailsCard extends StatelessWidget {
  const MakeUpDetailsCard({
    super.key,
    required this.baoBu,
    required this.thoiKhoaBieu,
    required this.index,
  });

  final int index;
  final BaoBu baoBu;
  final ThoiKhoaBieu thoiKhoaBieu;

  @override
  Widget build(BuildContext context) {
    var namhocHockyServices = context.read<NamHocHocKyService>();

    bool isInProgress = namhocHockyServices.tuanHienTai < baoBu.tuanBu;
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.md),
      decoration: BoxDecoration(
        color: index % 2 != 0 ? AppColors.white : AppColors.gray3.withOpacity(0.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "TKB: ", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                      TextSpan(
                        text: 'Thứ ${baoBu.thu} | Tiết ${baoBu.tietBatDau} -> ${baoBu.tietKetThuc} | Phòng ${baoBu.tenPhong}', // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Ngày dạy bù: ",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                      TextSpan(
                        text: "${DateFormat('dd-MM-yyyy').format(scheduleViewModel.getWeekdayInWeek(baoBu.tuanBu, baoBu.thu))} (Tuần ${baoBu.tuanBu})", // Bold text
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Số tiết bù: ", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                      TextSpan(
                        text: "${baoBu.tietKetThuc - baoBu.tietBatDau + 1}", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Trạng thái:  ", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                      TextSpan(
                        text: baoBu.trangthai
                            ? isInProgress
                                ? "Đang báo bù"
                                : "Đã hoàn thành"
                            : "Đã Hủy", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: baoBu.trangthai
                                  ? isInProgress
                                      ? AppColors.sixthPrimary
                                      : AppColors.gray4
                                  : AppColors.danger,
                              fontWeight: FontWeight.w800,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (baoBu.trangthai && isInProgress)
            GestureDetector(
              onTap: () => _confirmDeleteMakeUpCourse(context, baoBu),
              child: Container(
                padding: const EdgeInsets.all(AppSize.sm),
                decoration: BoxDecoration(color: AppColors.danger.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                child: const Icon(CupertinoIcons.xmark, color: AppColors.white, size: AppSize.fontSizeXl),
              ),
            ),
          const SizedBox(width: AppSize.xs)
        ],
      ),
    );
  }

  void _confirmDeleteMakeUpCourse(BuildContext context, BaoBu baobu) {
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Xác nhận xóa báo bù học phần ",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, 18),
                ),
          ),
          content: SizedBox(
            width: AppInfo.getScreenWidth(context) * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSize.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "TKB: ", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                      TextSpan(
                        text: 'Thứ ${baoBu.thu} | Tiết ${baoBu.tietBatDau} -> ${baoBu.tietKetThuc} | Phòng ${baoBu.tenPhong}', // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Ngày dạy bù: ",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                      TextSpan(
                        text: "${DateFormat('dd-MM-yyyy').format(scheduleViewModel.getWeekdayInWeek(baoBu.tuanBu, baoBu.thu))} (Tuần ${baoBu.tuanBu})", // Bold text
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.sm),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Số tiết bù: ", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                      TextSpan(
                        text: "${baoBu.tietKetThuc - baoBu.tietBatDau + 1}", // Bold text
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.md),
                BotttomButtonsCompoment(
                    outLinedOnPress: () => Navigator.pop(context),
                    elevatedOnPress: () async {
                      var courseMakeupVM = Provider.of<CourseMakeUpViewModel>(context, listen: false);
                      var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
                      Navigator.pop(context);
                      await courseMakeupVM.deleteCourseMakeUpByApi(index);
                      await homeViewModel.fetchDSHocPhanNoYear();
                    },
                    outlineString: "Hủy",
                    elevatedString: "Xác nhận",
                    padding: const EdgeInsets.only())
              ],
            ),
          ),
        );
      },
    );
  }
}
