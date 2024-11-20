import 'package:app_giang_vien_vku/data/local/qr_base64.local.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/course_lesson_request.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/lich_trinh_hoc_phan.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_giang_vien_vku/utils/BackGroundService.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/services/course.service.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseLessonFormViewModel with ChangeNotifier {
  final CourseDetailsService _courseDetailService;
  final LopHocPhanService _hocphanService;
  final BaseLocal<List<QRBase64>> _qrBase64Box;
  final LichtrinhHocPhanRepository _lichtrinhHocPhanRepoImpl;
  final BaseLocal<String> _jwtTokenBox;
  final BackgroundService _backgroundService;
  final SettingViewModel _settingViewModel;
  // Contructor
  CourseLessonFormViewModel({
    required courseDetailService,
    required hocPhanService,
    required qrBase64Box,
    required lichtrinhHocPhanRepoImpl,
    required backgroundService,
    required jwtTokenBox,
    required settingViewModel,
  })  : _courseDetailService = courseDetailService,
        _hocphanService = hocPhanService,
        _qrBase64Box = qrBase64Box,
        _lichtrinhHocPhanRepoImpl = lichtrinhHocPhanRepoImpl,
        _backgroundService = backgroundService,
        _jwtTokenBox = jwtTokenBox,
        _settingViewModel = settingViewModel;

  final Logger _logger = Logger();

  final DiemDanhFormRequest _lessonForm = DiemDanhFormRequest.defaultConstructor();
  DiemDanhFormRequest get lessonForm => _lessonForm;

  Status? _statusFormLesson;
  Status? get statusFormLesson => _statusFormLesson;

  String _errorString = "";
  String get errorString => _errorString;

  bool isCreateCourse = false;

  // Thay đổi loại điểm danh
  initDiemDanhForm(int idLophocphan) {
    _lessonForm.idLophp = idLophocphan;
    _lessonForm.typeRequest = 0;
    notifyListeners();
  }

  void setLoaidiemdanh(int newValues) {
    lessonForm.typeRequest = newValues;
    notifyListeners();
  }

  // Thay đổi thời hạn QR
  void setThoiHanQR(double newValues) {
    lessonForm.thoihan = newValues;
    notifyListeners();
  }

  void setStatusForm() {
    _statusFormLesson = null;
    notifyListeners();
  }

  Future<void> submitFormCourseLesson(String noidungBuoihoc) async {
    _statusFormLesson = Status.LOADING;
    notifyListeners();

    if (noidungBuoihoc.isEmpty) {
      _statusFormLesson = Status.ERROR;
      _errorString = "Nội dung buổi học không được để trống";
      notifyListeners();
      return;
    }

    _prepareLessonForm(noidungBuoihoc);

    try {
      await _setCoordinatesBasedOnTypeRequest();

      await _lichtrinhHocPhanRepoImpl.createCourseAttendance(lessonForm).then((value) async {
        switch (_lessonForm.typeRequest) {
          case 0:
            break;
          case 1:
          case 2:
            var ndbh = value as NoidungBuoiHoc;
            final qr = QRBase64(idHocPhan: lessonForm.idLophp, thoiGianTao: DateTime.now().day, contentBase64: ndbh.qrImageBase64, idBuoiHoc: ndbh.id);
            _courseDetailService.setNoiDungBuoiHoc(ndbh);
            _courseDetailService.setQRBase64(qr);

            await preprocessQRBase64Local(qr);
            await _startTimerBackgroundService();
            _courseDetailService.setSelectedLTHP(0);

            break;
        }
        await _courseDetailService.getLichtrinhHocphanByApi();

        _settingViewModel.setSelectedOption(FunctionOptions.NONE);
      });
      _statusFormLesson = Status.COMPLETED;
    } catch (e) {
      _statusFormLesson = Status.ERROR;
      _errorString = "Tạo buổi học không thành công";
    } finally {
      notifyListeners();
    }
  }

  // Tạo biến đếm trên giao diện.
  Future<void> _startTimerBackgroundService() async {
    // Khởi chạy background để đếm
    await _backgroundService.initialize();
    var idTKB = _hocphanService.selectedThoiKhoaBieu!.idHocPhan;
    var tenTKB = _hocphanService.selectedThoiKhoaBieu!.tenThoiKhoaBieu;
    var idBuoiHoc = _courseDetailService.noidungBuoiHocQR.data!.id;
    var timeEnd = _courseDetailService.noidungBuoiHocQR.data!.timeEnd!;
    String? token = await _jwtTokenBox.getData();
    Duration remainingDuration = timeEnd.difference(DateTime.now());
    if (remainingDuration.isNegative) {
      return;
    }
    FlutterBackgroundService().invoke('startWithParams', {
      'idHocPhan': idTKB,
      'tenTKB': tenTKB, // Example value
      'timeEnd': timeEnd.toIso8601String(), // Pass a future date
      'idBuoiHoc': idBuoiHoc, // Example ID
      'token': token
    });
  }

  void _prepareLessonForm(String noidungBuoihoc) {
    lessonForm.idLophp = _hocphanService.selectedThoiKhoaBieu!.idHocPhan;
    lessonForm.noiDung = noidungBuoihoc;
  }

  Future<void> _setCoordinatesBasedOnTypeRequest() async {
    switch (lessonForm.typeRequest) {
      case 0:
      case 1:
        lessonForm.toaDoX = 'z';
        lessonForm.toaDoY = 'z';
        break;
      case 2:
        if (await Permission.location.isDenied) {
          await Permission.notification.request();
        }
        var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        lessonForm.toaDoX = position.longitude.toString();
        lessonForm.toaDoY = position.latitude.toString();
        break;
    }
  }

  bool isInSameDay(List<QRBase64> data) {
    if (data.isEmpty) return true;
    return data[0].thoiGianTao == DateTime.now().day;
  }

  Future<void> preprocessQRBase64Local(QRBase64 qr) async {
    try {
      List<QRBase64>? dsQRBase64 = await _qrBase64Box.getData();

      dsQRBase64 ??= <QRBase64>[];

      if (!isInSameDay(dsQRBase64)) {
        dsQRBase64.clear();
      }
      dsQRBase64.add(qr);
      await _qrBase64Box.setData(dsQRBase64);
    } catch (e) {
      print(e);
    }
    // print('Data Type: ${rawData.runtimeType}');
  }
}
