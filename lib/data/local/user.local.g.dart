// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocalAdapter extends TypeAdapter<UserLocal> {
  @override
  final int typeId = 0;

  @override
  UserLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocal(
      id: fields[0] as int,
      maSV: fields[1] as String,
      hoTen: fields[2] as String,
      lopSinhHoat: fields[3] as String?,
      nien_khoa: fields[4] as String,
      nganh: fields[5] as String,
      chuyenNganh: fields[6] as String?,
      hocKyHienTai: fields[7] as int,
      numberCIC: fields[8] as String,
      ngaySinh: fields[9] as String?,
      noiSinh: fields[10] as String?,
      gioiTinh: fields[11] as String?,
      queQuan: fields[12] as String?,
      danToc: fields[13] as String?,
      dienThoai: fields[14] as String?,
      email: fields[15] as String?,
      doanVien: fields[16] as bool?,
      dienChinhSach: fields[17] as String?,
      dienThoaiGD: fields[18] as String?,
      namTotNghiep: fields[19] as int?,
      truongThptTotNghiep: fields[20] as String?,
      maTruongThptTotNghiep: fields[21] as String?,
      status: fields[22] as bool?,
      ngayCapCccd: fields[23] as String?,
      noiCapCccd: fields[24] as String?,
      tonGiao: fields[25] as String?,
      cuTruTinh: fields[26] as String?,
      cuTruQuanHuyen: fields[27] as String?,
      cuTruXaPhuong: fields[28] as String?,
      cuTruToThon: fields[29] as String?,
      maSoBHYT: fields[30] as String?,
      emailVku: fields[31] as String,
      ngayKetNap: fields[32] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocal obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.maSV)
      ..writeByte(2)
      ..write(obj.hoTen)
      ..writeByte(3)
      ..write(obj.lopSinhHoat)
      ..writeByte(4)
      ..write(obj.nien_khoa)
      ..writeByte(5)
      ..write(obj.nganh)
      ..writeByte(6)
      ..write(obj.chuyenNganh)
      ..writeByte(7)
      ..write(obj.hocKyHienTai)
      ..writeByte(8)
      ..write(obj.numberCIC)
      ..writeByte(9)
      ..write(obj.ngaySinh)
      ..writeByte(10)
      ..write(obj.noiSinh)
      ..writeByte(11)
      ..write(obj.gioiTinh)
      ..writeByte(12)
      ..write(obj.queQuan)
      ..writeByte(13)
      ..write(obj.danToc)
      ..writeByte(14)
      ..write(obj.dienThoai)
      ..writeByte(15)
      ..write(obj.email)
      ..writeByte(16)
      ..write(obj.doanVien)
      ..writeByte(17)
      ..write(obj.dienChinhSach)
      ..writeByte(18)
      ..write(obj.dienThoaiGD)
      ..writeByte(19)
      ..write(obj.namTotNghiep)
      ..writeByte(20)
      ..write(obj.truongThptTotNghiep)
      ..writeByte(21)
      ..write(obj.maTruongThptTotNghiep)
      ..writeByte(22)
      ..write(obj.status)
      ..writeByte(23)
      ..write(obj.ngayCapCccd)
      ..writeByte(24)
      ..write(obj.noiCapCccd)
      ..writeByte(25)
      ..write(obj.tonGiao)
      ..writeByte(26)
      ..write(obj.cuTruTinh)
      ..writeByte(27)
      ..write(obj.cuTruQuanHuyen)
      ..writeByte(28)
      ..write(obj.cuTruXaPhuong)
      ..writeByte(29)
      ..write(obj.cuTruToThon)
      ..writeByte(30)
      ..write(obj.maSoBHYT)
      ..writeByte(31)
      ..write(obj.emailVku)
      ..writeByte(32)
      ..write(obj.ngayKetNap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
