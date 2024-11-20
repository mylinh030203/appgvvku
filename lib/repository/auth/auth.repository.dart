import 'package:app_giang_vien_vku/data/network/model/auth/signup.model.dart';

import '../../data/network/model/auth/signin.model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> loginApi(LoginRequestModel data);
  Future<SignupResponseModel> signupApi(SignupRequestModel data);
  Future<SignupResponseModel> verifyCode(String code);
}
