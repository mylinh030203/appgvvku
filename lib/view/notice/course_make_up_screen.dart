import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_giang_vien_vku/components/CustomInputFieldComppment.dart';
import 'package:app_giang_vien_vku/components/PopUpAnnouncemnentCompoment.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/course_details/widget/course_details_widgets.dart';
import 'package:app_giang_vien_vku/view/notice/component/make_up_details.card.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_notice/course_makeup.view_model.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/components/SpaceComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:provider/provider.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';

class CourseMakeUpCnScreen extends StatelessWidget {
  CourseMakeUpCnScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    var makeupFormViewModel = context.read<CourseMakeUpViewModel>();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) => makeupFormViewModel.setStatusForm(),
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
                            "Tạo báo bù học phần",
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
                        CourseMakeUpFormWidget(formKey: _formKey)
                      ],
                    ),
                  ),
                ),
                BotttomButtonsCompoment(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.md, vertical: AppSize.md),
                  outlineString: "Hủy",
                  outLinedOnPress: () => AppHelperFunctions.navigateback(context),
                  elevatedString: "Xác nhận",
                  elevatedOnPress: () async => await _submitFormMakeUp(context),
                ),
              ],
            ),
            Consumer<CourseMakeUpViewModel>(
              builder: (context, value, child) {
                switch (value.statusForm) {
                  case Status.COMPLETED:
                    return PopUpAnnouncementComponent(
                      buttonText: "Trở về thông tin báo nghỉ",
                      bodyText: "Tạo thông báo bù thành công",
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

  Future<void> _submitFormMakeUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var courseCancelVM = Provider.of<CourseMakeUpViewModel>(context, listen: false);
      var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
      await courseCancelVM.createCourseMakeUpByApi();
      await homeViewModel.fetchDSHocPhanNoYear();
    }
  }
}

class CourseMakeUpFormWidget extends StatelessWidget {
  const CourseMakeUpFormWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final courseMakeUpViewModel = context.read<CourseMakeUpViewModel>();
    // final List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Thông tin tạo báo bù buổi học",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeLg),
                      ),
                ),
              ),
              const SizedBox(height: AppSize.md),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Chọn ngày bù",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ),
              const SizedBox(height: AppSize.md),
              CustomInputFormFieldCompoment(
                controller: courseMakeUpViewModel.tfDateMakeUp,
                validator: (p0) => courseMakeUpViewModel.isValidDate(p0),
                onSaved: (value) => courseMakeUpViewModel.setDateMakeUp(value),
                placeholder: "Ngày báo bù",
                suffix: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: const Icon(
                    CupertinoIcons.calendar,
                    size: AppSize.iconMd,
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.sm),
              Consumer<CourseMakeUpViewModel>(
                builder: (context, value, child) => value.ngayBaoBu == null
                    ? const SizedBox.shrink()
                    : value.ngayBaoBu!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: AppSize.xs),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Thông tin:  ", // Bold text
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                                        ),
                                  ),
                                  TextSpan(
                                    text: value.ngayBaoBu, // Bold text
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: AppColors.sixthPrimary,
                                          fontWeight: FontWeight.w800,
                                          fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeSm),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: AppSize.sm),
                            child: Text(
                              "Nhập lại ngày báo bù!",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.fifthPrimary,
                                    fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeSm, AppSize.fontSizeMd),
                                  ),
                            ),
                          ),
              ),
              const SizedBox(height: AppSize.sm),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Chọn tiết bắt đầu và tiết kết thúc",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ),
              const SizedBox(height: AppSize.md),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<List<int>>(
                      value: courseMakeUpViewModel.listTiet,
                      decoration: const InputDecoration(
                        labelText: 'Chọn tiết báo bù',
                        border: OutlineInputBorder(),
                      ),
                      items: courseMakeUpViewModel.optionsTiet.map((List<int> value) {
                        return DropdownMenuItem<List<int>>(
                          value: value,
                          child: Text(
                            "Tiết ${value[0]} - Tiết ${value[1]}",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                ),
                          ),
                        );
                      }).toList(),
                      onSaved: (newValue) => courseMakeUpViewModel.setSeletedTietForm(newValue),
                      onChanged: (List<int>? newValue) => courseMakeUpViewModel.setSelectedTiet(newValue),
                      menuMaxHeight: AppValues.getResponsive(112, 168, 224),
                      itemHeight: AppSize.appBarHeight,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an option';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Consumer<CourseMakeUpViewModel>(
                      builder: (context, value, child) => Center(
                        child: Text(
                          value.strThoigianTiet ?? "null",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeMd, AppSize.fontSizeLg),
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.md),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Chọn phòng báo dạy bù",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                      ),
                ),
              ),
              const SizedBox(height: AppSize.md),
              DropdownButtonFormField<String>(
                value: courseMakeUpViewModel.form.phongHoc,
                decoration: const InputDecoration(
                  labelText: 'Chọn phòng báo dạy bù',
                  border: OutlineInputBorder(),
                ),
                items: courseMakeUpViewModel.optionsPhong.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                          ),
                    ),
                  );
                }).toList(),
                onSaved: (newValue) => courseMakeUpViewModel.setSeletedPhong(newValue),
                onChanged: (String? newValue) => courseMakeUpViewModel.setSeletedPhong(newValue),
                menuMaxHeight: AppValues.getResponsive(112, 168, 224),
                itemHeight: AppSize.appBarHeight,
                validator: (value) {
                  if (value == null) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    CourseMakeUpViewModel courseCancelViewModel = Provider.of<CourseMakeUpViewModel>(context, listen: false);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // support fuction in home_view_model
      courseCancelViewModel.setViewDateSelected(picked);
    }
  }
}
