import 'package:app_giang_vien_vku/components/TabBarComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/view/notice/component/cancellation_details.card.dart';
import 'package:app_giang_vien_vku/view/notice/component/make_up_details.card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCancelAndMakeUpWidget extends StatelessWidget {
  // const CourseCancelAndMakeUpWidget({super.key});
  const CourseCancelAndMakeUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> tabName = ['Các buổi báo nghỉ', 'Các buổi báo bù'];
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
            const SizedBox(height: AppSize.sm),
            Consumer<LopHocPhanService>(builder: (context, value, child) {
              switch (value.dsThoiKhoaBieu.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator();
                case Status.COMPLETED:
                  var lengthdsBaoNghi = value.selectedThoiKhoaBieu!.dsBaoNghi.length;
                  var lengthdsBaoBu = value.selectedThoiKhoaBieu!.dsBaoBu.length;
                  return TabControlWidget(listTabName: tabName, height: AppSize.appBarHeight, children: [
                    value.selectedThoiKhoaBieu!.dsBaoNghi.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.only(top: AppSize.md),
                            itemCount: lengthdsBaoNghi,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              var baoNghi = value.selectedThoiKhoaBieu!.dsBaoNghi[index];
                              return CancellationDetailsCard(baoNghi: baoNghi, thoiKhoaBieu: value.selectedThoiKhoaBieu!, index: lengthdsBaoNghi - index - 1);
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSize.md),
                            child: Center(
                              child: Text(
                                "Học phần chưa báo nghỉ buổi học nào",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                                    ),
                              ),
                            ),
                          ),
                    value.selectedThoiKhoaBieu!.dsBaoBu.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.only(top: AppSize.md),
                            itemCount: lengthdsBaoBu,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              var baoBu = value.selectedThoiKhoaBieu!.dsBaoBu[index];
                              return MakeUpDetailsCard(index: lengthdsBaoBu - index - 1, baoBu: baoBu, thoiKhoaBieu: value.selectedThoiKhoaBieu!);
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSize.md),
                            child: Center(
                              child: Text(
                                "Học phần chưa báo bù buổi học nào",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                                    ),
                              ),
                            ),
                          )
                  ]);
                case Status.ERROR:
                  return Container(
                    padding: const EdgeInsets.only(right: AppSize.lg),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Không có học phần vào hôm nay',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w800, color: AppColors.black, fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg)),
                      ),
                    ),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
