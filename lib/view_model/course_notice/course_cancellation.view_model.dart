import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/course_cancellation_request.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_giang_vien_vku/services/course.service.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/services/namhoc_hocky.service.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CourseCancellationViewModel with ChangeNotifier {
  final LopHocPhanService hocphanService;

  final NamHocHocKyService _namhocHockyService;
  final LichtrinhHocPhanRepository _lichtrinhHocPhanRepoImpl;
  final BaseLocal<String> _jwtTokenBox;

  // Contructor
  CourseCancellationViewModel({
    required this.hocphanService,
    required lichtrinhHocPhanRepoImpl,
    required jwtTokenBox,
    required namHocHockyService,
  })  : _lichtrinhHocPhanRepoImpl = lichtrinhHocPhanRepoImpl,
        _jwtTokenBox = jwtTokenBox,
        _namhocHockyService = namHocHockyService;

  final tfReason = TextEditingController();
  final tfCancelWeek = TextEditingController();

  // GlobalKey<FormState> get formKey => _formKey;

  CourseCancellationFormRequest _form = CourseCancellationFormRequest.defaultConstructor();
  CourseCancellationFormRequest get form => _form;

  Status? _statusForm;
  Status? get statusForm => _statusForm;
  String? strError;
  DateTime? ngayNghi;

  Future<void> createCourseCancelationByApi() async {
    _statusForm = Status.LOADING;

    form.idTKB = hocphanService.selectedThoiKhoaBieu!.idThoiKhoaBieu;
    notifyListeners();

    String? token = await _jwtTokenBox.getData();

    await _lichtrinhHocPhanRepoImpl.createCourseCancellation(token, form).then((value) async {
      var b = true;
      _form = CourseCancellationFormRequest.defaultConstructor();
      _statusForm = Status.COMPLETED;
    }).onError((error, stackTrace) {
      strError = error.toString();
      _statusForm = Status.ERROR;
    }).whenComplete(() => notifyListeners());
  }

  Future<void> deleteCourseCancelationByApi(int index) async {
    String? token = await _jwtTokenBox.getData();
    await _lichtrinhHocPhanRepoImpl
        .deleteCourseCancellation(token, hocphanService.selectedThoiKhoaBieu!.idThoiKhoaBieu, index)
        .then((value) async {})
        .onError((error, stackTrace) {})
        .whenComplete(() => notifyListeners());
  }

  void setStatusForm() {
    _statusForm = null;
    notifyListeners();
  }

  void setCancellationReason(String? reason) {
    _form.lyDoNghi = reason!;
    notifyListeners();
  }

  void setCancellationWeek(String? week) {
    _form.tuanNghi = int.parse(week!);
    notifyListeners();
  }

  void setIsSendDaotao(bool? isSend) {
    _form.isSendDaoTao = isSend!;
    notifyListeners();
  }

  void setIsSendSinhvien(bool? isSend) {
    _form.isSendSinhVien = isSend!;
    notifyListeners();
  }

  void hienthiNgayNghi(String? week) {
    if (week == null || week.isEmpty || int.tryParse(week) == null || !_isWeekInRange(int.parse(week))) {
      ngayNghi = null;
    } else {
      ngayNghi = caculateNgayNghi(int.parse(week));
    }
    notifyListeners();
  }

  String? isValidWeek(String? week) {
    if (week == null || week.isEmpty) return "Không thể để trống";
    int? tuanNghi = int.tryParse(week);

    if (tuanNghi == null) return "Tuần nghỉ không hợp lệ";

    if (!_isWeekInRange(tuanNghi)) {
      var tkb = hocphanService.selectedThoiKhoaBieu!;
      return "Tuần nghỉ phải ở trong khoảng ${tkb.tuanBatDau}-${tkb.tuanKetThuc}";
    }

    var thoiGianBatDau = caculateNgayNghi(tuanNghi);
    if (!_isValidTime(thoiGianBatDau)) {
      return "Không thể chọn nghỉ tuần đã qua";
    }

    return null;
  }

  bool _isWeekInRange(int tuanNghi) {
    var tkb = hocphanService.selectedThoiKhoaBieu!;
    return tuanNghi >= tkb.tuanBatDau && tuanNghi <= tkb.tuanKetThuc;
  }

  bool _isValidTime(DateTime thoiGianBatDau) {
    var now = DateTime.now();
    Duration duration = thoiGianBatDau.difference(now);

    return !duration.isNegative;
  }

  DateTime caculateNgayNghi(int tuanNghi) {
    var tkb = hocphanService.selectedThoiKhoaBieu!;
    return _namhocHockyService.dsTuanT2[tuanNghi - 1].add(Duration(days: tkb.thu - 2));
  }

  void setViewDateSelected(DateTime picked) {
    int tuanHienTai = getWeekByDay(picked, _namhocHockyService.namhocHockyHienTai!.ngayBatDau);

    if (isValidWeek(tuanHienTai.toString()) == null) {
      tfCancelWeek.text = tuanHienTai.toString();
      ngayNghi = caculateNgayNghi(tuanHienTai);
    } else {
      ngayNghi = null;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    tfReason.dispose();
    tfCancelWeek.dispose();

    super.dispose();
  }
}
