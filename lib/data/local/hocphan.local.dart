import 'package:app_giang_vien_vku/data/local/baonghi_baobu.local.dart';
import 'package:hive/hive.dart';

part 'hocphan.local.g.dart';

class LopHocPhan {
  final int idLopHocPhan;
  final List<ThoiKhoaBieu> dsTKB;

  LopHocPhan({
    required this.idLopHocPhan,
    required this.dsTKB,
  });

  factory LopHocPhan.fromJson(Map<String, dynamic> json) {
    return LopHocPhan(
      idLopHocPhan: json['id_lophp'],
      dsTKB: [],
    );
  }

  // Phương thức chuyển đối tượng Dart sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id_lophp': idLopHocPhan,
      'tkb': dsTKB.map((tkbItem) => tkbItem.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 7)
class ThoiKhoaBieu {
  @HiveField(0)
  final int idHocPhan;

  @HiveField(1)
  String tenThoiKhoaBieu;

  @HiveField(2)
  final int thu;

  @HiveField(3)
  final int tietBatDau;

  @HiveField(4)
  final int tietKetThuc;

  @HiveField(5)
  final int tuanBatDau;

  @HiveField(6)
  final int tuanKetThuc;

  @HiveField(7)
  final String phong;

  @HiveField(8)
  final List<BaoBu> dsBaoBu;

  @HiveField(9)
  final List<BaoNghi> dsBaoNghi;

  @HiveField(10)
  final List<int> dsTuanNghi;

  @HiveField(11)
  final int nhom;

  @HiveField(12)
  final String giangVienDay;

  @HiveField(13)
  final int idThoiKhoaBieu;

  ThoiKhoaBieu({
    required this.idHocPhan,
    required this.thu,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.tuanBatDau,
    required this.tuanKetThuc,
    required this.phong,
    required this.tenThoiKhoaBieu,
    required this.dsBaoBu,
    required this.dsBaoNghi,
    required this.dsTuanNghi,
    required this.giangVienDay,
    required this.nhom,
    required this.idThoiKhoaBieu,
  });

  // Helper method to parse
  static Map<String, dynamic> parseQRContent(String? qrContent) {
    List<String> qrSplit = qrContent?.split(',') ?? [];

    return {
      'longtitude': qrSplit.isNotEmpty ? qrSplit[0] : '',
      'latitude': qrSplit.length > 1 ? qrSplit[1] : '',
      'timeEnd': (qrSplit.length > 3 && qrSplit[3].isNotEmpty) ? DateTime.tryParse(qrSplit[3]) : null,
    };
  }

  // Tạo một phương thức factory để chuyển đổi từ JSON sang đối tượng Dart
  factory ThoiKhoaBieu.fromJson(Map<String, dynamic> json) {
    List<int> dsTuanNghi = (json['tuan_nghi'] != null) ? (json['tuan_nghi'] as String).split('&').map(int.parse).toList() : [];
    List<BaoNghi> dsBaoNghi = (json['bao_nghi'] != null) ? (json['bao_nghi'] as String).split('#').map((str) => BaoNghi.fromString(str)).toList() : [];
    List<BaoBu> dsBaoBu = (json['bao_bu'] != null) ? (json['bao_bu'] as String).split('#').map((str) => BaoBu.fromString(str)).toList() : [];

    // Có thể loại bỏ luôn nhưng list báo bù, list báo nghỉ, có trạng thái = 1

    // sort lại theo ngày
    dsBaoBu.sort((a, b) => b.ngayTao.compareTo(a.ngayTao));
    dsBaoNghi.sort((a, b) => b.ngayTao.compareTo(a.ngayTao));

    return ThoiKhoaBieu(
        idHocPhan: json['id_lophp'],
        tenThoiKhoaBieu: json['ten_hoc_phan'],
        thu: json['thu'],
        tietBatDau: json['tiet_bat_dau'],
        tietKetThuc: json['tiet_ket_thuc'],
        tuanBatDau: json['tuan_bat_dau'],
        tuanKetThuc: json['tuan_ket_thuc'],
        phong: json['phong'],
        dsBaoBu: dsBaoBu,
        dsBaoNghi: dsBaoNghi,
        dsTuanNghi: dsTuanNghi,
        giangVienDay: json['giang_vien_day'],
        nhom: json['id_nhom'],
        idThoiKhoaBieu: json['id_tkb']);
  }

  // Phương thức chuyển đối tượng Dart sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id_lophp': idHocPhan,
      'thu': thu,
      'tiet_bat_dau': tietBatDau,
      'tiet_ket_thuc': tietKetThuc,
      'tuan_bat_dau': tuanBatDau,
      'tuan_ket_thuc': tuanKetThuc,
      'phong': phong,
      'bao_bu': dsBaoBu,
      'bao_nghi': dsBaoNghi,
      'tuan_nghi': dsTuanNghi,
      'ten_hoc_phan': tenThoiKhoaBieu,
      "giang_vien": giangVienDay,
      'nhom': nhom,
      'id_tkb': idThoiKhoaBieu
    };
  }

  ThoiKhoaBieu.fromThoiKhoaBieu(ThoiKhoaBieu other)
      : idHocPhan = other.idHocPhan,
        thu = other.thu,
        tietBatDau = other.tietBatDau,
        tietKetThuc = other.tietKetThuc,
        tuanBatDau = other.tuanBatDau,
        tuanKetThuc = other.tuanKetThuc,
        phong = other.phong,
        tenThoiKhoaBieu = other.tenThoiKhoaBieu,
        dsBaoBu = other.dsBaoBu,
        dsBaoNghi = other.dsBaoNghi,
        dsTuanNghi = other.dsTuanNghi,
        giangVienDay = other.giangVienDay,
        nhom = other.nhom,
        idThoiKhoaBieu = other.idThoiKhoaBieu;

  String getDisplayWeek() {
    if (dsTuanNghi.isEmpty) return "$tuanBatDau -> $tuanKetThuc";
    // List<int> excludedNumbers = tuanNghi!.split(',').map((e) => int.parse(e.trim())).toList();
    List<int> fullRange = List.generate(tuanKetThuc - tuanBatDau + 1, (index) => tuanBatDau + index);

    List<int> remainingNumbers = fullRange.where((number) => !dsTuanNghi.contains(number)).toList();
    List<String> ranges = [];

    int start = remainingNumbers.first; // Số bắt đầu của dãy hiện tại
    int end = start; // Số kết thúc của dãy hiện tại

    for (int i = 1; i < remainingNumbers.length; i++) {
      if (remainingNumbers[i] == end + 1) {
        // Nếu số tiếp theo liên tục với số hiện tại, cập nhật số kết thúc của dãy hiện tại
        end = remainingNumbers[i];
      } else {
        // Nếu không liên tục, thêm dãy hiện tại vào danh sách kết quả và bắt đầu dãy mới
        ranges.add(start == end ? '$start' : '$start->$end');
        start = remainingNumbers[i];
        end = start;
      }
    }

    ranges.add(start == end ? '$start' : '$start->$end');
    // Kết quả: ví dụ: 1->3, 6, 9->15
    return ranges.join(', ');
  }

  int caculateSoTietBaoNghi() {
    var dsBaoNghiPre = dsBaoNghi.where((element) => element.trangthai).toList();
    return (tietKetThuc - tietBatDau + 1) * dsBaoNghiPre.length;
  }

  int caculateSoTietBaoBu() {
    var dsBaoBuPre = dsBaoBu.where((element) => element.trangthai).toList();
    int soTiet = 0;
    for (var baoBu in dsBaoBuPre) {
      soTiet += (baoBu.tietKetThuc - baoBu.tietBatDau + 1);
    }
    return soTiet;
  }
}

class DSThoiKhoaBieu {
  List<ThoiKhoaBieu>? dsThoiKhoaBieu;
  DSThoiKhoaBieu({this.dsThoiKhoaBieu});

  DSThoiKhoaBieu.fromJson(List<dynamic> jsonList) {
    dsThoiKhoaBieu = <ThoiKhoaBieu>[];
    for (var json in jsonList) {
      dsThoiKhoaBieu!.add(ThoiKhoaBieu.fromJson(json));
    }
  }
  DSThoiKhoaBieu.fromDSThoiKhoaBieu(List<ThoiKhoaBieu> dsTKB) {
    dsThoiKhoaBieu = dsTKB;
  }

  List<Map<String, dynamic>> toJson() {
    if (dsThoiKhoaBieu != null) return dsThoiKhoaBieu!.map((v) => v.toJson()).toList();
    return [];
  }
}
