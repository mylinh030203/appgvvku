import 'dart:async';

import 'package:app_giang_vien_vku/data/local/qr_base64.local.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';

import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/services/attendance.service.dart';
import 'package:app_giang_vien_vku/services/course.service.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:logger/logger.dart';

class CourseDetailsViewModel with ChangeNotifier {
  final CourseDetailsService courseDetailService;
  final AttendanceService attendanceService;
  final LopHocPhanService hocphanService;
  final BaseLocal<List<QRBase64>> _qrBase64Box;

  // Contructor
  CourseDetailsViewModel({
    required this.courseDetailService,
    required this.hocphanService,
    required qrBase64Box,
    required this.attendanceService,
  }) : _qrBase64Box = qrBase64Box;

  final Logger _logger = Logger();

  Map<String, int> mapLabelSinhVien = <String, int>{};
  List<SinhVienDiemDanh> dsFilterSinhVien = [];

  final TextEditingController inputSearchSV = TextEditingController();
  Timer? _debounce;
  bool isSelectedAllSV = true;
  late Duration remainingDuration;
  Timer? _timer;
  // Timer? get timer => _timer;

  // Gọi api lấy lichtrinhHocPhan
  Future<void> getLichtrinhHocphan() async {
    await courseDetailService.getLichtrinhHocphanByApi().then((value) {}).onError((error, stackTrace) {}).whenComplete(() => notifyListeners());
  }

  // Gọi api lấy ds sinh viên điểm danh
  Future<void> getSinhvienDiemDanh() async {
    await attendanceService
        .getSinhvienDiemDanh()
        .then((value) {
          resetDSFilterSinhVien();
          createMapWithLabelSinhVien();
          setUpFunctionWhenKeyPressEnd();
        })
        .onError((error, stackTrace) {})
        .whenComplete(() => notifyListeners());
  }

  //  Gọi api lấy thông tin buổi học
  Future<void> getThongTinBuoiHocQR() async {
    _timer?.cancel();
    await courseDetailService.getThongTinBuoiHocQRByApi().then((value) async {}).onError((error, stackTrace) {}).whenComplete(() => notifyListeners());
  }

  // Tạo biến đếm trên giao diện.
  Future<void> startCourseDetailTimer() async {
    var timeEnd = courseDetailService.noidungBuoiHocQR.data!.timeEnd!;
    remainingDuration = timeEnd.difference(DateTime.now());

    if (remainingDuration.isNegative) {
      _timer?.cancel();
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      remainingDuration = timeEnd.difference(DateTime.now());
      notifyListeners();
      if (remainingDuration.isNegative) {
        timer.cancel();
        return;
      }
    });
  }

  // Sort Danh sách sinh viên Fuction
  void resetDSFilterSinhVien() {
    dsFilterSinhVien = attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh!.toList();
    notifyListeners();
  }

  void filterSearchSinhVienList(String searchText) {
    if (searchText.isEmpty) {
      resetDSFilterSinhVien();
      return;
    }
    var dsIdSinhvien = mapLabelSinhVien.keys.where((key) => key.toString().contains(searchText.toUpperCase())).map((key) => mapLabelSinhVien[key]!).toList();
    dsFilterSinhVien.clear();
    for (var sinhVien in dsIdSinhvien) {
      dsFilterSinhVien.add(attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh![sinhVien]);
    }
    notifyListeners();
  }

  void setUpFunctionWhenKeyPressEnd() {
    inputSearchSV.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 1000), () {
        filterSearchSinhVienList(inputSearchSV.text);
      });
    });
  }

  void createMapWithLabelSinhVien() {
    List<DiemDanh> dsDiemDanh = attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh!.toList();
    for (int index = 0; index < dsDiemDanh.length; index++) {
      String key = "${dsDiemDanh[index].hoTen} ${dsDiemDanh[index].maSV}".toUpperCase();
      mapLabelSinhVien[key] = index;
    }
    notifyListeners();
  }
  // End - Sort Danh sách sinh viên Fuction

  Future<void> getQrBase64() async {
    try {
      List<QRBase64>? dsQRbase64 = await _qrBase64Box.getData();
      if (dsQRbase64 == null || dsQRbase64.isEmpty) return;
      var idBuoiHoc = courseDetailService.selectedLTHP!.id;
      var idHocPhan = hocphanService.selectedThoiKhoaBieu!.idHocPhan;

      QRBase64 qr = dsQRbase64.firstWhere(
        (e) => e.idHocPhan == idHocPhan && e.idBuoiHoc == idBuoiHoc,
        orElse: () => QRBase64(
          idHocPhan: hocphanService.selectedThoiKhoaBieu!.idHocPhan,
          thoiGianTao: -1,
          contentBase64: "",
          idBuoiHoc: -1,
        ),
      );

      courseDetailService.setQRBase64(qr);
    } catch (e) {
      print(e);
    }
  }

  void changeCheckbox(int index) {
    final dsSinhVien = attendanceService.dsSVDiemDanh.data?.dsSinhVienDiemDanh;

    if (dsSinhVien != null && index < dsSinhVien.length) {
      dsSinhVien[index].isCheckBox = !dsSinhVien[index].isCheckBox;
      notifyListeners();
    }
  }

  void selectedAllCheckBox(bool newBool) {
    if (attendanceService.dsSVDiemDanh.data == null || attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh == null) {
      return;
    }
    for (var sinhVien in attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh!) {
      sinhVien.isCheckBox = newBool;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _debounce?.cancel(); // Hủy Timer khi widget bị hủy

    super.dispose();
  }

  void disposeTimer() {
    _debounce?.cancel();
    _timer?.cancel(); // Hủy Timer khi widget bị hủy
  }
}
