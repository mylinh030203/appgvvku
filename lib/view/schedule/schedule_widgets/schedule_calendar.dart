import 'package:app_giang_vien_vku/components/BottomButtonCompoment.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view/schedule/schedule_widgets/schedule_detaills_appoinment_calendar.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';

import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_giang_vien_vku/view_model/schedule/schedule.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleCalendarViewWidget extends StatelessWidget {
  const ScheduleCalendarViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    var monthDisplay = Padding(
      padding: EdgeInsets.symmetric(horizontal: AppInfo.isMobileSmall(context) ? 5 : AppSize.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Consumer<ScheduleViewModel>(
              builder: (context, scheduleViewModel, child) {
                return Text(
                  "Tuần ${scheduleViewModel.week}, Tháng ${scheduleViewModel.month} Năm ${scheduleViewModel.year}",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondPrimary,
                        fontSize: AppValues.getResponsive(AppSize.fontSizeLg, AppSize.fontSizeXl, AppSize.fontSizeXl),
                      ),
                );
              },
            ),
          ),
          IconButton(
              onPressed: () => scheduleViewModel.calendarSelectDisplayTime(context),
              icon: Icon(
                CupertinoIcons.calendar,
                color: AppColors.secondPrimary,
                size: AppValues.getResponsive(AppSize.iconSm, AppSize.iconMd, AppSize.iconMd),
              ))
        ],
      ),
    );

    var weeklyCalendar = Consumer<ScheduleViewModel>(builder: (context, value, child) {
      switch (value.statusCalendar) {
        case Status.LOADING:
          return const CircularProgressIndicator(
            color: AppColors.primary,
          );
        case Status.ERROR:
          return Text('Error: ');
        case Status.COMPLETED:
          return Consumer<ScheduleViewModel>(builder: (context, scheduleViewModel, child) {
            var view = scheduleViewModel.isDaily ? CalendarView.day : CalendarView.week;
            var numberOfDaysInView = scheduleViewModel.isDaily ? 1 : AppValues.getResponsive(3.0, 7.0, 7.0).toInt();

            return SizedBox(
              height: AppInfo.getScreenHeight(context) - (AppSize.spaceBtwSections * (AppInfo.isMobileSmall(context) ? 5.1 : 6.5)),
              child: SfCalendar(
                view: view,
                controller: scheduleViewModel.calendarController,
                headerHeight: 0,
                firstDayOfWeek: DateTime.monday,
                scheduleViewSettings: const ScheduleViewSettings(weekHeaderSettings: WeekHeaderSettings(height: 4000)),
                monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.indicator, showAgenda: true),
                allowedViews: const <CalendarView>[CalendarView.day, CalendarView.week, CalendarView.month],
                appointmentTextStyle: TextStyle(
                  color: AppColors.white,
                  fontSize: AppValues.getResponsive(AppSize.fontSizeXs, AppSize.fontSizeXs, AppSize.fontSizeXs),
                ),
                timeSlotViewSettings: TimeSlotViewSettings(
                  numberOfDaysInView: numberOfDaysInView,
                  startHour: 6,
                  endHour: 18,
                  timeFormat: 'HH:mm',
                  timeIntervalHeight: AppValues.getResponsive(45.0, 50.0, 55.0),
                ),
                onTap: (calendarTapDetails) => showPopUpDetailsCalendars(calendarTapDetails, context, value),
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.secondPrimary, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  shape: BoxShape.rectangle,
                ),
                onViewChanged: (viewChangedDetails) {
                  // value.getNamhocHocKyHientai(value.nienKhoa);

                  Provider.of<ScheduleViewModel>(context, listen: false).onViewChanged(viewChangedDetails, value.namHocHocKyService.namhocHockyHienTai!.ngayBatDau);
                },
                appointmentBuilder: (context, calendarAppointmentDetails) {
                  final Appointment appointment = calendarAppointmentDetails.appointments.first;

                  return DetailsAppointmentsCalendarWidget(appointment: appointment);
                },
                dataSource: MeetingDataSource(value.dsApointment),
              ),
            );
          });
      }
    });

    return Column(
      children: [
        monthDisplay,
        weeklyCalendar,
      ],
    );
  }

  showPopUpDetailsCalendars(calendarTapDetails, BuildContext context, ScheduleViewModel scheduleViewModel) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Appointment appointment = calendarTapDetails.appointments?.first;

      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Thông tin buổi học',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: AppValues.getResponsive(AppSize.fontSizeMd, AppSize.fontSizeLg, AppSize.fontSizeXl), fontWeight: FontWeight.w800),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.lg, vertical: AppSize.sm),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppSize.sm),
                  Text(
                    'Môn học: ${appointment.subject} \n'
                    'Thời gian: ${DateFormat('HH:mm').format(appointment.startTime)} - ${DateFormat('HH:mm').format(appointment.endTime)} \n'
                    'Phòng: ${appointment.location}\n',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeLg),
                        ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Thoát',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.black,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.sm),
                  ElevatedButton(
                    onPressed: () async => _onPressScheduleAppointment(context, scheduleViewModel, appointment),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Chi tiết Thời khóa biểu',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.white,
                                fontSize: AppValues.getResponsive(AppSize.fontSizeSm, AppSize.fontSizeMd, AppSize.fontSizeMd),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.md),
                ],
              ),
            );
          });
    }
  }

  void _onPressScheduleAppointment(BuildContext context, ScheduleViewModel scheduleVM, Appointment appointment) async {
    final dsTKB = scheduleVM.hocphanService.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!;
    scheduleVM.hocphanService.setThoiKhoaBieu(dsTKB.firstWhere((e) => e.idHocPhan == appointment.id));
    Navigator.of(context).pop();
    AppHelperFunctions.navigateToScreenName(context, RoutesName.course_details);
    CourseDetailsViewModel courseDetailsViewModel = Provider.of<CourseDetailsViewModel>(context, listen: false);
    await courseDetailsViewModel.getLichtrinhHocphan();
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
