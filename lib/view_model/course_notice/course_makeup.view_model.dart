import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/course_make_up_request.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/repository/course_info/course_make_up.repo.dart';
import 'package:app_giang_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/services/namhoc_hocky.service.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CourseMakeUpViewModel with ChangeNotifier {
  final LopHocPhanService _hocphanService;
  final NamHocHocKyService _namhocHockyService;
  final MakeupCourseRepo _makeupCourseRepoImpl;
  final BaseLocal<String> _jwtTokenBox;

  // Contructor
  CourseMakeUpViewModel({
    required hocphanService,
    required jwtTokenBox,
    required namHocHockyService,
    required makeupCourseRepoImpl,
  })  : _hocphanService = hocphanService,
        _jwtTokenBox = jwtTokenBox,
        _namhocHockyService = namHocHockyService,
        _makeupCourseRepoImpl = makeupCourseRepoImpl;

  final tfDateMakeUp = TextEditingController();

  CourseMakeUpFormRequest _form = CourseMakeUpFormRequest.defaultConstructor();
  CourseMakeUpFormRequest get form => _form;

  Status? _statusForm;
  Status? get statusForm => _statusForm;
  String? strError;

  String? ngayBaoBu;
  List<int>? listTiet;
  String? strThoigianTiet;

  final List<String> optionsPhong = ['K.A101', 'K.A102', 'K.A103', 'K.A104'];
  final List<List<int>> optionsTiet = [
    [1, 2],
    [1, 3],
    [1, 4],
    [1, 5],
    [2, 3],
    [2, 4],
    [2, 5],
    [3, 4],
    [3, 5],
    [4, 5],
    [6, 7],
    [6, 8],
    [6, 9],
    [6, 10],
    [7, 8],
    [7, 9],
    [7, 10],
    [8, 9],
    [8, 10],
    [9, 10]
  ];

  Future<void> createCourseMakeUpByApi() async {
    _statusForm = Status.LOADING;
    form.idTkb = _hocphanService.selectedThoiKhoaBieu!.idThoiKhoaBieu;
    notifyListeners();

    var tkb = _hocphanService.selectedThoiKhoaBieu!;
    if (tkb.caculateSoTietBaoNghi() <= tkb.caculateSoTietBaoBu()) {
      strError = "Không thể tạo buổi bù! Bạn đã bù đủ buổi trong học phần này.";
      _statusForm = Status.ERROR;
      return;
    }

    String? token = await _jwtTokenBox.getData();

    await _makeupCourseRepoImpl.createMakeupClass(token, form).then((value) async {
      _form = CourseMakeUpFormRequest.defaultConstructor();
      _statusForm = Status.COMPLETED;
    }).onError((error, stackTrace) {
      strError = error.toString();
      _statusForm = Status.ERROR;
    }).whenComplete(() => notifyListeners());
  }

  Future<void> deleteCourseMakeUpByApi(int index) async {
    String? token = await _jwtTokenBox.getData();
    await _makeupCourseRepoImpl
        .deleteMakeupClass(token, _hocphanService.selectedThoiKhoaBieu!.idThoiKhoaBieu, index)
        .then((value) async {})
        .onError((error, stackTrace) {})
        .whenComplete(() => notifyListeners());
  }

  void setStatusForm() {
    _statusForm = null;
    notifyListeners();
  }

  void setSeletedPhong(String? tenPhong) {
    if (tenPhong != null) {
      _form.phongHoc = tenPhong;
      notifyListeners();
    }
  }

  void setSeletedTietForm(List<int>? tiet) {
    if (tiet != null) {
      _form.tietBatDau = tiet[0];
      _form.tietKetThuc = tiet[1];
      notifyListeners();
    }
  }

  void setSelectedTiet(List<int>? tiet) {
    if (tiet != null) {
      listTiet = tiet;
      strThoigianTiet = "${AppValues.classTimeStart[tiet[0] - 1]} - ${AppValues.classTimeEnd[tiet[1] - 1]}";
      notifyListeners();
    }
  }

  void setDateMakeUp(String? date) {
    var dateBaoBu = DateTime.parse(date!);

    _form.tuanBaoBu = getWeekByDay(dateBaoBu, _namhocHockyService.namhocHockyHienTai!.ngayBatDau);
    _form.thu = dateBaoBu.weekday + 1;

    notifyListeners();
  }

  void setTietBatDau(String? tietBatDau) {
    _form.tietBatDau = int.parse(tietBatDau!);
    notifyListeners();
  }

  void setTietKetThuc(String? tietKetThuc) {
    _form.tietKetThuc = int.parse(tietKetThuc!);
    notifyListeners();
  }

  String? isValidDate(String? date) {
    if (_isDateNullOrEmpty(date)) return _invalidDate("Không thể để trống");

    DateTime? ngayBu = DateTime.tryParse(date!);
    if (ngayBu == null) return _invalidDate("Ngày báo bù không hợp lệ");

    int tuanBu = getWeekByDay(ngayBu, _namhocHockyService.namhocHockyHienTai!.ngayBatDau);

    if (!_isWeekInRange(tuanBu)) {
      var tkb = _hocphanService.selectedThoiKhoaBieu!;
      return _invalidDate("Ngày báo bù phải ở trong khoảng tuần ${tkb.tuanBatDau}-${tkb.tuanKetThuc}");
    }

    if (!_isValidTime(caculateNgayNghi(tuanBu))) {
      return _invalidDate("Không thể chọn ngày bù đã qua");
    }

    return null;
  }

  String? _invalidDate(String errorMessage) {
    ngayBaoBu = null;
    notifyListeners();
    return errorMessage;
  }

  bool _isDateNullOrEmpty(String? date) => date == null || date.isEmpty;

  bool _isWeekInRange(int tuanNghi) {
    var tkb = _hocphanService.selectedThoiKhoaBieu!;
    return tuanNghi >= tkb.tuanBatDau && tuanNghi <= tkb.tuanKetThuc;
  }

  bool _isValidTime(DateTime thoiGianBatDau) {
    var now = DateTime.now();
    return !thoiGianBatDau.isBefore(now);
  }

  DateTime caculateNgayNghi(int tuanNghi) {
    var tkb = _hocphanService.selectedThoiKhoaBieu!;
    return _namhocHockyService.dsTuanT2[tuanNghi - 1].add(Duration(days: tkb.thu - 2));
  }

  void setViewDateSelected(DateTime picked) {
    int tuanHienTai = getWeekByDay(picked, _namhocHockyService.namhocHockyHienTai!.ngayBatDau);
    tfDateMakeUp.text = DateFormat('yyyy-MM-dd').format(picked);

    ngayBaoBu = isValidDate(tfDateMakeUp.text) == null ? "Tuần $tuanHienTai - ${picked.weekday != 7 ? "Thứ ${picked.weekday + 1}" : "Chủ Nhật"}" : "";
    notifyListeners();
  }

  @override
  void dispose() {
    tfDateMakeUp.dispose();
    // tfTietBatDau.dispose();
    // tfTietKetThuc.dispose();
    super.dispose();
  }
}
