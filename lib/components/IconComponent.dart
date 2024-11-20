import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:flutter/material.dart';

class Iconcomponent extends StatelessWidget {
  final double? size;
  final Widget icon;
  final bool? isCircles;
  final VoidCallback? onPress;
  final Color? background;
  const Iconcomponent({super.key, this.size, required this.icon, this.isCircles, this.onPress, this.background});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background ?? AppColors.gray2,
          shape: isCircles == true ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircles == true ? null : BorderRadius.circular(50.0),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
