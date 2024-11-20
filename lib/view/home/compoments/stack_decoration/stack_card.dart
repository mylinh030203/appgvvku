import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/view/home/compoments/stack_decoration/circular_container.dart';
import 'package:flutter/material.dart';

class HomeStackCardWidget extends StatelessWidget {
  const HomeStackCardWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final stackPos = AppValues.getStackPos();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Positioned(
              bottom: stackPos[0][0],
              right: stackPos[0][1],
              child: TCircularContainer(
                width: AppSize.productImageSize,
                height: AppSize.productImageSize,
                backgroundColor: AppColors.white.withOpacity(0.2),
              )),
          Positioned(
              top: stackPos[1][0],
              left: stackPos[1][1],
              child: TCircularContainer(
                backgroundColor: AppColors.white.withOpacity(0.2),
                width: AppSize.imageThumbSize,
                height: AppSize.imageThumbSize,
              )),
          child
        ],
      ),
    );
  }
}
