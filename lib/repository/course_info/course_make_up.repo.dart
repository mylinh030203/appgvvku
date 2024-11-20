import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/data/network/BaseApiService.dart';
import 'package:app_giang_vien_vku/data/network/model/course_detail/course_make_up_request.dart';

abstract class MakeupCourseRepo {
  Future<bool> createMakeupClass(String? token, CourseMakeUpFormRequest request);
  Future<bool> deleteMakeupClass(String? token, int idTkb, int index);
}

class MakeupCourseRepoImpl implements MakeupCourseRepo {
  final BaseApisService _apiService;

  MakeupCourseRepoImpl({required apiService}) : _apiService = apiService;

  @override
  Future<bool> createMakeupClass(String? token, CourseMakeUpFormRequest request) async {
    try {
      var url = AppInfo.courseCreateMakeUpEndPoint;
      print(request.toJson());
      bool res = await _apiService.postApiResponse(url, request.toJson(), token);
      return res;
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }

  @override
  Future<bool> deleteMakeupClass(String? token, int idTkb, int index) async {
    try {
      var url = "${AppInfo.courseDeleteMakeUpEndPoint}?idTkb=$idTkb&buoiBuIndex=$index";
      Map requestMap = {"idTkb": idTkb, "indexBuoiNghi": index};
      bool res = await _apiService.postApiResponse(url, requestMap, token);
      return res;
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }
}
