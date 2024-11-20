// ignore_for_file: constant_identifier_names, unnecessary_cast

import 'package:app_giang_vien_vku/data/local/namhoc_hocky.local.dart';
import 'package:hive/hive.dart';

enum BoxType { JWT_TOKEN_BOX, USER_BOX, NAMHOC_HOCKY_BOX, THOI_KHOA_BIEU_BOX, QR_BASE64 }

class BoxLocal<T> {
  final String boxName;
  Box? _box; // Cache the box

  Box? get box => _box;
  BoxLocal(this.boxName);

  // Initialize the box only once
  Future<void> initializeBox() async {
    var isHadInit = await isInit();

    if (!isHadInit) {
      _box = await Hive.openBox(boxName);
    }
  }

  // // // Get a value
  // Future<dynamic> getValue({T? defaultValue}) async {
  //   await _initializeBox();

  //   try {
  //     var rawData = _box!.get(boxName);
  //     return rawData;
  //   } catch (e) {
  //     print('Error getting data from Hive: $e');
  //     return null;
  //   }
  // }

  // Save a value
  Future<void> setValue(T value) async {
    await initializeBox();
    try {
      await _box!.put(boxName, value);
    } catch (e) {
      print('Error saving value to box: $e');
    }
  }

  // Clear a value
  Future<void> clearValue() async {
    await initializeBox();
    try {
      await _box!.delete(boxName);
    } catch (e) {
      print('Error clearing value from box: $e');
    }
  }

  // contain key
  Future<bool> isInit() async {
    return _box != null && _box!.isOpen;
  }

  // Optional: Close the box when it's no longer needed
  Future<void> closeBox() async {
    await _box!.close();
    // _box = null;
  }
}

abstract class BaseLocal<T> {
  Future<T?> getData();
  Future<void> setData(T data);
  Future<void> clearData();
  Future<bool> isHadInit();
}
