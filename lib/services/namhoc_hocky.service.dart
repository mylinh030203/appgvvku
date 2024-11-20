import 'package:app_giang_vien_vku/data/local/namhoc_hocky.local.dart';
import 'package:app_giang_vien_vku/data/response/ApiResponse.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/repository/course/namhoc_hocky.repository.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:flutter/material.dart';

class NamHocHocKyService with ChangeNotifier {
  final NamhocHockyRepository namhochockyRepoImpl;
  final BaseLocal<List<NamhocHocky>> namhocHockybox;
  final BaseLocal<String> jwtTokenBox;
  NamHocHocKyService({required this.namhochockyRepoImpl, required this.namhocHockybox, required this.jwtTokenBox});

  // Variable
  ApiResponse<DSNamhocHocky> _dsNamhocHocKy = ApiResponse.loading();
  NamhocHocky? namhocHockyHienTai;
  List<DateTime> dsTuanT2 = [];
  int _tuanHienTai = 0;
  int get tuanHienTai => _tuanHienTai;

  // get
  ApiResponse<DSNamhocHocky> get dsNamhocHocKy => _dsNamhocHocKy;

  Future<void> fetchDSNamhocHockyApi() async {
    _dsNamhocHocKy.status = Status.LOADING;
    notifyListeners();
    String? token = await jwtTokenBox.getData();

    namhochockyRepoImpl.fecthNamhocHocky(token!).then((value) async {
      _dsNamhocHocKy = ApiResponse.completed(value);
      getNamhocHocKyHientai(DateTime.now().year);
      createDsDauTuan();
      await namhocHockybox.setData(value.dsNamhocHocKy!);
    }).onError((error, stackTrace) async {
      _dsNamhocHocKy = ApiResponse.error(error.toString());
      await loadDSNamhocHockyLocal();
    }).whenComplete(() => notifyListeners());
  }

  void createDsDauTuan() {
    if (namhocHockyHienTai != null) {
      getNamhocHocKyHientai(namhocHockyHienTai!.namBatDau);

      DateTime ngayBatDau = namhocHockyHienTai!.ngayBatDau;
      // DateTime ngayBatDau = DateTime(int.parse(timeline[2]), int.parse(timeline[1]), int.parse(timeline[0]));

      dsTuanT2.clear();
      dsTuanT2.add(ngayBatDau);

      while ((namhocHockyHienTai!.hocky == 1 && ngayBatDau.month != 1) || (namhocHockyHienTai!.hocky == 2 && ngayBatDau.month != 9)) {
        ngayBatDau = ngayBatDau.add(const Duration(days: 7));
        dsTuanT2.add(ngayBatDau);
      }
    }
  }

  void getNamhocHocKyHientai(int year) {
    try {
      if (dsNamhocHocKy.data?.dsNamhocHocKy != null) {
        namhocHockyHienTai = (dsNamhocHocKy.data?.dsNamhocHocKy!.firstWhere((element) => element.namBatDau == year))!;
        _tuanHienTai = getWeekByDay(DateTime.now(), namhocHockyHienTai!.ngayBatDau);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          notifyListeners();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadDSNamhocHockyLocal() async {
    try {
      final localDSNamhocHocky = await namhocHockybox.getData();
      if (localDSNamhocHocky != null) {
        _dsNamhocHocKy = ApiResponse.completed(DSNamhocHocky.fromLocal(localDSNamhocHocky));

        getNamhocHocKyHientai(DateTime.now().year);
        createDsDauTuan();
      } else {
        _dsNamhocHocKy = ApiResponse.error("Không có kết nối mạng");
      }
    } catch (e) {
      print("Không load đc local data: $e");
    }
  }
}
