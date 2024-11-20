import 'package:app_giang_vien_vku/components/InputComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_form.view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CourseLessonFormWidget extends StatelessWidget {
  CourseLessonFormWidget({super.key, required this.textFieldController});
  final TextEditingController textFieldController;
  List strLoaiDiemDanh = [
    "Điểm danh thường",
    "Điểm danh QR không vị trí",
    "Điểm danh QR với vị trí",
  ];

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   CourseLessonFormViewModel courseLessonFormViewModel = Provider.of<CourseLessonFormViewModel>(context, listen: false);
    //   // courseDetailsViewModel.initDiemDanhForm(courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!.id);
    // });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.md),
          boxShadow: [
            BoxShadow(color: AppColors.black.withOpacity(0.3), blurRadius: 2, offset: const Offset(0.0, 1.0)),
          ],
        ),
        child: Column(
          children: [
            // Tên thông tin
            SizedBox(
              width: double.infinity,
              child: Text(
                "Tạo mới nội dung buổi học",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                    ),
              ),
            ),
            const SizedBox(height: AppSize.spaceBtwItems),
            // Nhập nội dung buổi học
            InputComponent(controller: textFieldController, placeholder: "Nội dung buổi học"),
            const SizedBox(height: AppSize.spaceBtwItems),
            // Nhập loại điểm danh
            DropDownButtonLoaidiemdanh(strLoaiDiemDanh: strLoaiDiemDanh),
            // Nếu là QR thì sẽ hiện cái này
            const SliderTimeForm(),
            const SizedBox(width: AppSize.sm),
          ],
        ),
      ),
    );
  }
}

class DropDownButtonLoaidiemdanh extends StatelessWidget {
  const DropDownButtonLoaidiemdanh({
    super.key,
    required this.strLoaiDiemDanh,
  });

  final List strLoaiDiemDanh;

  @override
  Widget build(BuildContext context) {
    CourseLessonFormViewModel courseLessonFormViewModel = Provider.of<CourseLessonFormViewModel>(context, listen: false);
    (context, listen: false);
    return DropdownButtonFormField(
      hint: Text(
        'Chọn loại điểm danh',
        style: TextStyle(fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd)),
      ),
      items: List.generate(
        3,
        (index) => DropdownMenuItem(
          value: index,
          child: Text(
            strLoaiDiemDanh[index],
            style: TextStyle(
              fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
            ),
          ),
        ),
      ),
      onChanged: (item) {
        courseLessonFormViewModel.setLoaidiemdanh(item!);
      },
    );
  }
}

class SliderTimeForm extends StatelessWidget {
  const SliderTimeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseLessonFormViewModel>(
      builder: (context, value, child) => value.lessonForm.typeRequest == 0
          ? const SizedBox()
          : Column(
              children: [
                const SizedBox(height: AppSize.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.xs),
                  child: Row(
                    children: [
                      Text(
                        "Hạn tồn tại QR",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                            ),
                      ),
                      const SizedBox(width: AppSize.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppSize.sm, vertical: AppSize.sm),
                        decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.6), borderRadius: BorderRadius.circular(AppSize.xs)),
                        child: Text(
                          "${value.lessonForm.thoihan.toString()} phút",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.xs),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      overlayShape: SliderComponentShape.noThumb,
                      trackHeight: AppSize.xs,
                      overlayColor: Colors.transparent,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: AppSize.sm, disabledThumbRadius: 0),
                    ),
                    child: Slider(
                      label: value.lessonForm.thoihan.toString(),
                      min: 5,
                      max: 120,
                      value: value.lessonForm.thoihan,
                      divisions: (120 - 5) ~/ 5,
                      onChanged: (newValue) {
                        value.setThoiHanQR(newValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
