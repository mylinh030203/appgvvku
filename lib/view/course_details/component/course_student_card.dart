import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseSinhvienCard extends StatelessWidget {
  const CourseSinhvienCard({
    super.key,
    required this.indexStudent,
    required this.value,
    required this.index,
    required this.dsSinhViewOptional,
    required this.showCheckBox,
  });
  final bool showCheckBox;
  final dynamic indexStudent;
  final int index;
  final CourseDetailsViewModel value;
  final SinhVienDiemDanh dsSinhViewOptional;

  @override
  Widget build(BuildContext context) {
    Color fontColor = showCheckBox ? AppColors.black : AppColors.secondPrimary;
    Color color = !showCheckBox
        ? AppColors.thirdPrimary.withOpacity(0.4)
        : index % 2 != 0
            ? AppColors.white
            : AppColors.gray.withOpacity(0.7);
    return GestureDetector(
      onTap: () => value.changeCheckbox(indexStudent),
      child: Container(
        color: color,
        child: Row(
          children: [
            if (showCheckBox)
              Checkbox(
                value: dsSinhViewOptional.isCheckBox,
                activeColor: const Color.fromARGB(255, 2, 4, 10),
                tristate: true,
                onChanged: (newBool) => value.changeCheckbox(indexStudent),
              ),
            const SizedBox(width: AppSize.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dsSinhViewOptional.hoTen,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: fontColor,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                      ),
                ),
                const SizedBox(height: AppSize.xs),
                Text(
                  dsSinhViewOptional.maSV,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: fontColor,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ],
            ),
            const SizedBox(width: AppSize.sm),
            if (!showCheckBox) Icon(CupertinoIcons.xmark_circle_fill, color: AppColors.secondPrimary.withOpacity(0.8)),
            const SizedBox(width: AppSize.sm),
          ],
        ),
      ),
    );
  }
}
