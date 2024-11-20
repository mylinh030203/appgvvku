import 'package:app_giang_vien_vku/data/local/namhoc_hocky.local.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';

import 'package:flutter/foundation.dart';

class NamhocHockyLocalImpl extends BoxLocal<List<NamhocHocky>> implements BaseLocal<List<NamhocHocky>> {
  NamhocHockyLocalImpl() : super(BoxType.NAMHOC_HOCKY_BOX.name);

  @override
  Future<void> clearData() async {
    await clearValue();
    if (kDebugMode) {
      print("DSHocPhan cleared from DataLocal");
    }
  }

  @override
  Future<List<NamhocHocky>?> getData() async {
    await initializeBox();
    List<dynamic>? dsNamhocHocKy = box!.get(boxName);
    if (dsNamhocHocKy != null) return dsNamhocHocKy.cast<NamhocHocky>();
    return null;
  }

  @override
  Future<void> setData(List<NamhocHocky> data) async {
    await setValue(data);
  }

  @override
  Future<bool> isHadInit() async {
    return await isInit();
  }
}
