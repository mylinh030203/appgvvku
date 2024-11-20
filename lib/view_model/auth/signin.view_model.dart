import 'dart:async';

import 'package:app_giang_vien_vku/data/AppException.dart';
import 'package:app_giang_vien_vku/data/network/model/auth/signin.model.dart';
import 'package:app_giang_vien_vku/repository/auth/auth.repository.dart';
import 'package:app_giang_vien_vku/repository/auth/auth.repositoryImpl.dart';
import 'package:app_giang_vien_vku/utils/DataLocal.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SigninViewModel with ChangeNotifier {
  final BaseLocal<String> jwtTokenBox;
  final AuthRepository authRepoImpl;

  SigninViewModel({required this.jwtTokenBox, required this.authRepoImpl});

  final Logger _logger = Logger();

  bool _loading = false;

  bool get loading => _loading;

  setLoadingg(bool value) {
    _loading = value;
    notifyListeners();
  }

  countDownTime(BuildContext context) async {
    return Timer(
      const Duration(milliseconds: 500),
      () async {
        String? token = await jwtTokenBox.getData();
        if (token != null) {
          print("token $token");
          AppHelperFunctions.navigateToScreenName(context, RoutesName.menuBar);
        } else {
          AppHelperFunctions.navigateToScreenName(context, RoutesName.login);
        }
      },
    );
  }

  Future<void> loginApi(String email, String password, BuildContext context) async {
    setLoadingg(true);
    Utils.showLoading(context);
    await Future.delayed(Duration(seconds: 2));
    try {
      final response = await authRepoImpl.loginApi(LoginRequestModel(username: email, password: password));
      _logger.d(response.toString());

      await jwtTokenBox.setData(response.token);
      // await Datalocal.setAccessToken(response.token);

      setLoadingg(false);
      Navigator.pop(context);

      String? token = await jwtTokenBox.getData();
      print("token da lay $token");

      Navigator.popAndPushNamed(context, RoutesName.menuBar);
    } catch (e) {
      _logger.e(e.toString());
      setLoadingg(false);
      Navigator.pop(context);
      // Hiển thị thông báo lỗi từ server
      if (e is BadRequestException || e is UnauthorisedException || e is FetchDataException) {
        Utils.snackBar(e.toString(), context, true);
      } else {
        Utils.snackBar("An unexpected error occurred", context, true);
      }
    }
  }

  //  void disposeAuthRepo() {
  //   // Tự dispose repository nếu không cần nữa
  //   authRepoImpl.dispose();  // Dispose repository nếu cần
  // }

  // @override
  // void dispose() {
  //   // Gọi dispose repository khi SigninViewModel không còn cần thiết
  //   authRepoImpl.dispose();
  //   super.dispose();
  // }
}
