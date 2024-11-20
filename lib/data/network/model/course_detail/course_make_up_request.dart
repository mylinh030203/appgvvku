class CourseMakeUpFormRequest {
  int idTkb;
  DateTime dateMakeUp;
  int tuanBaoBu;
  int thu;
  int tietBatDau;
  int tietKetThuc;
  String? phongHoc;

  // Constructor chính
  CourseMakeUpFormRequest({
    required this.idTkb,
    required this.dateMakeUp,
    required this.tuanBaoBu,
    required this.thu,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.phongHoc,
  });

  // Phương thức chuyển đổi thành Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'idTkb': idTkb,
      'tuanBu': tuanBaoBu,
      'thu': thu,
      'tietBatDau': tietBatDau,
      'tietKetThuc': tietKetThuc,
      'tenPhong': phongHoc,
    };
  }

  // Constructor không tham số với giá trị mặc định
  CourseMakeUpFormRequest.defaultConstructor()
      : idTkb = 0,
        dateMakeUp = DateTime.now(),
        tuanBaoBu = 0,
        thu = 0,
        tietBatDau = 0,
        tietKetThuc = 0,
        phongHoc = null;
}
