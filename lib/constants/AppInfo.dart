import 'package:flutter/widgets.dart';

class AppInfo {
  static const baseUrl = 'https://nhaphoc.vku.udn.vn:8443/apiCTDT/api';
  // static const baseUrl = 'http://192.168.10.6:3333/api';
  // static const baseUrl = 'http://192.168.51.143:3333/api';

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isMobileLarge(BuildContext context) {
    return getScreenHeight(context) >= 830;
  }

  static bool isMobileMedium(BuildContext context) {
    return getScreenHeight(context) >= 660 && getScreenHeight(context) < 830;
  }

  static bool isMobileSmall(BuildContext context) {
    return getScreenHeight(context) < 660;
  }

  static const loginEndPoint = "$baseUrl/auth/signin";
  static const registerEndPoint = "$baseUrl/auth/register";
  static const hocphanFetchEndPoint = "$baseUrl/giangvien/tkb";
  static const namhochockyFetchEndPoint = "$baseUrl/namhoc_hocky";
  static const verifyEndPoint = "$baseUrl/auth/verify";
  static const courseAttendanceEndPoint = "$baseUrl/lich-trinh";
  static const courseStudentAttendanceEndPoint = "$baseUrl/giangvien/danh-sach-diem-danh-lophp";
  static const courseCreateLessonAttendanceEndPoint = "$baseUrl/giangvien/tao-diem-danh";
  static const courseCreateLessonAttendanceQREndPoint = "$baseUrl/giangvien/tao-diem-danh-QR";
  static const courseLessonDetailsQREndPoint = "$baseUrl/noi-dung-buoi-hoc";
  static const courseSaveAllAttendanaceQREndPoint = "$baseUrl/giangvien/luu-diem-danh";
  static const courseSaveStudentAttendanaceQREndPoint = "$baseUrl/giangvien/diem-danh-tung-sv";
  static const courseCreateCancellationEndPoint = "$baseUrl/giangvien/bao-nghi";
  static const courseDeleteCancellationEndPoint = "$baseUrl/giangvien/huy-bao-nghi";
  static const courseCreateMakeUpEndPoint = "$baseUrl/giangvien/bao-bu";
  static const courseDeleteMakeUpEndPoint = "$baseUrl/giangvien/huy-bao-bu";
}
