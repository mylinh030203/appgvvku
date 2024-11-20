import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/data/local/namhoc_hocky.local.dart';
import 'package:app_giang_vien_vku/data/network/BaseApiService.dart';
import 'package:app_giang_vien_vku/data/network/NetworkApiService.dart';

abstract class NamhocHockyRepository {
  Future<DSNamhocHocky> fecthNamhocHocky(String token);
}

class NamhocHockyRepositoryImpl implements NamhocHockyRepository {
  final BaseApisService _apiService;

  NamhocHockyRepositoryImpl({required apiService}) : _apiService = apiService;
  @override
  Future<DSNamhocHocky> fecthNamhocHocky(String token) async {
    try {
      var url = AppInfo.namhochockyFetchEndPoint;
      final res = await _apiService.getApiResponse(url, token);
      return DSNamhocHocky.fromJson(res);
    } catch (e) {
      print("loi o day $e");
      rethrow;
    }
  }
}
