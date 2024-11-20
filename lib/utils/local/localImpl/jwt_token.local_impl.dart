import '../BaseDataLocal.dart';

import 'package:flutter/foundation.dart';

class JWTTokenDataLocal extends BoxLocal<String> implements BaseLocal<String> {
  JWTTokenDataLocal() : super(BoxType.JWT_TOKEN_BOX.name);

  @override
  Future<void> clearData() async {
    await clearValue();
    if (kDebugMode) {
      print("JWTTokenDataLocal cleared from DataLocal");
    }
  }

  @override
  Future<String?> getData() async {
    await initializeBox();
    var token = box!.get(boxName);
    return token;
  }

  @override
  Future<void> setData(String data) async {
    await setValue(data);
  }

  @override
  Future<bool> isHadInit() async {
    return await isInit();
  }
}
