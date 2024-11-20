import 'package:app_giang_vien_vku/data/network/model/auth/signup.model.dart';
import 'package:app_giang_vien_vku/repository/auth/auth.repository.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';

import 'package:flutter/material.dart';
import '../../repository/auth/auth.repositoryImpl.dart';
import 'package:logger/logger.dart';

import '../../utils/helpers/helper_functions.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class SignupViewModel with ChangeNotifier {
  final AuthRepository authRepoImpl;

  SignupViewModel({required this.authRepoImpl});

  final Logger _logger = Logger();

  bool _loading = false;
  bool get loading => _loading;

  setLoadingg(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signupApi(String email, String password, String username, BuildContext context) async {
    setLoadingg(true);
    Utils.showLoading(context);
    await Future.delayed(Duration(seconds: 2));
    try {
      final response = await authRepoImpl.signupApi(SignupRequestModel(username: username, password: password, email: email));

      _logger.d(response.toString());
      setLoadingg(false);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Utils.snackBar(response.message, context, false);
      AppHelperFunctions.navigateToScreenName(context, RoutesName.verify);
    } catch (err) {
      _logger.e("------------- \n in auth view model");
      _logger.e(err);
      _logger.e("-------------");
      setLoadingg(false);
      Navigator.pop(context);
      Utils.snackBar(err.toString(), context, true);
    }
  }

  Future<void> verifyApi(String code, BuildContext context) async {
    setLoadingg(true);
    Utils.showLoading(context);
    await Future.delayed(Duration(seconds: 2));
    try {
      final response = await authRepoImpl.verifyCode(code);

      _logger.d(response.toString());
      setLoadingg(false);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Utils.snackBar(response.message, context, false);
      AppHelperFunctions.navigateToScreenAndRemove(context, RoutesName.menuBar);
    } catch (err) {
      _logger.e("------------- \n in auth view model");
      _logger.e(err);
      _logger.e("-------------");
      setLoadingg(false);
      Navigator.pop(context);
      Utils.snackBar(err.toString(), context, true);
    }
  }
}
