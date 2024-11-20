// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'namhoc_hocky.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NamhocHockyAdapter extends TypeAdapter<NamhocHocky> {
  @override
  final int typeId = 8;

  @override
  NamhocHocky read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NamhocHocky(
      id: fields[0] as int,
      namBatDau: fields[1] as int,
      namKetThuc: fields[2] as int,
      hocky: fields[3] as int,
      ngayBatDau: fields[4] as DateTime,
      stt: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NamhocHocky obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.namBatDau)
      ..writeByte(2)
      ..write(obj.namKetThuc)
      ..writeByte(3)
      ..write(obj.hocky)
      ..writeByte(4)
      ..write(obj.ngayBatDau)
      ..writeByte(5)
      ..write(obj.stt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamhocHockyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
