import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/view_model/schedule/schedule.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DetailsAppointmentsCalendarWidget extends StatelessWidget {
  const DetailsAppointmentsCalendarWidget({
    super.key,
    required this.appointment,
  });

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    ScheduleViewModel scheduleViewModel = Provider.of<ScheduleViewModel>(context, listen: false);
    return Container(
      decoration: BoxDecoration(color: appointment.color, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(!scheduleViewModel.isDaily ? AppSize.xs : AppSize.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (appointment.notes != null && appointment.notes!.isNotEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSize.xs, vertical: AppSize.xs),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appointment.notes == '0' ? AppColors.fifthPrimary : Colors.red,
                    ),
                    child: Text(appointment.notes == '0' ? 'Nghỉ' : 'Bù',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.white, fontSize: !scheduleViewModel.isDaily ? 10.0 : AppSize.fontSizeMd, fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
            Container(
              color: appointment.color,
              child: Text(
                appointment.subject,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.white, fontSize: !scheduleViewModel.isDaily ? 9.0 : AppSize.fontSizeMd, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              color: appointment.color,
              child: Text(
                "${appointment.location}",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.white, fontSize: !scheduleViewModel.isDaily ? 9.0 : AppSize.fontSizeMd),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
