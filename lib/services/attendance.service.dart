import 'package:app_giang_vien_vku/data/local/qr_base64.local.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/data/response/ApiResponse.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';

import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/services/course.service.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:flutter/widgets.dart';

class AttendanceService with ChangeNotifier {
  final LopHocPhanService _hocphanService;
  final LichtrinhHocPhanRepository _lichtrinhHocPhanRepoImpl;
  final BaseLocal<String> _jwtTokenBox;
  final CourseDetailsService _courseDetailsService;

  AttendanceService({
    required hocphanService,
    required lichtrinhHocPhanRepoImpl,
    required jwtTokenBox,
    required courseDetailsService,
  })  : _hocphanService = hocphanService,
        _lichtrinhHocPhanRepoImpl = lichtrinhHocPhanRepoImpl,
        _jwtTokenBox = jwtTokenBox,
        _courseDetailsService = courseDetailsService;

  ApiResponse<DSSinhVienDiemDanh> _dsSVDiemDanh = ApiResponse.loading();
  ApiResponse<DSSinhVienDiemDanh> get dsSVDiemDanh => _dsSVDiemDanh;
  // Gọi api lấy ds sinh viên điểm danh
  Future<void> getSinhvienDiemDanh() async {
    dsSVDiemDanh.status = Status.LOADING;
    notifyListeners();

    final selectedThoiKhoaBieu = _hocphanService.selectedThoiKhoaBieu;

    await _lichtrinhHocPhanRepoImpl.fetchDSSinhvienDiemDanhByIdLophp(selectedThoiKhoaBieu!.idHocPhan.toString()).then((value) {
      _dsSVDiemDanh = ApiResponse.completed(value);
    }).onError((error, stackTrace) {
      _dsSVDiemDanh = ApiResponse.error(error.toString());
    }).whenComplete(() => notifyListeners());
  }

  Future<void> diemDanhTungSinhVienQuaApi(int idSinhVien, int loaiDiemDanh) async {
    String? token = await _jwtTokenBox.getData();
    var a = _courseDetailsService.selectedLTHP!.id;
    await _lichtrinhHocPhanRepoImpl
        .saveDiemDanhTungSinhVienByID(_hocphanService.selectedThoiKhoaBieu!.idHocPhan, idSinhVien, loaiDiemDanh, _courseDetailsService.selectedLTHP!.id, token)
        .then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error);
    }).whenComplete(() => notifyListeners());
  }
}
