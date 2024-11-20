import 'dart:math';

import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/utils/ScreenInfo.dart';

class AppValues {
  static final classTimeStart = ['7h30', '8h30', '9h30', '10h30', '11h30', '13h00', '14h00', '15h00', '16h00', '17h00'];
  static final classTimeEnd = ['8h30', '9h30', '10h30', '11h30', '12h30', '14h00', '15h00', '16h00', '17h00', '18h00'];
  static final classTimePY = ['7h00 - 8h30', '8h30 - 10h00', '14h00 - 15h30', '15h30 - 17h30'];

  static final List<List<double>> stackPosition = [
    [-50.0, -10.0],
    [-10.0, -20.0],
    [-50.0, 20.0],
    [-30.0, 20.0],
    [50.0, -20.0],
    [50.0, -30.0],
    [-50.0, -20.0],
    [-50.0, -30.0],
    [-50.0, 20.0],
    [30.0, -10.0],
    [30.0, -50.0]
  ];

  static final groupedTimes = {
    0: [0, 450],
    1: [450, 510], // 7:30 - 8:30
    2: [510, 570], // 8:30 - 9:30
    3: [570, 630], //  9:30 - 10:30
    4: [630, 690], // 10:30 - 11:30
    5: [690, 750], // 11:30 - 12:30
    6: [780, 840], // 13:00 - 14:00
    7: [840, 900], // 14:00 - 15:00
    8: [900, 960], // 15:00 - 16:00
    9: [960, 1020], // 16:00 - 17:00
    10: [1020, 1080], //  17:00 - 18:00
    11: [1080, 1440]
  };

  static final Map<int, String> getWeekday = {
    2: 'MO', // Thứ Hai
    3: 'TU', // Thứ Ba
    4: 'WE', // Thứ Tư
    5: 'TH', // Thứ Năm
    6: 'FR', // Thứ Sáu
    7: 'SA', // Thứ Bảy
    8: 'SU', // Chủ Nhật
  };

  static int categorizeCurrentTime() {
    final now = DateTime.now();
    final inputMinutes = now.hour * 60 + now.minute;
    for (final entry in groupedTimes.entries) {
      final range = entry.value;
      final startMinutes = range[0];
      final endMinutes = range[1];

      if (inputMinutes >= startMinutes && inputMinutes < endMinutes) {
        return entry.key;
      }
    }
    return -1;
  }

  static List<double> getHeightBtn(isSmall, isMedium) {
    if (isSmall) return [220, 110];
    if (isMedium) return [310, 140];
    return [400, 140];
    // return [320, 160];
  }

  static double getResponsive(double widthSm, double widthMd, double widthLg) {
    switch (ScreenInfo().screenSize) {
      case ScreenSize.SMALL:
        return widthSm;
      case ScreenSize.MEDIUM:
        return widthMd;
      case ScreenSize.LARGE:
        return widthLg;
      default:
        return widthLg; // Default to large if no match
    }
  }

  // static double getSizeReponsite(widthSm, widthMd, widthLg, {required context}) {
  //   if (AppInfo.isMobileSmall(context)) return widthSm;
  //   if (AppInfo.isMobileMedium(context)) return widthMd;
  //   return widthLg;
  // }

  static List<List<double>> getStackPos() {
    Random random = Random();
    int length = AppValues.stackPosition.length;
    final index1 = random.nextInt(length);
    int index2;
    do {
      index2 = random.nextInt(length);
    } while (index2 == index1);
    final stackPos1 = AppValues.stackPosition[index1];
    final stackPos2 = AppValues.stackPosition[index2];
    return [stackPos1, stackPos2];
  }

  static List<int> getCurrentSemester() {
    DateTime now = DateTime.now();
    int month = now.month;
    int year = now.year;

    if (month >= 8 && month <= 12) {
      return [year, 1];
    } else if (month >= 1 && month <= 6) {
      return [year - 1, 2];
    } else if (month == 7) {
      return [year - 1, 0];
    }
    return [];
  }
}
