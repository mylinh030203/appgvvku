import 'package:hive/hive.dart';

part 'user.local.g.dart'; // Phải có phần này

@HiveType(typeId: 0)
class UserLocal extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String maSV;
  @HiveField(2)
  final String hoTen;
  @HiveField(3)
  final String? lopSinhHoat;
  @HiveField(4)
  final String nien_khoa;
  @HiveField(5)
  final String nganh;
  @HiveField(6)
  final String? chuyenNganh;
  @HiveField(7)
  final int hocKyHienTai;
  @HiveField(8)
  final String numberCIC;
  @HiveField(9)
  final String? ngaySinh;
  @HiveField(10)
  final String? noiSinh;
  @HiveField(11)
  final String? gioiTinh;
  @HiveField(12)
  final String? queQuan;
  @HiveField(13)
  final String? danToc;
  @HiveField(14)
  final String? dienThoai;
  @HiveField(15)
  final String? email;
  @HiveField(16)
  final bool? doanVien;
  @HiveField(17)
  final String? dienChinhSach;
  @HiveField(18)
  final String? dienThoaiGD;
  @HiveField(19)
  final int? namTotNghiep;
  @HiveField(20)
  final String? truongThptTotNghiep;
  @HiveField(21)
  final String? maTruongThptTotNghiep;
  @HiveField(22)
  final bool? status;
  @HiveField(23)
  final String? ngayCapCccd;
  @HiveField(24)
  final String? noiCapCccd;
  @HiveField(25)
  final String? tonGiao;
  @HiveField(26)
  final String? cuTruTinh;
  @HiveField(27)
  final String? cuTruQuanHuyen;
  @HiveField(28)
  final String? cuTruXaPhuong;
  @HiveField(29)
  final String? cuTruToThon;
  @HiveField(30)
  final String? maSoBHYT;
  @HiveField(31)
  final String emailVku;
  @HiveField(32)
  final String? ngayKetNap;

  UserLocal({
    required this.id,
    required this.maSV,
    required this.hoTen,
    this.lopSinhHoat,
    required this.nien_khoa,
    required this.nganh,
    this.chuyenNganh,
    required this.hocKyHienTai,
    required this.numberCIC,
    this.ngaySinh,
    this.noiSinh,
    this.gioiTinh,
    this.queQuan,
    this.danToc,
    this.dienThoai,
    this.email,
    this.doanVien,
    this.dienChinhSach,
    this.dienThoaiGD,
    this.namTotNghiep,
    this.truongThptTotNghiep,
    this.maTruongThptTotNghiep,
    this.status,
    this.ngayCapCccd,
    this.noiCapCccd,
    this.tonGiao,
    this.cuTruTinh,
    this.cuTruQuanHuyen,
    this.cuTruXaPhuong,
    this.cuTruToThon,
    this.maSoBHYT,
    required this.emailVku,
    this.ngayKetNap,
  });

  factory UserLocal.fromJson(Map<String, dynamic> json) {
    return UserLocal(
      id: json['id'],
      maSV: json['maSV'],
      hoTen: json['hoTen'],
      lopSinhHoat: json['lopSinhHoat'],
      nien_khoa: json['khoa'],
      nganh: json['nganh'],
      chuyenNganh: json['chuyenNganh'],
      hocKyHienTai: json['hocKyHienTai'],
      numberCIC: json['numberCIC'],
      ngaySinh: json['ngay_sinh'],
      noiSinh: json['noi_sinh'],
      gioiTinh: json['gioi_tinh'],
      queQuan: json['que_quan'],
      danToc: json['dan_toc'],
      dienThoai: json['dien_thoai'],
      email: json['email'],
      doanVien: json['doan_vien'],
      dienChinhSach: json['dien_chinh_sach'],
      dienThoaiGD: json['dien_thoai_gd'],
      namTotNghiep: json['nam_tot_nghiep'],
      truongThptTotNghiep: json['truongthpttotnghiep'],
      maTruongThptTotNghiep: json['matruongthpttotnghiep'],
      status: json['status'],
      ngayCapCccd: json['ngaycapcccd'],
      noiCapCccd: json['noicapcccd'],
      tonGiao: json['ton_giao'],
      cuTruTinh: json['cu_tru_tinh'],
      cuTruQuanHuyen: json['cu_tru_quan_huyen'],
      cuTruXaPhuong: json['cu_tru_xa_phuong'],
      cuTruToThon: json['cu_tru_to_thon'],
      maSoBHYT: json['ma_so_BHYT'],
      emailVku: json['emailvku'],
      ngayKetNap: json['ngay_ket_nap'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'maSV': maSV,
      'hoTen': hoTen,
      'lopSinhHoat': lopSinhHoat,
      'khoa': nien_khoa,
      'nganh': nganh,
      'chuyenNganh': chuyenNganh,
      'hocKyHienTai': hocKyHienTai,
      'numberCIC': numberCIC,
      'ngay_sinh': ngaySinh,
      'noi_sinh': noiSinh,
      'gioi_tinh': gioiTinh,
      'que_quan': queQuan,
      'dan_toc': danToc,
      'dien_thoai': dienThoai,
      'email': email,
      'doan_vien': doanVien,
      'dien_chinh_sach': dienChinhSach,
      'dien_thoai_gd': dienThoaiGD,
      'nam_tot_nghiep': namTotNghiep,
      'truongthpttotnghiep': truongThptTotNghiep,
      'matruongthpttotnghiep': maTruongThptTotNghiep,
      'status': status,
      'ngaycapcccd': ngayCapCccd,
      'noicapcccd': noiCapCccd,
      'ton_giao': tonGiao,
      'cu_tru_tinh': cuTruTinh,
      'cu_tru_quan_huyen': cuTruQuanHuyen,
      'cu_tru_xa_phuong': cuTruXaPhuong,
      'cu_tru_to_thon': cuTruToThon,
      'ma_so_BHYT': maSoBHYT,
      'emailvku': emailVku,
      'ngay_ket_nap': ngayKetNap,
    };
  }

  factory UserLocal.updateField(UserLocal user) {
    return UserLocal(
      id: user.id,
      maSV: user.maSV,
      hoTen: user.hoTen,
      lopSinhHoat: user.lopSinhHoat,
      nien_khoa: user.nien_khoa,
      nganh: user.nganh,
      chuyenNganh: user.chuyenNganh,
      hocKyHienTai: user.hocKyHienTai,
      numberCIC: user.numberCIC,
      ngaySinh: user.ngaySinh,
      noiSinh: user.noiSinh,
      gioiTinh: user.gioiTinh,
      queQuan: user.queQuan,
      danToc: user.danToc,
      dienThoai: user.dienThoai,
      email: user.email,
      doanVien: user.doanVien,
      dienChinhSach: user.dienChinhSach,
      dienThoaiGD: user.dienThoaiGD,
      namTotNghiep: user.namTotNghiep,
      truongThptTotNghiep: user.truongThptTotNghiep,
      maTruongThptTotNghiep: user.maTruongThptTotNghiep,
      status: user.status,
      ngayCapCccd: user.ngayCapCccd,
      noiCapCccd: user.noiCapCccd,
      tonGiao: user.tonGiao,
      cuTruTinh: user.cuTruTinh,
      cuTruQuanHuyen: user.cuTruQuanHuyen,
      cuTruXaPhuong: user.cuTruXaPhuong,
      cuTruToThon: user.cuTruToThon,
      maSoBHYT: user.maSoBHYT,
      emailVku: user.emailVku,
      ngayKetNap: user.ngayKetNap,
    );
  }
}
