import 'dart:async';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/services/attendance.service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CourseAttendanceViewModel with ChangeNotifier {
  // final CourseDetailsViewModel courseDetailsViewModel;
  final AttendanceService attendanceService;
  // Contructor
  CourseAttendanceViewModel({required this.attendanceService});

  final Logger _logger = Logger();

  List<int> soluongdiemDanh = [0, 0, 0, 0];
  Map<LoaiDiemDanh, LoaiDiemDanh Function()> transitions = {};
  final Set<int> _attendanceQueue = {};

  Future<void> diemDanhTungSinhVienQuaApi(int idSinhVien, int loaiDiemDanh) async {
    await attendanceService.diemDanhTungSinhVienQuaApi(idSinhVien, loaiDiemDanh).then((value) {}).onError((error, stackTrace) {}).whenComplete(() => notifyListeners());
  }

  setSinhvienDiemDanh() async {
    await attendanceService.getSinhvienDiemDanh();
    initSoLuongDiemDanh();
  }

  changeLoaiDiemDanh(int index) async {
    var svDiemDanh = attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh![index];
    LoaiDiemDanh newLoaiDiemDanh = changeDiemDanh(svDiemDanh.loaiDiemDanh)();
    svDiemDanh.diemTruDD = svDiemDanh.diemTruDD - DiemDanh.loaiDiemDanhToInt(svDiemDanh.loaiDiemDanh) / 4 + DiemDanh.loaiDiemDanhToInt(newLoaiDiemDanh) / 4;

    svDiemDanh.loaiDiemDanh = newLoaiDiemDanh;

    notifyListeners();

    if (_attendanceQueue.contains(index)) {
      return;
    }
    _attendanceQueue.add(index);
    try {
      await Future.delayed(const Duration(seconds: 5));
      await attendanceService.diemDanhTungSinhVienQuaApi(svDiemDanh.idSv, DiemDanh.loaiDiemDanhToInt(svDiemDanh.loaiDiemDanh));

      _attendanceQueue.remove(index);
    } catch (error) {
      _attendanceQueue.remove(index);
      print(error);
    }
  }

  void initSoLuongDiemDanh() {
    soluongdiemDanh = [0, 0, 0, 0];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (soluongdiemDanh[0] == 0) {
        var dsDiemDanhSV = attendanceService.dsSVDiemDanh.data!.dsSinhVienDiemDanh!;
        soluongdiemDanh = [
          dsDiemDanhSV.where((e) => e.loaiDiemDanh == LoaiDiemDanh.CO_MAT).length,
          dsDiemDanhSV.where((e) => e.loaiDiemDanh == LoaiDiemDanh.VANG).length,
          dsDiemDanhSV.where((e) => e.loaiDiemDanh == LoaiDiemDanh.VANG_PHEP).length,
          dsDiemDanhSV.where((e) => e.loaiDiemDanh == LoaiDiemDanh.DI_TRE).length
        ];
      }
      transitions = {
        LoaiDiemDanh.CO_MAT: () {
          soluongdiemDanh[0] = --soluongdiemDanh[0];
          soluongdiemDanh[1] = ++soluongdiemDanh[1];

          return LoaiDiemDanh.VANG;
        },
        LoaiDiemDanh.VANG: () {
          soluongdiemDanh[1] = --soluongdiemDanh[1];
          soluongdiemDanh[2] = ++soluongdiemDanh[2];

          return LoaiDiemDanh.VANG_PHEP;
        },
        LoaiDiemDanh.VANG_PHEP: () {
          soluongdiemDanh[2] = --soluongdiemDanh[2];
          soluongdiemDanh[3] = ++soluongdiemDanh[3];

          return LoaiDiemDanh.DI_TRE;
        },
        LoaiDiemDanh.DI_TRE: () {
          soluongdiemDanh[3] = --soluongdiemDanh[3];
          soluongdiemDanh[0] = ++soluongdiemDanh[0];

          return LoaiDiemDanh.CO_MAT;
        },
      };
      notifyListeners();
    });
  }

  LoaiDiemDanh Function() changeDiemDanh(LoaiDiemDanh loaidiemdanh) {
    return transitions[loaidiemdanh] ??
        () {
          return LoaiDiemDanh.CO_MAT;
        };
  }
}
