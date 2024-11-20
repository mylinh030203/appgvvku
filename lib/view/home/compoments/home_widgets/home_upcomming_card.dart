import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/view/home/compoments/stack_decoration/stack_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeUpcommingCourseCardWidget extends StatelessWidget {
  const HomeUpcommingCourseCardWidget({
    super.key,
    required this.tkb,
    required this.text,
    required this.backgroundColor,
    required this.statusColor,
    required this.onPress,
  });

  final ThoiKhoaBieu tkb;
  final Color backgroundColor;
  final Color statusColor;
  final Widget text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    // bool isSmall = AppInfo.isMobileSmall(context);

    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        width: AppValues.getResponsive(290.0, 300.0, 320.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: HomeStackCardWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Hiển thị ngày
                const InfoDayMonthUI(),
                // hiển thị thông tin
                InfomationCourseLeftUI(tkb: tkb, statusColor: statusColor, text: text)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoDayMonthUI extends StatelessWidget {
  const InfoDayMonthUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Center(
      child: Stack(
        children: [
          Transform.rotate(
            angle: -15 * 3.1415927 / 180,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: AppValues.getResponsive(2.0, AppSize.xs, AppSize.sm)),
                width: AppValues.getResponsive(55.0, 60.0, 65.0),
                height: AppValues.getResponsive(55.0, 60.0, 65.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: AppValues.getResponsive(2.0, AppSize.xs, AppSize.sm)),
              width: AppValues.getResponsive(55.0, 60.0, 65.0),
              height: AppValues.getResponsive(55.0, 60.0, 65.0),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black12, width: 3), borderRadius: BorderRadius.circular(10)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  '${now.day}',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                      ),
                ),
                SizedBox(height: AppValues.getResponsive(2.0, AppSize.xs, AppSize.xs)),
                Text(
                  'Tháng ${now.month}',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.secondPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeXs, AppSize.fontSizeSm),
                      ),
                )
              ])),
        ],
      ),
    );
  }
}

class InfomationCourseLeftUI extends StatelessWidget {
  const InfomationCourseLeftUI({
    super.key,
    required this.tkb,
    required this.statusColor,
    required this.text,
  });

  final ThoiKhoaBieu tkb;

  final Color statusColor;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  if (tkb.tuanKetThuc == 0)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), // Add padding around the text
                        decoration: BoxDecoration(
                          color: Colors.red, // Background color
                          borderRadius: BorderRadius.circular(4), // Rounded corners
                        ),
                        child: Text(
                          'Bù',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                              ),
                        ),
                      ),
                    ),
                  if (tkb.tuanKetThuc == 0) const WidgetSpan(child: SizedBox(width: AppSize.xs)),
                  TextSpan(
                    text: tkb.tenThoiKhoaBieu,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                        ),
                  ),
                ],
              ),
              textAlign: TextAlign.start,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: AppSize.xs),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(CupertinoIcons.clock_fill, color: AppColors.white, size: AppValues.getResponsive(AppSize.iconXs, AppSize.iconSm, AppSize.iconSm)),
              const SizedBox(width: AppSize.xs),
              // Hiển thị sô lượng người tham gia
              Text("${AppValues.classTimeStart[tkb.tietBatDau - 1]} - ${AppValues.classTimeEnd[tkb.tietKetThuc - 1]}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      )),
            ]),
            const SizedBox(height: AppSize.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.placemark_fill, color: AppColors.white, size: AppValues.getResponsive(AppSize.iconXs, AppSize.iconSm, AppSize.iconSm)),
                // Hiển thị phòng
                const SizedBox(width: AppSize.xs),
                Text(tkb.phong,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                        )),
              ],
            ),
            const SizedBox(height: AppSize.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: statusColor,
              ),
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}
