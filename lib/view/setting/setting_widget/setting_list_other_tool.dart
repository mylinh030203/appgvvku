import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:flutter/material.dart';

class ListToolWidget extends StatelessWidget {
  const ListToolWidget({super.key, required this.otherTools, required this.controller, required this.iconHeader, required this.text});
  final List otherTools;

  final IconData iconHeader;
  final String text;
  final ScrollController controller;

  void _scrollToSelectedContent(bool isExpanded, double previousOffset, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
      // make sure that your widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      controller.animateTo(isExpanded ? (box.size.height) : previousOffset, duration: Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey expansionTileKey = GlobalKey();
    double previousOffset = 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.circular(AppSize.sm),
        child: ExpansionTile(
          key: expansionTileKey,
          tilePadding: const EdgeInsets.symmetric(horizontal: AppSize.md),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(iconHeader, color: AppColors.secondPrimary, size: AppSize.iconLg),
              const SizedBox(width: AppSize.md),
              Text(
                text,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                    ),
              ),
            ],
          ),
          onExpansionChanged: (isExpanded) {
            if (isExpanded) previousOffset = controller.offset;
            _scrollToSelectedContent(isExpanded, previousOffset, expansionTileKey);
            Future.delayed(const Duration(milliseconds: 100), () {
              controller.animateTo(AppInfo.getScreenHeight(context), duration: const Duration(milliseconds: 500), curve: Curves.linear);
            });
          },
          children: List.generate(otherTools.length, (index) {
            return TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: AppSize.xs)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // No border radius
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                otherTools[index][2]();
              },
              child: ListTile(
                leading: Icon(otherTools[index][0], color: AppColors.secondPrimary),
                title: Text(
                  otherTools[index][1],
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
