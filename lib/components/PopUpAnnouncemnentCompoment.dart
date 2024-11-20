import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpAnnouncementComponent extends StatefulWidget {
  const PopUpAnnouncementComponent({
    super.key,
    required this.bodyText,
    required this.status,
    this.onPress,
    required this.buttonText,
  });

  final Function()? onPress;
  final String buttonText;
  final String bodyText;
  final Status status;

  @override
  State<PopUpAnnouncementComponent> createState() => _PopUpAnnouncementComponentState();
}

class _PopUpAnnouncementComponentState extends State<PopUpAnnouncementComponent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var icon = widget.status == Status.COMPLETED
        ? const Icon(CupertinoIcons.checkmark_alt_circle, size: AppSize.appBarHeight, color: Colors.lightGreen)
        : const Icon(CupertinoIcons.clear_circled, size: AppSize.appBarHeight, color: Colors.redAccent);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.black.withOpacity(0.5),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Center(
            child: Container(
              width: AppInfo.getScreenWidth(context) * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.lg),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(height: AppSize.spaceBtwItems),
                  Text(
                    "Thông báo",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeXl, AppSize.fontSizeXl),
                          color: AppColors.black,
                        ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  Text(
                    widget.bodyText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => widget.onPress!(),
                          child: Text(
                            widget.buttonText,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                                fontSize: AppValues.getResponsive(
                                  AppSize.fontSizeMd,
                                  AppSize.fontSizeLg,
                                  AppSize.fontSizeLg,
                                )),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
