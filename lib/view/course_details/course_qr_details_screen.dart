import 'dart:convert';

import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';

import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';

import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/lich_trinh_hoc_phan.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';

import 'package:app_giang_vien_vku/view/course_details/widget/course_details_widgets.dart';

import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class CourseQrDetailsScreen extends StatelessWidget {
  const CourseQrDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarComponent(
              showBackArrow: true,
              isLeadingIconWhite: AppColors.secondPrimary,
              title: Text(
                "Thông tin nội dung buổi học",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                      color: AppColors.secondPrimary,
                    ),
              ),
            ),
            // Thông tin cơ bản học phần
            CourseInfomationWidget(thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!),

            // Thông tin Buổi học
            CourseLesssonDetailsWidget(
              thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!,
              lichTrinhHocPhan: courseDetailsViewModel.courseDetailService.selectedLTHP!,
            )
          ],
        ),
      ),
      bottomNavigationBar: BotttomButtonsCompoment(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
        outlineString: "Điểm danh QR mới",
        outLinedOnPress: () => AppHelperFunctions.navigateback(context),
        elevatedString: "Điểm danh trực tiếp",
        elevatedOnPress: () async {},
      ),
    );
  }
}

class CourseLesssonDetailsWidget extends StatelessWidget {
  const CourseLesssonDetailsWidget({
    super.key,
    required this.thoiKhoaBieu,
    required this.lichTrinhHocPhan,
  });

  final LichTrinhHocPhan lichTrinhHocPhan;
  final ThoiKhoaBieu thoiKhoaBieu;

  @override
  Widget build(BuildContext context) {
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);

    var qrBase64 = courseDetailsViewModel.courseDetailService.qrBase64;

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
            SizedBox(
              width: double.infinity,
              child: Text(
                "Thông tin QR",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),
            const SizedBox(height: AppSize.spaceBtwItems),

            Consumer<CourseDetailsViewModel>(builder: (context, value, child) {
              var ndbh = value.courseDetailService.noidungBuoiHocQR;
              switch (ndbh.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator();

                case Status.COMPLETED:
                  NoidungBuoiHoc nd = ndbh.data!;
                  List thongtinQR = [
                    [CupertinoIcons.doc_plaintext, "Nội dung: ${nd.noiDung}"],
                    if (nd.timeEnd != null) [CupertinoIcons.hourglass_bottomhalf_fill, "Hạn kết thúc:  ${DateFormat('HH:mm:ss dd-MM-yyyy').format(nd.timeEnd!)}"],
                    [CupertinoIcons.bookmark, "Loại QR: ${nd.longtitude == 'z' ? 'Không vị trí' : 'Có vị trí'}"],
                  ];
                  String minutes = value.remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0');
                  String seconds = value.remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: AppSize.xs),
                        itemCount: thongtinQR.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Icon(thongtinQR[index][0], color: AppColors.secondPrimary, size: AppSize.iconSm),
                              const SizedBox(width: AppSize.xs),
                              Text(
                                thongtinQR[index][1],
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                                    ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSize.sm),
                      !value.remainingDuration.isNegative
                          ? RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Thời gian còn lại: ',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                        ),
                                  ),
                                  TextSpan(
                                    text: " $minutes : $seconds ",
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.fifthPrimary,
                                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                        ),
                                  ),
                                ],
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Trạng thái: ',
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                        ),
                                  ),
                                  TextSpan(
                                    text: " Hết thời hạn điểm danh",
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.fifthPrimary,
                                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                        ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  );
                case Status.ERROR:
                  return Text(
                    value.hocphanService.dsThoiKhoaBieu.message.toString(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                        ),
                  );
              }
            }),

            const SizedBox(height: AppSize.md),
            Stack(
              children: [
                Container(
                  color: AppColors.gray.withOpacity(0.2),
                  height: AppValues.getResponsive(150.0, 180.0, 230.0),
                  width: double.infinity,
                  child: qrBase64 == null
                      ? Center(
                          child: Text(
                            "Lỗi xảy ra!. Không có mã QR hiện tại",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                ),
                          ),
                        )
                      : qrBase64.contentBase64 != null
                          ? Image.memory(base64Decode(qrBase64.contentBase64!), fit: BoxFit.contain)
                          : Center(
                              child: Text(
                                "Lỗi xảy ra!. Không có mã QR hiện tại",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                    ),
                              ),
                            ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.gray4.withOpacity(0.7),
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.tray_arrow_down,
                          size: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.md),

            // Cụm button

            PopUpOptionChoiceCompoment(
              onPress: () async {
                await courseDetailsViewModel.courseDetailService.saveDiemDanhSinhvien(lichTrinhHocPhan.id);
                await courseDetailsViewModel.getLichtrinhHocphan();

                final service = FlutterBackgroundService();
                bool idRun = await service.isRunning();
                if (idRun) {
                  service.invoke('stopService');
                }

                AppHelperFunctions.navigateback(context);
              },
              bodyText: "Bạn xác nhận kết thúc điểm danh QR!.",
            ),
            // ElevatedButton(
            //   onPressed: () async {

            //   },
            //   child:
            // ),
            // const SizedBox(height: AppSize.sm),
            // Container(
            //   decoration: BoxDecoration(color: AppColors.thirdPrimary, borderRadius: BorderRadius.circular(AppSize.sm)),
            //   width: double.infinity,
            //   child: TextButton(
            //     style: ButtonStyle(
            //       padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSize.zero, vertical: AppSize.md)),
            //       shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            //         const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.zero, // No border radius
            //         ),
            //       ),
            //       alignment: Alignment.centerLeft,
            //     ),
            //     onPressed: () {},
            //     child: Center(
            //       child: Text(
            //         "Điểm danh với mã QR mới",
            //         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            //               fontWeight: FontWeight.w800,
            //               color: AppColors.secondPrimary,
            //               fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: AppSize.sm),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Center(
            //       child: Text(
            //         "Điểm danh bình thường",
            //         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            //               fontWeight: FontWeight.w800,
            //               color: AppColors.white,
            //               fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
            //             ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class PopUpOptionChoiceCompoment extends StatelessWidget {
  const PopUpOptionChoiceCompoment({super.key, required this.onPress, required this.bodyText});

  final Function() onPress;
  final String bodyText;
  // final bool isError;

  void _showOptionChoiceDialog(BuildContext context) {
    // var icon = !isError
    //     ? Icon(CupertinoIcons.checkmark_alt_circle, size: AppSize.appBarHeight, color: Colors.lightGreen)
    //     : Icon(CupertinoIcons.clear_circled, size: AppSize.appBarHeight, color: Colors.redAccent);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: AppInfo.getScreenWidth(context) * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.lg),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSize.md)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // icon,
                Text(
                  "Thông báo",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                        color: AppColors.black,
                      ),
                ),
                const SizedBox(height: AppSize.spaceBtwItems),
                Text(
                  bodyText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.black,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                      ),
                ),
                const SizedBox(height: AppSize.spaceBtwItems),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => AppHelperFunctions.navigateback(context),
                        child: Text(
                          "Hủy",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.md),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          AppHelperFunctions.navigateback(context);
                          onPress();
                        },
                        child: Text(
                          "Xác nhận",
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showOptionChoiceDialog(context),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            "Kết thúc điểm danh QR",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                ),
          ),
        ),
      ),
    );
  }
}
