import 'package:hive/hive.dart';

part "namhoc_hocky.local.g.dart";

@HiveType(typeId: 8)
class NamhocHocky extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int namBatDau;

  @HiveField(2)
  final int namKetThuc;

  @HiveField(3)
  final int hocky;

  @HiveField(4)
  final DateTime ngayBatDau;

  @HiveField(5)
  final bool? stt;

  NamhocHocky({
    required this.id,
    required this.namBatDau,
    required this.namKetThuc,
    required this.hocky,
    required this.ngayBatDau,
    required this.stt,
  });

  NamhocHocky.fromNamhocHocky(NamhocHocky namhocHocky)
      : id = namhocHocky.id,
        namBatDau = namhocHocky.namBatDau,
        namKetThuc = namhocHocky.namKetThuc,
        hocky = namhocHocky.hocky,
        ngayBatDau = namhocHocky.ngayBatDau,
        stt = namhocHocky.stt;

  // Chuyển từ JSON thành đối tượng HocKy
  factory NamhocHocky.fromJson(Map<String, dynamic> json) {
    return NamhocHocky(
      id: json['id'],
      namBatDau: json['nam_bat_dau'],
      namKetThuc: json['nam_ket_thuc'],
      hocky: json['hocky'],
      ngayBatDau: DateTime.parse(json['ngay_bat_dau']),
      stt: json['stt'],
    );
  }

  // Chuyển từ đối tượng HocKy thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nam_bat_dau': namBatDau,
      'nam_ket_thuc': namKetThuc,
      'hocky': hocky,
      'ngay_bat_dau': ngayBatDau,
      'stt': stt,
    };
  }
}

class DSNamhocHocky {
  List<NamhocHocky>? dsNamhocHocKy;
  DSNamhocHocky({this.dsNamhocHocKy});

  DSNamhocHocky.fromJson(List<dynamic> json) {
    dsNamhocHocKy = <NamhocHocky>[];
    json.forEach((v) {
      dsNamhocHocKy!.add(NamhocHocky.fromJson(v));
    });
  }
  DSNamhocHocky.fromLocal(List<NamhocHocky> dsLocal) {
    dsNamhocHocKy = <NamhocHocky>[];
    dsLocal.forEach((v) {
      dsNamhocHocKy!.add(NamhocHocky.fromNamhocHocky(v));
    });
  }

  List<Map<String, dynamic>> toJson() {
    if (this.dsNamhocHocKy != null) return this.dsNamhocHocKy!.map((v) => v.toJson()).toList();
    return [];
  }
}
