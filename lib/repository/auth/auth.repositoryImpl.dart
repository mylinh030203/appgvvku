import 'package:app_giang_vien_vku/data/network/model/auth/signup.model.dart';
import '../../constants/AppInfo.dart';
import '../../data/network/BaseApiService.dart';
import '../../data/network/NetworkApiService.dart';
import '../../data/network/model/auth/signin.model.dart';
import 'auth.repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseApisService _apiService;

  AuthRepositoryImpl({required apiService}) : _apiService = apiService;

  @override
  Future<LoginResponseModel> loginApi(LoginRequestModel data) async {
    try {
      final res = await _apiService.postApiResponse(AppInfo.loginEndPoint, data.toJson(), null);

      return LoginResponseModel.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SignupResponseModel> signupApi(SignupRequestModel data) async {
    try {
      final res = await _apiService.postApiResponse(AppInfo.registerEndPoint, data.toJson(), null);
      print("data sau laay ${SignupResponseModel.fromJson(res)}");

      return SignupResponseModel.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SignupResponseModel> verifyCode(String code) async {
    try {
      final res = await _apiService.postApiResponse(AppInfo.verifyEndPoint, {"code": code}, null);

      print("data sau laay ${LoginResponseModel.fromJson(res)}");
      return SignupResponseModel.fromJson(res);
    } catch (e) {
      throw e;
    }
  }
}
