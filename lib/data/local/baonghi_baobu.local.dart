import 'package:hive/hive.dart';

part 'baonghi_baobu.local.g.dart';

@HiveType(typeId: 9)
class BaoNghi {
  @HiveField(0)
  final int tuanNghi;

  @HiveField(1)
  final String lyDo;

  @HiveField(2)
  final DateTime ngayTao;

  @HiveField(3)
  final bool trangthai; //1 Hiện, 0 ẩn

  BaoNghi({required this.tuanNghi, required this.lyDo, required this.ngayTao, required this.trangthai});

  // Helper method to parse from String to bao nghỉ
  static Map<String, dynamic> parseBaoNghiContent(String qrContent) {
    List<String> qrSplit = qrContent.split('&');

    return {
      'tuanNghi': int.parse(qrSplit[0]),
      'lyDo': qrSplit[1],
      'ngayTao': DateTime.parse(qrSplit[2]),
      'trangThai': int.parse(qrSplit[3]),
    };
  }

  factory BaoNghi.fromString(String str) {
    var mapBaoNghi = parseBaoNghiContent(str);
    return BaoNghi(
      tuanNghi: mapBaoNghi['tuanNghi'],
      lyDo: mapBaoNghi['lyDo'],
      ngayTao: mapBaoNghi['ngayTao'],
      trangthai: mapBaoNghi['trangThai'] == 1,
    );
  }
}

@HiveType(typeId: 10)
class BaoBu {
  @HiveField(0)
  final int tuanBu;
  @HiveField(1)
  final int tietBatDau;
  @HiveField(2)
  final int tietKetThuc;
  @HiveField(3)
  final int thu;
  @HiveField(4)
  final String tenPhong;
  @HiveField(5)
  final DateTime ngayTao;
  @HiveField(6)
  final bool trangthai; // 1 Hiện, 0 ẩn

  BaoBu({
    required this.tuanBu,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.thu,
    required this.tenPhong,
    required this.ngayTao,
    required this.trangthai,
  });

  // Helper method to parse from String to bao bu
  static Map<String, dynamic> parseBaoBuContent(String qrContent) {
    List<String> qrSplit = qrContent.split('&');

    return {
      'tuan_bao_bu': int.parse(qrSplit[0]),
      'tiet_bat_dau': int.parse(qrSplit[1]),
      'tiet_ket_thuc': int.parse(qrSplit[2]),
      'thu': int.parse(qrSplit[3]),
      'ten_phong': qrSplit[4],
      'ngay_tao': DateTime.parse(qrSplit[5]),
      'trang_thai': int.parse(qrSplit[6]),
    };
  }

// Factory method to create BaoBu from a string
  factory BaoBu.fromString(String str) {
    var mapBaoBu = parseBaoBuContent(str);
    return BaoBu(
      tuanBu: mapBaoBu['tuan_bao_bu'],
      tietBatDau: mapBaoBu['tiet_bat_dau'],
      tietKetThuc: mapBaoBu['tiet_ket_thuc'],
      thu: mapBaoBu['thu'],
      tenPhong: mapBaoBu['ten_phong'],
      ngayTao: mapBaoBu['ngay_tao'],
      trangthai: mapBaoBu['trang_thai'] == 1,
    );
  }
}
