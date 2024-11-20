import 'package:app_giang_vien_vku/components/TextComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:flutter/material.dart';

class Buttoncomponent extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final String? type;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? textFont;
  const Buttoncomponent({super.key, required this.text, this.onPress, this.type = 'link', this.color, this.height, this.width, this.textFont, this.textColor})
      : assert(type == 'primary' || type == 'text' || type == 'link');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: type == "primary"
          ? Container(
              height: height!,
              width: width!,
              decoration: BoxDecoration(color: color ?? AppColors.secondPrimary, shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: TextComponent(fontSize: textFont ?? 20, type: TextType.bold, text: text, color: textColor ?? AppColors.white),
              ),
            )
          : TextComponent(
              fontSize: textFont,
              text: text,
              color: type == "link" ? AppColors.link : textColor ?? AppColors.white,
              type: TextType.semibold,
            ),
    );
  }
}
