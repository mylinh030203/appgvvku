// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baonghi_baobu.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaoNghiAdapter extends TypeAdapter<BaoNghi> {
  @override
  final int typeId = 9;

  @override
  BaoNghi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaoNghi(
      tuanNghi: fields[0] as int,
      lyDo: fields[1] as String,
      ngayTao: fields[2] as DateTime,
      trangthai: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BaoNghi obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tuanNghi)
      ..writeByte(1)
      ..write(obj.lyDo)
      ..writeByte(2)
      ..write(obj.ngayTao)
      ..writeByte(3)
      ..write(obj.trangthai);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaoNghiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BaoBuAdapter extends TypeAdapter<BaoBu> {
  @override
  final int typeId = 10;

  @override
  BaoBu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaoBu(
      tuanBu: fields[0] as int,
      tietBatDau: fields[1] as int,
      tietKetThuc: fields[2] as int,
      thu: fields[3] as int,
      tenPhong: fields[4] as String,
      ngayTao: fields[5] as DateTime,
      trangthai: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BaoBu obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.tuanBu)
      ..writeByte(1)
      ..write(obj.tietBatDau)
      ..writeByte(2)
      ..write(obj.tietKetThuc)
      ..writeByte(3)
      ..write(obj.thu)
      ..writeByte(4)
      ..write(obj.tenPhong)
      ..writeByte(5)
      ..write(obj.ngayTao)
      ..writeByte(6)
      ..write(obj.trangthai);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaoBuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
