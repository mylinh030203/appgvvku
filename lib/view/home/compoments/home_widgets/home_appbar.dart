import 'package:app_giang_vien_vku/components/AppBarComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/services/namhoc_hocky.service.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';

class HomeAppBarWiget extends StatelessWidget {
  const HomeAppBarWiget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return AppBarComponent(
      leadingIcon: null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Học phần đang học',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.white, fontWeight: FontWeight.w800, fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg)),
          ),
          const SizedBox(height: AppSize.xs),
          Consumer<NamHocHocKyService>(
            builder: (context, value, child) {
              switch (value.dsNamhocHocKy.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator(strokeWidth: AppSize.xs);

                case Status.COMPLETED:
                  return Text('Tuần ${value.tuanHienTai}, thứ ${now.weekday + 1}  ${now.day + 1}/${now.month}/${now.year}',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.w500, color: AppColors.white, fontSize: AppValues.getResponsive(10.0, AppSize.fontSizeMd, AppSize.fontSizeLg)));

                case Status.ERROR:
                  return Text("Error");
              }
            },
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSize.md, top: 5),
          child: GestureDetector(
            onTap: () => showDialogSemester(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.secondPrimary,
              ),
              child: Consumer<HomeViewModel>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.lg,
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Học kỳ ${value.hocky}',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.white, fontSize: AppValues.getResponsive(12.0, 14.0, 15.0)),
                        ),
                        const SizedBox(height: AppSize.xs),
                        Text(
                          '${value.nienKhoa} - ${value.nienKhoa + 1}',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.white, fontSize: AppValues.getResponsive(12.0, 14.0, 15.0)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  showDialogSemester(context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Học kỳ - Năm học",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: AppValues.getResponsive(14.0, 16.0, 16.0)),
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections),
                  Text(
                    "Học kỳ",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.secondPrimary, fontWeight: FontWeight.w800, fontSize: AppValues.getResponsive(14.0, 16.0, 16.0)),
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<HomeViewModel>(
                      builder: (context, value, child) {
                        return DropdownButtonFormField(
                          hint: Text(
                            'Chọn học kỳ',
                            style: TextStyle(fontSize: AppValues.getResponsive(12.0, 14.0, 14.0)),
                          ),
                          items: [
                            DropdownMenuItem(value: 1, child: Text(style: TextStyle(fontSize: AppValues.getResponsive(12.0, 14.0, 14.0)), "Học Kỳ I")),
                            DropdownMenuItem(value: 2, child: Text(style: TextStyle(fontSize: AppValues.getResponsive(12.0, 14.0, 14.0)), "Học Kỳ II")),
                            DropdownMenuItem(value: 0, child: Text(style: TextStyle(fontSize: AppValues.getResponsive(12.0, 14.0, 14.0)), "Học Kỳ Hè")),
                          ],
                          onChanged: (item) {
                            value.hocky = item!;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections),
                  Text(
                    "Năm học",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.secondPrimary, fontWeight: FontWeight.w800, fontSize: AppValues.getResponsive(14.0, 16.0, 16.0)),
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<HomeViewModel>(
                      builder: (context, value, child) {
                        List dsNamhocHocky = value.createDropDownItem();
                        if (value.namHocHocKyService.dsNamhocHocKy.status == Status.COMPLETED) {
                          return DropdownButtonFormField(
                            hint: Text('Chọn năm học', style: TextStyle(fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd))),
                            items: List.generate(
                              dsNamhocHocky.length,
                              (index) => DropdownMenuItem<int>(
                                value: dsNamhocHocky[index][0],
                                child: Text(dsNamhocHocky[index][1], style: const TextStyle(fontSize: (AppSize.fontSizeMd))),
                              ),
                            ),
                            onChanged: (item) {
                              value.nienKhoa = item!;
                            },
                          );
                        }
                        return Text(
                          'Có gì đó hiển thị lỗi',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: AppColors.white,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                              ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections),
                  // Xác nhận button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            homeViewModel.fetchDSHocPhan(homeViewModel.nienKhoa.toString(), homeViewModel.hocky.toString());
                          },
                          child: const Text('Xác nhận'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
