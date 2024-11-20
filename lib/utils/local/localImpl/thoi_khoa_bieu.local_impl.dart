import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';

import 'package:flutter/foundation.dart';

class ThoiKhoaBieuLocalImpl extends BoxLocal<List<ThoiKhoaBieu>> implements BaseLocal<List<ThoiKhoaBieu>> {
  ThoiKhoaBieuLocalImpl() : super(BoxType.THOI_KHOA_BIEU_BOX.name);

  @override
  Future<void> clearData() async {
    await clearValue();
    if (kDebugMode) {
      print("DSHocPhan cleared from DataLocal");
    }
  }

  @override
  Future<List<ThoiKhoaBieu>?> getData() async {
    await initializeBox();
    List<dynamic>? dsThoiKhoaBieu = box!.get(boxName);
    if (dsThoiKhoaBieu != null) return dsThoiKhoaBieu.cast<ThoiKhoaBieu>();
    return null;
  }

  @override
  Future<void> setData(List<ThoiKhoaBieu> data) async {
    await setValue(data);
  }

  @override
  Future<bool> isHadInit() async {
    return await isInit();
  }
}
