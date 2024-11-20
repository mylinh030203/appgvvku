// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hocphan.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThoiKhoaBieuAdapter extends TypeAdapter<ThoiKhoaBieu> {
  @override
  final int typeId = 7;

  @override
  ThoiKhoaBieu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThoiKhoaBieu(
      idHocPhan: fields[0] as int,
      thu: fields[2] as int,
      tietBatDau: fields[3] as int,
      tietKetThuc: fields[4] as int,
      tuanBatDau: fields[5] as int,
      tuanKetThuc: fields[6] as int,
      phong: fields[7] as String,
      tenThoiKhoaBieu: fields[1] as String,
      dsBaoBu: (fields[8] as List).cast<BaoBu>(),
      dsBaoNghi: (fields[9] as List).cast<BaoNghi>(),
      dsTuanNghi: (fields[10] as List).cast<int>(),
      giangVienDay: fields[12] as String,
      nhom: fields[11] as int,
      idThoiKhoaBieu: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ThoiKhoaBieu obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.idHocPhan)
      ..writeByte(1)
      ..write(obj.tenThoiKhoaBieu)
      ..writeByte(2)
      ..write(obj.thu)
      ..writeByte(3)
      ..write(obj.tietBatDau)
      ..writeByte(4)
      ..write(obj.tietKetThuc)
      ..writeByte(5)
      ..write(obj.tuanBatDau)
      ..writeByte(6)
      ..write(obj.tuanKetThuc)
      ..writeByte(7)
      ..write(obj.phong)
      ..writeByte(8)
      ..write(obj.dsBaoBu)
      ..writeByte(9)
      ..write(obj.dsBaoNghi)
      ..writeByte(10)
      ..write(obj.dsTuanNghi)
      ..writeByte(11)
      ..write(obj.nhom)
      ..writeByte(12)
      ..write(obj.giangVienDay)
      ..writeByte(13)
      ..write(obj.idThoiKhoaBieu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ThoiKhoaBieuAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
