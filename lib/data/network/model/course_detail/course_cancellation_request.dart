class CourseCancellationFormRequest {
  int idTKB;
  int idHocPhan;
  int tuanNghi;
  String lyDoNghi;
  bool isSendDaoTao;
  bool isSendSinhVien;

  CourseCancellationFormRequest({
    required this.idTKB,
    required this.idHocPhan,
    required this.tuanNghi,
    required this.lyDoNghi,
    required this.isSendDaoTao,
    required this.isSendSinhVien,
  });

  Map<String, dynamic> toJson() {
    return {
      'idTkb': idTKB,
      'idHocPhan': idHocPhan,
      'tuanNghi': tuanNghi,
      'lyDo': lyDoNghi,
      'isSendDaoTao': isSendDaoTao,
      'isSendSinhVien': isSendSinhVien,
    };
  }

  // Parameterless constructor with default values
  CourseCancellationFormRequest.defaultConstructor()
      : idTKB = 0,
        idHocPhan = 0,
        tuanNghi = 0,
        lyDoNghi = "",
        isSendDaoTao = false,
        isSendSinhVien = false;
}
