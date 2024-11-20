import 'package:app_giang_vien_vku/data/local/user.local.dart';
import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

class Datalocal {
  static const String _boxName = 'userBox';
  // Lưu User
  static Future<void> setUser(UserLocal user) async {
    var box = await Hive.openBox(_boxName);
    await box.put('user', user);
    if (kDebugMode) {
      print("User saved in DataLocal: ${user.toJson()}");
    }
  }

  // Lấy User
  static Future<UserLocal?> getUser() async {
    var box = await Hive.openBox(_boxName);
    return box.get('user') as UserLocal?;
  }

  static Future<UserLocal?> checkUser() async {
    var box = await Hive.openBox(_boxName);
    return box.get('user') as UserLocal?;
  }

  // Xóa User
  static Future<void> clearUser() async {
    var box = await Hive.openBox(_boxName);
    await box.delete('user');
    if (kDebugMode) {
      print("User cleared from DataLocal");
    }
  }
}
