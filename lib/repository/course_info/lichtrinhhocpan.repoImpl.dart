import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/data/network/BaseApiService.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/course_cancellation_request.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/course_lesson_request.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/diem_danh.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/lich_trinh_hoc_phan.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';

abstract class LichtrinhHocPhanRepository {
  Future<DSLichTrinhHocPhan> fetchDSLichtrinhHocPhanByIdLophp(String idLophp);
  Future<DSSinhVienDiemDanh> fetchDSSinhvienDiemDanhByIdLophp(String idLophp);
  Future<dynamic> createCourseAttendance(DiemDanhFormRequest ddFormRequest);
  Future<NoidungBuoiHoc> getCourseLessonByIdBuoihoc(int idBuoiHoc);
  Future<int> saveDiemDanhSinhVien(int idHocPhan, int idBuoiHoc, String? token);
  Future<bool> saveDiemDanhTungSinhVienByID(int idHocPhan, int idSinhVien, int loaidiemdanh, int idBuoiHoc, String? token);
  Future<bool> createCourseCancellation(String? token, CourseCancellationFormRequest request);
  Future<bool> deleteCourseCancellation(String? token, int idLophp, int index);
}

class LichtrinhHocPhanRepoImpl implements LichtrinhHocPhanRepository {
  final BaseApisService _apiService;
  final BaseLocal<String> _jwtTokenBox;

  LichtrinhHocPhanRepoImpl({required apiService, required jwtTokenBox})
      : _apiService = apiService,
        _jwtTokenBox = jwtTokenBox;

  @override
  Future<DSLichTrinhHocPhan> fetchDSLichtrinhHocPhanByIdLophp(String idLophp) async {
    try {
      String? token = await _jwtTokenBox.getData();

      var url = '${AppInfo.courseAttendanceEndPoint}?idLophp=$idLophp';
      final res = await _apiService.getApiResponse(url, token);

      return DSLichTrinhHocPhan.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<DSSinhVienDiemDanh> fetchDSSinhvienDiemDanhByIdLophp(String idLophp) async {
    try {
      String? token = await _jwtTokenBox.getData();
      var url = "${AppInfo.courseStudentAttendanceEndPoint}?idLophp=$idLophp";

      final res = await _apiService.getApiResponse(url, token);

      return DSSinhVienDiemDanh.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> createCourseAttendance(DiemDanhFormRequest ddFormRequest) async {
    try {
      String? token = await _jwtTokenBox.getData();
      var url = "";

      switch (ddFormRequest.typeRequest) {
        case 0:
          url = AppInfo.courseCreateLessonAttendanceEndPoint;
          bool res = await _apiService.postApiResponse(url, ddFormRequest.toJson(), token);
          return res;

        case 1:
          url = AppInfo.courseCreateLessonAttendanceQREndPoint;
          var res = await _apiService.postApiResponse(url, ddFormRequest.toJson(), token);

          return NoidungBuoiHoc.fromJson(res);

        case 2:
          url = AppInfo.courseCreateLessonAttendanceQREndPoint;
          var res = await _apiService.postApiResponse(url, ddFormRequest.toJson(), token);

          return NoidungBuoiHoc.fromJson(res);
      }
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<NoidungBuoiHoc> getCourseLessonByIdBuoihoc(int idBuoiHoc) async {
    try {
      String? token = await _jwtTokenBox.getData();

      var url = '${AppInfo.courseLessonDetailsQREndPoint}/$idBuoiHoc';
      final res = await _apiService.getApiResponse(url, token);

      return NoidungBuoiHoc.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<int> saveDiemDanhSinhVien(int idHocPhan, int idBuoiHoc, String? token) async {
    try {
      // String? token = await _jwtTokenBox.getData();
      var url = "${AppInfo.courseSaveAllAttendanaceQREndPoint}?idLophp=$idHocPhan&idBuoiHoc=$idBuoiHoc";

      Map requestMap = {"idLophp": idHocPhan, "idBuoiHoc": idBuoiHoc};
      int res = await _apiService.postApiResponse(url, requestMap, token);
      return res;
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<bool> saveDiemDanhTungSinhVienByID(int idHocPhan, int idSinhVien, int loaidiemdanh, int idBuoiHoc, String? token) async {
    try {
      var url = "${AppInfo.courseSaveStudentAttendanaceQREndPoint}?idLophp=$idHocPhan&idSv=$idSinhVien&loaiDiemDanh=$loaidiemdanh&idBuoiHoc=$idBuoiHoc";
      bool res = await _apiService.postApiResponse(url, null, token);
      return res;
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<bool> createCourseCancellation(String? token, CourseCancellationFormRequest request) async {
    try {
      var url = AppInfo.courseCreateCancellationEndPoint;
      bool res = await _apiService.postApiResponse(url, request.toJson(), token);
      return res;
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<bool> deleteCourseCancellation(String? token, int idTKB, int index) async {
    try {
      var url = "${AppInfo.courseDeleteCancellationEndPoint}?idTkb=$idTKB&indexBuoiNghi=$index";
      Map requestMap = {"idTkb": idTKB, "indexBuoiNghi": index};
      bool res = await _apiService.postApiResponse(url, requestMap, token);
      return res;
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }
}
