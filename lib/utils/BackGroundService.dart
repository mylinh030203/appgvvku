import 'dart:async';
import 'dart:ui';

import 'package:app_giang_vien_vku/data/network/BaseApiService.dart';
import 'package:app_giang_vien_vku/data/network/NetworkApiService.dart';
import 'package:app_giang_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_giang_vien_vku/utils/LocalNotificationService.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/utils/local/localImpl/jwt_token.local_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:intl/intl.dart';

class BackgroundService {
  Future<void> initialize() async {
    final service = FlutterBackgroundService();
    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onBackground: onIosBackground,
        onForeground: onStartSendDiemDanh,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStartSendDiemDanh,
        isForegroundMode: true,
      ),
    );
  }

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    // service.on('setAsBackground').listen((event) {
    //   service.setAsBackgroundService();
    // });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Thông tin học phần",
        content: "Updated at ${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())}",
      );
    }

    service.invoke('update', {
      "current_time": DateTime.now().toIso8601String(),
    });
  });
}

// Hàm thực hiện việc chạy nền
@pragma('vm:entry-point')
void onStartSendDiemDanh(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Listen for data passed to the service
  if (service is AndroidServiceInstance) {
    service.on('startWithParams').listen((params) {
      service.setAsForegroundService();

      var tenTKB = params?['tenTKB'];
      var timeEnd = DateTime.parse(params?['timeEnd']); // Example of parsing a string to DateTime
      var idBuoiHoc = params?['idBuoiHoc'];
      var idTKB = params?['idHocPhan'];
      var token = params?['token'];
      // : idTKB,

      Timer.periodic(const Duration(seconds: 1), (timer) async {
        final currentTime = DateTime.now();
        final difference = timeEnd.difference(currentTime);

        if (difference.isNegative) {
          timer.cancel();

          // Call your API to save attendance
          BaseApisService apiService = NetworkApiService(); // Khởi tạo dịch vụ của bạn
          BaseLocal<String> jwtTokenBox = JWTTokenDataLocal();
          try {
            var lthpRepoImpl = LichtrinhHocPhanRepoImpl(apiService: apiService, jwtTokenBox: jwtTokenBox);
            await lthpRepoImpl.saveDiemDanhSinhVien(idTKB, idBuoiHoc, token).then((value) async {
              await LocalNotifications().showNotification(
                title: "Đã điểm danh $tenTKB",
                body: "Số lượng điểm danh $value",
                payload: "abc",
              );
            }).onError(
              (error, stackTrace) async {
                await LocalNotifications().showNotification(
                  title: "Có lỗi xảy ra $tenTKB",
                  body: "Click vào để cập nhật điểm danh học phần!",
                  payload: "abc",
                );
              },
            );
            // await LocalNotifications().init();
            // Notify the user
          } catch (e) {
            print(e);
          } finally {
            // Stop the service
            service.stopSelf();
            service.invoke('stopService');
          }
        } else {
          String minutes = difference.inMinutes.remainder(60).toString().padLeft(2, '0');
          String seconds = difference.inSeconds.remainder(60).toString().padLeft(2, '0');
          // Update the notification

          service.setForegroundNotificationInfo(
            title: "Hạn QR $tenTKB",
            content: "Thời gian còn lại: $minutes:$seconds",
          );
        }
      });
    });
  }
}
