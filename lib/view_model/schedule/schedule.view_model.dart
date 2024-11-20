import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/baonghi_baobu.local.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';

import 'package:app_giang_vien_vku/utils/utils.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/services/namhoc_hocky.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleViewModel extends ChangeNotifier {
  // Base variable
  final LopHocPhanService hocphanService;
  final NamHocHocKyService namHocHocKyService;

  // Contructor
  ScheduleViewModel({required this.hocphanService, required this.namHocHocKyService});

  final Logger _logger = Logger();

  // Switch vỉew calendar
  bool _isDaily = false;
  bool get isDaily => _isDaily;

  final CalendarController _calendarController = CalendarController();
  CalendarController get calendarController => _calendarController;

  // Thông tin thời gian hiển thịthị
  int _week = 1;
  int _year = 2024;
  int _month = 1;

  int get week => _week;
  int get year => _year;
  int get month => _month;
  DateTime displayDate = DateTime.now();

  double currentIntervalHeight = 60;
  double baseHeight = 60;

  // Trạng thái ds các cuộc hẹn
  List<Appointment> _dsApointment = [];
  List<Appointment> get dsApointment => _dsApointment;

  Status _statusCalendar = Status.LOADING;
  Status get statusCalendar => _statusCalendar;

  // Lấy danh sách các thời khóa biểu trong lớp học phần
  void getAppointments(BuildContext context) {
    _statusCalendar = Status.LOADING;
    notifyListeners();

    try {
      List<Appointment> meetings = <Appointment>[];
      final lengthColors = AppColors.listColorWeeklyCourse.length;
      // var dsThoiKhoaBieu = hocphanService.dsThoiKhoaBieu.dat;

      if (hocphanService.dsThoiKhoaBieu.status == Status.ERROR || hocphanService.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!.isEmpty) {
        _dsApointment = meetings;
        _statusCalendar = Status.COMPLETED;
        Utils.toastWarn("Không có thông tin lớp học phần ", context);
        notifyListeners();
        return;
      }
      List<ThoiKhoaBieu> dsThoiKhoaBieu = hocphanService.dsThoiKhoaBieu.data!.dsThoiKhoaBieu!;

      // // Lấy ngày bất đầu
      // namHocHocKyService.createDsDauTuan();

      int length = dsThoiKhoaBieu.length;

      for (int index = 0; index < length; index++) {
        final color = AppColors.listColorWeeklyCourse[index % lengthColors];
        final tkb = dsThoiKhoaBieu[index];
        final startTime = AppValues.classTimeStart[tkb.tietBatDau - 1].split('h');

        // Thời gian bắt đầu
        final DateTime thoiGianBatDau = namHocHocKyService.dsTuanT2[tkb.tuanBatDau - 1].add(Duration(
          days: tkb.thu - 2,
          hours: int.parse(startTime[0]),
          minutes: int.parse(startTime[1]),
        ));

        final DateTime thoiGianKetThuc = thoiGianBatDau.add(Duration(
          hours: tkb.tietKetThuc + 1 - tkb.tietBatDau,
        ));

        // Lọc lấy danh sách ngày nghỉ
        final dsNgayNghi = getDSNgayNghi(tkb.dsTuanNghi, tkb.dsBaoNghi, tkb.thu);

        genareateCancelAppointment(tkb, meetings, color);

        // Thêm các buổi bù
        getMakeUpAppointment(tkb, meetings, color);

        var newAppointment = Appointment(
          id: tkb.idHocPhan,
          startTime: thoiGianBatDau,
          endTime: thoiGianKetThuc,
          subject: tkb.tenThoiKhoaBieu,
          color: color,
          recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=${AppValues.getWeekday[tkb.thu]};COUNT=${tkb.tuanKetThuc + 1 - tkb.tuanBatDau}",
          recurrenceExceptionDates: dsNgayNghi,
          isAllDay: false,
          location: tkb.phong,
          notes: null,
        );

        meetings.add(newAppointment);
      }

      _dsApointment = meetings;
      _statusCalendar = Status.COMPLETED;
    } catch (e) {
      Utils.toastError(e.toString(), context);
      _statusCalendar = Status.ERROR;
    } finally {
      notifyListeners();
    }
  }

  void genareateCancelAppointment(ThoiKhoaBieu tkb, List<Appointment> meetings, Color color) {
    if (tkb.dsBaoNghi.isNotEmpty) {
      for (var buoiBaoNghi in tkb.dsBaoNghi) {
        final ngayBu = getWeekdayInWeek(buoiBaoNghi.tuanNghi, tkb.thu);
        final startTime = AppValues.groupedTimes[tkb.tietBatDau]!;
        final tgBatdau = ngayBu.add(Duration(
          hours: startTime[0] ~/ 60,
          minutes: startTime[0] % 60,
        ));

        final tgKetThuc = tgBatdau.add(Duration(
          hours: tkb.tietKetThuc + 1 - tkb.tietBatDau,
        ));
        meetings.add(Appointment(
          id: tkb.idHocPhan,
          startTime: tgBatdau,
          endTime: tgKetThuc,
          subject: tkb.tenThoiKhoaBieu,
          color: color,
          isAllDay: false,
          location: tkb.phong,
          notes: '0', // Nghỉ
        ));
      }
    }
  }

  // Tạo các buổi bù trong thời khóa biểu
  void getMakeUpAppointment(ThoiKhoaBieu tkb, List<Appointment> meetings, Color color) {
    if (tkb.dsBaoBu.isNotEmpty) {
      for (var buoibaoBu in tkb.dsBaoBu) {
        // final hocPhanBu = tuanBu.split(','); // [0] : Thứ , [1] : tiết bắt đầu, [2] tiết kết thúc, [3] tuần bù (all Int), [4] Mã phòng
        final ngayBu = getWeekdayInWeek(buoibaoBu.tuanBu, buoibaoBu.thu);
        final startTime = AppValues.groupedTimes[buoibaoBu.tietBatDau]!;
        final tgBatDauBu = ngayBu.add(Duration(
          hours: startTime[0] ~/ 60,
          minutes: startTime[0] % 60,
        ));

        final tgKetThucBu = tgBatDauBu.add(Duration(
          hours: buoibaoBu.tietKetThuc + 1 - buoibaoBu.tietBatDau,
        ));

        meetings.add(Appointment(
          id: tkb.idHocPhan,
          startTime: tgBatDauBu,
          endTime: tgKetThucBu,
          subject: tkb.tenThoiKhoaBieu,
          color: color,
          isAllDay: false,
          location: buoibaoBu.tenPhong,
          notes: '1', // Bù
        ));
      }
    }
  }

  DateTime getWeekdayInWeek(int weekNumber, int weekday) {
    DateTime firstMonday = namHocHocKyService.dsTuanT2[weekNumber - 1];
    DateTime targetDate = firstMonday.add(Duration(days: (weekday - 2)));
    return targetDate;
  }

  List<DateTime> getDSNgayNghi(List<int> tuanNghi, List<BaoNghi> baoNghi, int thu) {
    if (tuanNghi.isEmpty && baoNghi.isEmpty) {
      return [];
    }
    List<int> dsTuanNghi = tuanNghi + baoNghi.map((obj) => obj.tuanNghi).toList();
    List<DateTime> dsNgayNghi = [];
    for (int tuanNghiHoc in dsTuanNghi) {
      var ngayNghi = getWeekdayInWeek(tuanNghiHoc, thu);
      dsNgayNghi.add(ngayNghi);
    }
    return dsNgayNghi;
  }

  changeUIViewDaysorWeekly() {
    _isDaily = !_isDaily;

    notifyListeners();
  }

  selectDisplayDay(context) async {
    final DateTime? datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Container(
          child: child,
        );
      },
    );
    if (datetime != null) {
      displayDate = datetime;
    }
    notifyListeners();
  }

  void onViewChanged(ViewChangedDetails details, DateTime semesterStart) {
    // Get the visible dates from the calendar
    final visibleDates = details.visibleDates;
    if (visibleDates.isNotEmpty) {
      final firstVisibleDate = visibleDates.first;
      displayDate = firstVisibleDate;

      // var timeline = semesterStart.split('-'); //[0 ,1 ,2]
      // DateTime ngaybatdau = DateTime(int.parse(timeline[2]), int.parse(timeline[1]), int.parse(timeline[0]));

      int differenceInDays = firstVisibleDate.difference(semesterStart).inDays + 7;
      _week = differenceInDays ~/ 7;
      _month = firstVisibleDate.month;
      _year = firstVisibleDate.year;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  calendarSelectDisplayTime(BuildContext context) async {
    var datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Thay đổi giá trị mặc định nếu cần
      firstDate: DateTime(2000, 1, 1), // Thay đổi để hợp lý hơn
      lastDate: DateTime(2100, 12, 31),
    );
    if (datePicked != null) calendarController.displayDate = datePicked;
    notifyListeners();
  }

  calendarDisplayTimeNow() async {
    calendarController.displayDate = DateTime.now();
    notifyListeners();
  }
}
