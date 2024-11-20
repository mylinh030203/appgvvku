import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/local/namhoc_hocky.local.dart';
import 'package:app_giang_vien_vku/data/local/qr_base64.local.dart';
import 'package:app_giang_vien_vku/utils/DataLocal.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingViewModel extends ChangeNotifier {
  final BaseLocal<String> _jwtTokenBox;
  final BaseLocal<List<ThoiKhoaBieu>> _thoiKhoaBieuBox;
  final BaseLocal<List<NamhocHocky>> _namhocHockybox;
  final BaseLocal<List<QRBase64>> _qrBase64Box;

  SettingViewModel({
    required jwtTokenBox,
    required thoiKhoaBieuBox,
    required namhocHockyBox,
    required qrBase64Box,
  })  : _jwtTokenBox = jwtTokenBox,
        _thoiKhoaBieuBox = thoiKhoaBieuBox,
        _namhocHockybox = namhocHockyBox,
        _qrBase64Box = qrBase64Box;

  // 0: ListView Danh sách học phần hiển thị bình thường
  // 1: (Điểm danh) ListView Danh sách học phần có thể ấn và vô form tạo buổi học
  // 2: (Báo nghỉ)   ----------------------------------ấn và vô form tạo báo nghỉ
  // 3: (Báo bù)  ------------------------------------ ấn vào vô form báo bù
  FunctionOptions _selectedOption = FunctionOptions.NONE;
  FunctionOptions get selectedOption => _selectedOption;

  void setSelectedOption(FunctionOptions option) {
    _selectedOption = option;
    notifyListeners();
  }

  Future<void> handleLogout(BuildContext context) async {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    Provider.of<BotttomNavigatorService>(context, listen: false).onRedirectScreen(BottomNavScreen.TRANGCHU);
    List<int> semtember = AppValues.getCurrentSemester();
    homeViewModel.nienKhoa = semtember[0];
    homeViewModel.hocky = semtember[1];
    Future.wait(
      [
        // Datalocal.clearMark(),
        Datalocal.clearUser(),
        _jwtTokenBox.clearData(),
        _thoiKhoaBieuBox.clearData(),
        _namhocHockybox.clearData(),
        _qrBase64Box.clearData(),
        // Datalocal.clearDSHocPhanLocal(),
        // Provider.of<ProfileViewModel>(context, listen: false).deleteProfile(),
      ],
    );
    AppHelperFunctions.navigateToScreenAndRemoveAll(context, RoutesName.login);
  }
}

enum FunctionOptions { NONE, DIEM_DANH, BAO_NGHI, BAO_BU }
