// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_base64.local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QRBase64Adapter extends TypeAdapter<QRBase64> {
  @override
  final int typeId = 1;

  @override
  QRBase64 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QRBase64(
      idHocPhan: fields[0] as int,
      thoiGianTao: fields[1] as int,
      contentBase64: fields[2] as String,
      idBuoiHoc: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QRBase64 obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idHocPhan)
      ..writeByte(1)
      ..write(obj.thoiGianTao)
      ..writeByte(2)
      ..write(obj.contentBase64)
      ..writeByte(3)
      ..write(obj.idBuoiHoc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QRBase64Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
