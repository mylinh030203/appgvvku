import 'package:app_giang_vien_vku/components/IconComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/AppColor.dart';
import '../constants/AppInfo.dart';
import '../utils/styles/globalStyle.dart';

class ContainerComponent extends StatelessWidget {
  const ContainerComponent({
    super.key,
    required this.children,
    this.title,
    this.isScroll = false,
    this.isBack = false,
    this.isCenter = false,
    this.padding,
    this.customHeader,
    this.leading,
  });

  final List<Widget> children;
  final String? title;
  final bool isScroll;
  final Widget? leading;
  final bool isBack;
  final bool isCenter;
  final EdgeInsets? padding;
  final Widget? customHeader;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        top: title != null || isBack ? false : true,
        child: headerComponent(context),
      ),
    );
  }

  Widget headerComponent(BuildContext context) {
    return customHeader != null
        ? Column(
            children: [customHeader!, buildContainer()],
          )
        : Column(
            children: [
              if (title != null || isBack)
                Container(
                  height: title != null || isBack ? AppInfo.getScreenHeight(context) * 0.11 : AppInfo.getScreenHeight(context) * 0.08,
                  padding: EdgeInsets.only(top: title != null || isBack ? 20 : 10, left: 10),
                  child: Center(
                    child: Stack(
                      children: [
                        if (leading != null) Positioned(right: 10, top: 0, bottom: 0, child: leading!),
                        if (isBack)
                          Positioned(
                            left: 10,
                            top: 0,
                            bottom: 0,
                            child: Iconcomponent(
                              size: 40,
                              isCircles: true,
                              onPress: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(CupertinoIcons.back, color: AppColors.black, size: 30),
                            ),
                          ),
                        if (title != null)
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              title!,
                              style: GlobalStyle.textHeaderStyle.merge(
                                const TextStyle(color: AppColors.black),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              buildContainer()
            ],
          );
  }

  Widget buildContainer() {
    // print("cos $isScroll");
    return Expanded(
      child: isScroll
          ? Padding(
              padding: padding ?? EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: children,
                ),
              ),
            )
          : Padding(
              padding: padding ?? EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: children,
              ),
            ),
    );
  }
}
