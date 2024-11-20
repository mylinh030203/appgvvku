import 'package:app_giang_vien_vku/constants/AppValue.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/response/ApiResponse.dart';
import 'package:app_giang_vien_vku/data/response/status.dart';
import 'package:app_giang_vien_vku/repository/course/hocphan.repository.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:flutter/cupertino.dart';

class LopHocPhanService with ChangeNotifier {
  final HocphanRepository hocPhanRepoImpl;
  final BaseLocal<String> jwtTokenBox;
  final BaseLocal<List<ThoiKhoaBieu>> thoiKhoaBieuBox;
  LopHocPhanService({required this.hocPhanRepoImpl, required this.jwtTokenBox, required this.thoiKhoaBieuBox});

  // Variable
  ApiResponse<DSThoiKhoaBieu> _dsThoiKhoaBieu = ApiResponse.loading();
  List<LopHocPhan> _dsLopHocPhan = [];
  ThoiKhoaBieu? _selectedHocPhan;

  // get
  ApiResponse<DSThoiKhoaBieu> get dsThoiKhoaBieu => _dsThoiKhoaBieu;
  List<LopHocPhan> get dsLopHocPhan => _dsLopHocPhan;
  ThoiKhoaBieu? get selectedThoiKhoaBieu => _selectedHocPhan;

  Future<void> fetchDSHocPhanApi(String namhoc, String hocky) async {
    _dsThoiKhoaBieu = ApiResponse.loading();
    notifyListeners();
    String? token = await jwtTokenBox.getData();

    await hocPhanRepoImpl.fetchHocphanByNamhocHocky(token!, namhoc, hocky).then((value) async {
      _dsThoiKhoaBieu = ApiResponse.completed(value);
      setDSLopHocPhan(value.dsThoiKhoaBieu!);
      await thoiKhoaBieuBox.setData(value.dsThoiKhoaBieu!);
    }).onError((error, stackTrace) async {
      _dsThoiKhoaBieu = ApiResponse.error(error.toString());
      await loadDSHocPhanLocal(int.parse(namhoc), int.parse(hocky));
    }).whenComplete(() => notifyListeners());
  }

  void setDSLopHocPhan(List<ThoiKhoaBieu> dsTKB) {
    dsLopHocPhan.clear();
    Map<int, LopHocPhan> groupedMap = {};
    for (var thoiKhoaBieu in dsTKB) {
      var key = thoiKhoaBieu.nhom == 0 ? thoiKhoaBieu.idHocPhan : thoiKhoaBieu.nhom;
      if (groupedMap.containsKey(key)) {
        groupedMap[key]?.dsTKB.add(thoiKhoaBieu);
      } else {
        groupedMap[key] = LopHocPhan(
          idLopHocPhan: key,
          dsTKB: [thoiKhoaBieu],
        );
      }
    }
    _dsLopHocPhan = groupedMap.values.toList();
    notifyListeners();
  }

  void setThoiKhoaBieu(ThoiKhoaBieu tkb) {
    _selectedHocPhan = tkb;
    notifyListeners();
  }

  void setThoiKhoaBieuByIdTkb(int idTkb) {
    _selectedHocPhan = _dsThoiKhoaBieu.data!.dsThoiKhoaBieu?.firstWhere((element) => element.idThoiKhoaBieu == idTkb);
    notifyListeners();
  }

  Future<void> loadDSHocPhanLocal(int namhoc, int hocky) async {
    var semester = AppValues.getCurrentSemester();
    try {
      final dsThoiKhoaBieuLocal = await thoiKhoaBieuBox.getData();

      if (semester[0] == namhoc && semester[1] == hocky) {
        _dsThoiKhoaBieu = ApiResponse.completed(DSThoiKhoaBieu.fromDSThoiKhoaBieu(dsThoiKhoaBieuLocal!));
        setDSLopHocPhan(dsThoiKhoaBieuLocal);
      } else {
        _dsThoiKhoaBieu = ApiResponse.error("Không có kết nối mạng");
      }
    } catch (e) {
      print(e);
    }
  }
}
