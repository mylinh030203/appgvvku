import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/utils/imageString.dart';
import 'package:flutter/cupertino.dart';

class BackgroundAppCompoment extends StatelessWidget {
  const BackgroundAppCompoment({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            ImageString.bg_setting, // Đường dẫn đến hình ảnh của bạn
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.backgroundLinearColor1.withOpacity(0.7),
                AppColors.backgroundLinearColor2.withOpacity(0.7),
              ],
            ),
          ),
        ),
        // Nội dung chính
        child
      ],
    );
  }
}
