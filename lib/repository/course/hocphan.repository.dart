import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/network/BaseApiService.dart';
import 'package:app_giang_vien_vku/data/network/NetworkApiService.dart';

abstract class HocphanRepository {
  Future<DSThoiKhoaBieu> fetchHocphanByNamhocHocky(String token, String namhoc, String hocky);
}

class HocPhanRepositoryImpl implements HocphanRepository {
  final BaseApisService _apiService;

  HocPhanRepositoryImpl({required apiService}) : _apiService = apiService;

  @override
  Future<DSThoiKhoaBieu> fetchHocphanByNamhocHocky(String token, String namhoc, String hocky) async {
    try {
      var url = "${AppInfo.hocphanFetchEndPoint}?namBatDau=$namhoc&hocKy=$hocky";

      final res = await _apiService.getApiResponse(url, token);

      return DSThoiKhoaBieu.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }
}
