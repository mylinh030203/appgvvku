import 'package:app_giang_vien_vku/data/local/qr_base64.local.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:flutter/foundation.dart';

class QRBase64LocalImpl extends BoxLocal<List<QRBase64>> implements BaseLocal<List<QRBase64>> {
  QRBase64LocalImpl() : super(BoxType.QR_BASE64.name);

  @override
  Future<void> clearData() async {
    await clearValue();
    if (kDebugMode) {
      print("DSHocPhan cleared from DataLocal");
    }
  }

  @override
  Future<List<QRBase64>?> getData() async {
    await initializeBox();
    List<dynamic>? dsQRBase64 = box!.get(boxName);
    if (dsQRBase64 != null) return dsQRBase64.cast<QRBase64>();
    return null;
  }

  @override
  Future<void> setData(List<QRBase64> data) async {
    await setValue(data);
  }

  @override
  Future<bool> isHadInit() async {
    return await isInit();
  }
}
