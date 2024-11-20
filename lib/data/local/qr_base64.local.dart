import 'package:hive/hive.dart';

part "qr_base64.local.g.dart";

@HiveType(typeId: 1)
class QRBase64 extends HiveObject {
  @HiveField(0)
  final int idHocPhan;

  @HiveField(1)
  final int thoiGianTao;

  @HiveField(2)
  String contentBase64;

  @HiveField(3)
  final int idBuoiHoc;

  QRBase64({
    required this.idHocPhan,
    required this.thoiGianTao,
    required this.contentBase64,
    required this.idBuoiHoc,
  });

  QRBase64.fromQRBase64(QRBase64 qr)
      : idHocPhan = qr.idHocPhan,
        thoiGianTao = qr.thoiGianTao,
        contentBase64 = qr.contentBase64,
        idBuoiHoc = qr.idBuoiHoc;
}
