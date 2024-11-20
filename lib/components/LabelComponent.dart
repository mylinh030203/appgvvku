import 'package:app_giang_vien_vku/components/TextComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:flutter/material.dart';

class LabelComponent extends StatelessWidget {
  final Color? backgroundColor;
  final TextComponent title;
  final Color? titleColor;
  final bool? isRadius;
  final EdgeInsets? padding;
  const LabelComponent(
      {super.key,
       this.backgroundColor,
      required this.title,
       this.titleColor,
       this.isRadius, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding?? const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: isRadius == true? BorderRadius.circular(20): null),
      child: title,
    );
  }
}
