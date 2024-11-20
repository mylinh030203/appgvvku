import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/view/home/compoments/curved_edges/curved_edges_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    required this.child,
    super.key,
    this.height,
    this.backgroundImage,
    this.opacity,
    this.colorHeader,
  });
  final double? height;
  final double? opacity;
  final Color? colorHeader;
  final Image? backgroundImage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: colorHeader ?? AppColors.secondPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        height: height ?? 320,
        child: Stack(
          children: [
            if (backgroundImage != null) Positioned.directional(start: 0, end: 0, textDirection: TextDirection.rtl, child: backgroundImage!),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.secondPrimary.withOpacity(0.35),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.black.withOpacity(opacity ?? 0),
            ),

            /// Background custom settings
            child,
          ],
        ),
      ),
    );
  }
}
