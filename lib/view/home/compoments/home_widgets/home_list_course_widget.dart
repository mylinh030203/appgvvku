import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/home/compoments/home_widgets/home_course_card.dart';
import 'package:app_giang_vien_vku/view/home/compoments/home_widgets/home_filter_button.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeDSHocPhanWidget extends StatelessWidget {
  const HomeDSHocPhanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Nút lọc danh sách
          const HomeFilterWidget(),
          // Danh sách lớp học phần
          Consumer<LopHocPhanService>(
            builder: (context, value, child) {
              switch (value.dsThoiKhoaBieu.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.dsThoiKhoaBieu.message.toString());
                case Status.COMPLETED:
                  List<ThoiKhoaBieu> dsTKB = value.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!;
                  if (dsTKB.isEmpty) {
                    Text(
                      "Không có thông tin lớp hoc phần trong học kỳ này. Vui lòng chọn học kỳ khác",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                          ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: AppSize.spaceBtwSections),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dsTKB.length,
                    itemBuilder: (context, index) {
                      return HomeCourseCardWidget(
                        tkb: dsTKB[index],
                        onPress: () async => _onPressSelectedCourse(context, dsTKB[index]),
                      );
                    },
                  );
              }
            },
          ),
        ],
      ),
    );
  }

  void _onPressSelectedCourse(BuildContext context, ThoiKhoaBieu tkb) async {
    var lophocphanService = Provider.of<LopHocPhanService>(context, listen: false);
    lophocphanService.setThoiKhoaBieu(tkb);
    AppHelperFunctions.navigateToScreenName(context, RoutesName.course_details);
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    await courseDetailsViewModel.getLichtrinhHocphan();
  }
}
