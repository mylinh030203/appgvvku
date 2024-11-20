import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_giang_vien_vku/components/CustomInputFieldComppment.dart';
import 'package:app_giang_vien_vku/components/PopUpAnnouncemnentCompoment.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/course_details/widget/course_details_widgets.dart';
import 'package:app_giang_vien_vku/view_model/course_notice/course_cancellation.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/components/SpaceComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';

class CancellationScreen extends StatelessWidget {
  CancellationScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    var courseCancelVM = context.read<CourseCancellationViewModel>();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => courseCancelVM.setStatusForm(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppBarComponent(
                          showBackArrow: true,
                          title: Text(
                            "Tạo thông báo nghỉ học phần",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeXl),
                                  color: AppColors.secondPrimary,
                                ),
                          ),
                          isLeadingIconWhite: AppColors.secondPrimary,
                        ),
                        // Thông tin cơ bản học phần
                        CourseInfomationWidget(thoiKhoaBieu: courseDetailsViewModel.hocphanService.selectedThoiKhoaBieu!),

                        const SpaceComponent(height: AppSize.sm),
                        CourseCancellationFormWidget(formKey: _formKey),
                      ],
                    ),
                  ),
                ),
                BotttomButtonsCompoment(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
                  outlineString: "Hủy",
                  outLinedOnPress: () => AppHelperFunctions.navigateback(context),
                  elevatedString: "Xác nhận",
                  elevatedOnPress: () async => await _submitFormCancellation(context),
                ),
              ],
            ),
            Consumer<CourseCancellationViewModel>(
              builder: (context, value, child) {
                switch (value.statusForm) {
                  case Status.COMPLETED:
                    return PopUpAnnouncementComponent(
                      buttonText: "Trở về thông tin báo nghỉ",
                      bodyText: "Tạo thông báo nghỉ thành công",
                      onPress: () async {
                        _onPressRedirect(context);

                        value.setStatusForm();
                      },
                      status: Status.COMPLETED,
                    );

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
                      bodyText: "Rất tiếc! ${value.strError}",
                      onPress: () async => value.setStatusForm(),
                      status: Status.ERROR,
                    );
                  case null:
                    return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _onPressRedirect(BuildContext context) {
    final settingViewModel = Provider.of<SettingViewModel>(context, listen: false);

    settingViewModel.setSelectedOption(FunctionOptions.NONE);
    AppHelperFunctions.navigateRemoveUntil(context, RoutesName.course_details);
    AppHelperFunctions.navigateToScreenName(context, RoutesName.courseCancelAndMakeUpScreen);
  }

  Future<void> _submitFormCancellation(BuildContext context) async {
    CourseCancellationViewModel courseCancelVM = Provider.of<CourseCancellationViewModel>(context, listen: false);
    var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await courseCancelVM.createCourseCancelationByApi();
      await homeViewModel.fetchDSHocPhanNoYear();
    }
  }
}

// ignore: must_be_immutable
class CourseCancellationFormWidget extends StatelessWidget {
  const CourseCancellationFormWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    CourseCancellationViewModel courseCancelViewModel = Provider.of<CourseCancellationViewModel>(context, listen: false);
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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Thông tin tạo báo nghỉ học phần",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                      ),
                ),
              ),
              const SizedBox(height: AppSize.md),
              CustomInputFormFieldCompoment(
                  controller: courseCancelViewModel.tfReason,
                  placeholder: "Lý do báo nghỉ buổi học",
                  allowClear: true,
                  onSaved: (value) => courseCancelViewModel.setCancellationReason(value),
                  validator: (p0) => validateReasonField(p0)),
              const SizedBox(height: AppSize.md),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomInputFormFieldCompoment(
                      controller: courseCancelViewModel.tfCancelWeek,
                      validator: (p0) => courseCancelViewModel.isValidWeek(p0),
                      onChanged: (p0) => courseCancelViewModel.hienthiNgayNghi(p0),
                      onSaved: (value) => courseCancelViewModel.setCancellationWeek(value),
                      placeholder: "Tuần báo nghỉ",
                      isDigitsOnly: true,
                      allowClear: true,
                    ),
                  ),
                  const SizedBox(width: AppSize.spaceBtwItems),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.calendar,
                            size: AppSize.iconMd,
                            color: AppColors.secondPrimary,
                          ),
                          const SizedBox(width: AppSize.sm),
                          Consumer<CourseCancellationViewModel>(
                            builder: (context, value, child) => Text(
                              courseCancelViewModel.ngayNghi != null ? DateFormat('dd-MM-yyyy').format(courseCancelViewModel.ngayNghi!) : "Nhập ngày lại",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeMd),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.md),
              FormField<bool>(
                initialValue: false,
                onSaved: (value) => courseCancelViewModel.setIsSendDaotao(value),
                builder: (FormFieldState<bool> field) {
                  return Row(
                    children: [
                      Checkbox(
                        value: field.value,
                        onChanged: (bool? value) => field.didChange(value),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      Text(
                        'Xác nhận gửi cho phòng đào tạo',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeMd),
                            ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSize.xs),
              FormField<bool>(
                initialValue: false,
                onSaved: (value) => courseCancelViewModel.setIsSendSinhvien(value),
                builder: (FormFieldState<bool> field) {
                  return Row(
                    children: [
                      Checkbox(
                        value: field.value,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (bool? value) => field.didChange(value),
                      ),
                      Text(
                        'Xác nhận gửi thông báo cho sinh viên',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                              fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                            ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateReasonField(String? p0) {
    if (p0 == null || p0.isEmpty) return "Không thể để trống";
    if (p0.length > 256) return "Lý do không quá 256 kỳ tự";
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    CourseCancellationViewModel courseCancelViewModel = Provider.of<CourseCancellationViewModel>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: courseCancelViewModel.ngayNghi ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // support fuction in home_view_model
      courseCancelViewModel.setViewDateSelected(picked);
    }
  }
}
