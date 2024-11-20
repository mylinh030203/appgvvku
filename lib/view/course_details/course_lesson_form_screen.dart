import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_giang_vien_vku/components/PopUpAnnouncemnentCompoment.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/course_details/widget/course_details_widgets.dart';
import 'package:app_giang_vien_vku/view/course_details/widget/course_lesson_form_widget.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_form.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseLessonFormScreen extends StatelessWidget {
  CourseLessonFormScreen({super.key});
  final TextEditingController inputNoidungBuoiHoc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    CourseLessonFormViewModel courseLessonFormViewModel = Provider.of<CourseLessonFormViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      courseLessonFormViewModel.initDiemDanhForm(courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!.idHocPhan);
    });

    return PopScope(
      onPopInvokedWithResult: (didPop, result) => courseLessonFormViewModel.setStatusForm(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBarComponent(
                          showBackArrow: true,
                          isLeadingIconWhite: AppColors.secondPrimary,
                          title: Text(
                            "Tạo buổi học",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                                  color: AppColors.secondPrimary,
                                ),
                          ),
                        ),
                        // Thông tin cơ bản học phần
                        CourseInfomationWidget(thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!),

                        // Form tạo buổi học
                        CourseLessonFormWidget(textFieldController: inputNoidungBuoiHoc),

                        const SizedBox(height: AppSize.md),
                      ],
                    ),
                  ),
                ),
                BotttomButtonsCompoment(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
                  outlineString: "Hủy",
                  outLinedOnPress: () => AppHelperFunctions.navigateback(context),
                  elevatedString: "Xác nhận",
                  elevatedOnPress: () async => await courseLessonFormViewModel.submitFormCourseLesson(inputNoidungBuoiHoc.text),
                ),
              ],
            ),
            Consumer<CourseLessonFormViewModel>(
              builder: (context, value, child) {
                switch (value.statusFormLesson) {
                  case Status.COMPLETED:
                    switch (courseLessonFormViewModel.lessonForm.typeRequest) {
                      case 0:
                        return PopUpAnnouncementComponent(
                          buttonText: "Tiếp tục điểm danh trực tiếp",
                          bodyText: "Tạo buổi học thành công",
                          onPress: () async {
                            AppHelperFunctions.navigateToScreenAndRemoveUntil(context, RoutesName.course_attendance, RoutesName.course_details);
                            value.setStatusForm();
                          },
                          status: Status.COMPLETED,
                        );
                      case 1:
                      case 2:
                        return PopUpAnnouncementComponent(
                          buttonText: "Chuyển hướng đến mã QR",
                          bodyText: "Tạo buổi học thành công. ",
                          onPress: () async {
                            if (context.mounted) {
                              AppHelperFunctions.navigateToScreenAndRemoveUntil(context, RoutesName.course_lesson_details, RoutesName.course_details);
                            }
                            // await courseDetailsViewModel.getQrBase64();
                            courseDetailsViewModel.startCourseDetailTimer();
                            value.setStatusForm();
                          },
                          status: Status.COMPLETED,
                        );
                    }

                  case Status.LOADING:
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondPrimary,
                        ),
                      ),
                    );
                  case Status.ERROR:
                    return PopUpAnnouncementComponent(
                      buttonText: "Thử lại",
                      bodyText: "Rất tiếc! ${value.errorString}",
                      onPress: () async => value.setStatusForm(),
                      status: Status.ERROR,
                    );
                  case null:
                    return const SizedBox.shrink();
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
