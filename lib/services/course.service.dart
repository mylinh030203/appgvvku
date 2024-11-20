import 'package:app_giang_vien_vku/data/local/qr_base64.local.dart';
// ignore: unused_import
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/lich_trinh_hoc_phan.dart';
import 'package:app_giang_vien_vku/data/response/ApiResponse.dart';
import 'package:app_giang_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:flutter/widgets.dart';

class CourseDetailsService with ChangeNotifier {
  final LopHocPhanService _hocphanService;
  final LichtrinhHocPhanRepository _lichtrinhHocPhanRepoImpl;
  final BaseLocal<String> _jwtTokenBox;

  // Contructor
  CourseDetailsService({
    required hocphanService,
    required lichtrinhHocPhanRepoImpl,
    required jwtTokenBox,
  })  : _hocphanService = hocphanService,
        _lichtrinhHocPhanRepoImpl = lichtrinhHocPhanRepoImpl,
        _jwtTokenBox = jwtTokenBox;

  ApiResponse<DSLichTrinhHocPhan> _dsLichtrinhHocPhan = ApiResponse.loading();
  ApiResponse<NoidungBuoiHoc> _noidungBuoiHocQR = ApiResponse.loading();
  LichTrinhHocPhan? _selectedLTHP;
  QRBase64? _qrBase64Now;

  ApiResponse<DSLichTrinhHocPhan> get dsLichtrinhHocPhan => _dsLichtrinhHocPhan;
  ApiResponse<NoidungBuoiHoc> get noidungBuoiHocQR => _noidungBuoiHocQR;
  QRBase64? get qrBase64 => _qrBase64Now;
  LichTrinhHocPhan? get selectedLTHP => _selectedLTHP;

  void setNoiDungBuoiHoc(NoidungBuoiHoc ndbh) {
    _noidungBuoiHocQR = ApiResponse.completed(ndbh);
    notifyListeners();
  }

  void setSelectedLTHP(int index) {
    _selectedLTHP = _dsLichtrinhHocPhan.data!.dsLichTrinhHocPhan![index];
    notifyListeners();
  }

  void setQRBase64(QRBase64? qr) {
    _qrBase64Now = qr;
    notifyListeners();
  }

  void resetAllData() {
    _dsLichtrinhHocPhan = ApiResponse.loading();
    _noidungBuoiHocQR = ApiResponse.loading();
    notifyListeners();
  }

  // Gọi api lấy lichtrinhHocPhan
  Future<void> getLichtrinhHocphanByApi() async {
    final selectedThoiKhoaBieu = _hocphanService.selectedThoiKhoaBieu;

    _dsLichtrinhHocPhan = ApiResponse.loading();
    notifyListeners();

    await _lichtrinhHocPhanRepoImpl.fetchDSLichtrinhHocPhanByIdLophp(selectedThoiKhoaBieu!.idHocPhan.toString()).then((value) {
      value.dsLichTrinhHocPhan?.sort((a, b) => b.ngayDay.compareTo(a.ngayDay));
      _dsLichtrinhHocPhan = ApiResponse.completed(value);
      notifyListeners();
    }).onError((error, stackTrace) {
      _dsLichtrinhHocPhan = ApiResponse.error(error.toString());
      notifyListeners();
    }).whenComplete(() => notifyListeners());
  }

  // Gọi api lấy thông tin buổi học
  Future<void> getThongTinBuoiHocQRByApi() async {
    _noidungBuoiHocQR = ApiResponse.loading();
    notifyListeners();

    await _lichtrinhHocPhanRepoImpl.getCourseLessonByIdBuoihoc(_selectedLTHP!.id).then((value) {
      _noidungBuoiHocQR = ApiResponse.completed(value);
      // _noidungBuoiHocQR(context);
    }).onError((error, stackTrace) {
      _noidungBuoiHocQR = ApiResponse.error(error.toString());
    }).whenComplete(() => notifyListeners());
  }

  //
  Future<int> saveDiemDanhSinhvien(int idBuoiHoc) async {
    String? token = await _jwtTokenBox.getData();
    await _lichtrinhHocPhanRepoImpl.saveDiemDanhSinhVien(_hocphanService.selectedThoiKhoaBieu!.idHocPhan, idBuoiHoc, token).then((value) {
      return value;
    }).onError((error, stackTrace) {
      return 0;
    }).whenComplete(() => notifyListeners());
    return 0;
  }

  // Xử lý map điểm danh
  Map<LoaiDiemDanh, List<String>> getMapLoaiDiemDanh(int index) {
    var dsDiemDanh = dsLichtrinhHocPhan.data!.dsLichTrinhHocPhan![index].dsDiemDanhChiTiet;
    Map<LoaiDiemDanh, List<String>> mapLoaiDiemDanh = {LoaiDiemDanh.DI_TRE: [], LoaiDiemDanh.VANG_PHEP: [], LoaiDiemDanh.VANG: []};
    for (var diemdanh in dsDiemDanh) {
      mapLoaiDiemDanh[diemdanh.loaiDiemDanh]?.add('- ${diemdanh.hoTen} - Mã SV: ${diemdanh.maSV}');
    }
    return mapLoaiDiemDanh;
  }
}
