import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/course_list/course_list_widget/course_card.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';

class ListCourseScreen extends StatelessWidget {
  const ListCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Appbar
            AppBarComponent(
              showBackArrow: true,
              isLeadingIconWhite: AppColors.secondPrimary,
              title: Text(
                _displayHeaderListCourse(context),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                      color: AppColors.secondPrimary,
                    ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search, color: AppColors.secondPrimary)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
              child: Text(
                "Danh sách lớp học phần giảng dạy vào Học kỳ 1 - Năm học 2024-2025",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),

            Consumer<LopHocPhanService>(builder: (context, value, child) {
              switch (value.dsThoiKhoaBieu.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.dsThoiKhoaBieu.message.toString());
                case Status.COMPLETED:
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.md),
                    child: ListView.builder(
                      itemCount: value.dsLopHocPhan.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, indexRow) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 4 != indexRow ? 3 : 0,
                                color: AppColors.secondPrimary,
                              ),
                              bottom: BorderSide(
                                width: 4 - 1 == indexRow ? 3 : 0,
                                color: AppColors.secondPrimary,
                              ),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: value.dsLopHocPhan[indexRow].dsTKB.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var tkb = value.dsLopHocPhan[indexRow].dsTKB[index];
                              return GestureDetector(
                                onTap: () => _onPressCourseDetails(context, tkb),
                                child: DSHocPhanCard(
                                  indexRow: indexRow,
                                  length: value.dsLopHocPhan[indexRow].dsTKB.length,
                                  index: index,
                                  tkb: tkb,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
              }
            }),

            const SizedBox(height: AppSize.md)
          ],
        ),
      ),
    );
  }

  String _displayHeaderListCourse(BuildContext context) {
    final settingViewModel = Provider.of<SettingViewModel>(context, listen: false);

    switch (settingViewModel.selectedOption) {
      case FunctionOptions.NONE:
        return "Học phần giảng dạy";

      case FunctionOptions.DIEM_DANH:
        return "Chọn học phần để điểm danh";

      case FunctionOptions.BAO_NGHI:
        return "Chọn học phần để báo nghỉ";

      case FunctionOptions.BAO_BU:
        return "Chọn học phần để báo bù";
    }
  }

  void _onPressCourseDetails(BuildContext context, ThoiKhoaBieu tkb) {
    final settingViewModel = Provider.of<SettingViewModel>(context, listen: false);
    final hocphanService = context.read<LopHocPhanService>();
    switch (settingViewModel.selectedOption) {
      case FunctionOptions.NONE:
        break;

      case FunctionOptions.DIEM_DANH:
        hocphanService.setThoiKhoaBieu(tkb);
        AppHelperFunctions.navigateToScreenName(context, RoutesName.course_details);
        AppHelperFunctions.navigateToScreenName(context, RoutesName.course_form);
        break;
      case FunctionOptions.BAO_NGHI:
        hocphanService.setThoiKhoaBieu(tkb);
        AppHelperFunctions.navigateToScreenName(context, RoutesName.course_details);
        AppHelperFunctions.navigateToScreenName(context, RoutesName.cancellationFormNotice);
        break;
      case FunctionOptions.BAO_BU:
        hocphanService.setThoiKhoaBieu(tkb);
        AppHelperFunctions.navigateToScreenName(context, RoutesName.course_details);
        AppHelperFunctions.navigateToScreenName(context, RoutesName.makeUpFormNotice);
        break;
    }
  }

  // List<ThoiKhoaBieu>? onDSThoiKhoaBieu(BuildContext context) {
  //   final settingViewModel = Provider.of<SettingViewModel>(context, listen: false);
  //   final thoiKhoaBieuVM = context.read<LopHocPhanService>();
  //   switch (settingViewModel.selectedOption) {
  //     case FunctionOptions.NONE:
  //       return thoiKhoaBieuVM.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!;

  //     case FunctionOptions.DIEM_DANH:
  //       List<ThoiKhoaBieu> dsTKB = List.from(thoiKhoaBieuVM.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!);
  //       int todayThu = DateTime.now().weekday;
  //       List<ThoiKhoaBieu> sortedTkb = dsTKB.where((tkb) => tkb.thu == todayThu).toList() + dsTKB.where((tkb) => tkb.thu != todayThu).toList();
  //       return sortedTkb;

  //     case FunctionOptions.BAO_NGHI:
  //       List<ThoiKhoaBieu> dsTKB = List.from(thoiKhoaBieuVM.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!);
  //       int todayThu = DateTime.now().weekday;
  //       List<ThoiKhoaBieu> sortedTkb = dsTKB.where((tkb) => tkb.thu == todayThu).toList() + dsTKB.where((tkb) => tkb.thu != todayThu).toList();
  //       return sortedTkb;

  //     case FunctionOptions.BAO_BU:
  //       List<ThoiKhoaBieu> dsTKB = List.from(thoiKhoaBieuVM.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!);
  //       var list = dsTKB.where((tkb) => tkb.caculateSoTietBaoNghi() <= tkb.caculateSoTietBaoBu()).toList();
  //       return list;
  //   }
  // }
}
