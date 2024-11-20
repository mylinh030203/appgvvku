enum LoaiDiemDanh { CO_MAT, DI_TRE, VANG_PHEP, VANG }

class DiemDanh {
  final int idSv;
  final String maSV;
  LoaiDiemDanh loaiDiemDanh;
  final String hoTen;
  DiemDanh({
    required this.idSv,
    required this.maSV,
    required this.hoTen,
    required this.loaiDiemDanh,
  });

  // Factory constructor to create an object from a JSON map
  factory DiemDanh.fromJson(Map<String, dynamic> json) {
    return DiemDanh(
      idSv: json['idSv'],
      maSV: json['maSV'],
      hoTen: json['hoTen'],
      loaiDiemDanh: intToLoaiDiemDanh(json['loaiDiemDanh']),
    );
  }

  // Convert DiemDanh object to JSON
  Map<String, dynamic> toJson() {
    return {
      'idSv': idSv,
      'maSV': maSV,
      'hoTen': hoTen,
      'loaiDiemDanh': loaiDiemDanh,
    };
  }

  // Mapping between LoaiDiemDanh and int values
  static const Map<LoaiDiemDanh, int> _loaiDiemDanhToIntMap = {
    LoaiDiemDanh.CO_MAT: 0,
    LoaiDiemDanh.DI_TRE: 1,
    LoaiDiemDanh.VANG_PHEP: 2,
    LoaiDiemDanh.VANG: 4,
  };

  static const Map<int, LoaiDiemDanh> _intToLoaiDiemDanhMap = {
    0: LoaiDiemDanh.CO_MAT,
    1: LoaiDiemDanh.DI_TRE,
    2: LoaiDiemDanh.VANG_PHEP,
    4: LoaiDiemDanh.VANG,
  };

  set loaidiemDanh(LoaiDiemDanh loaidiemDanh) {}

// Convert LoaiDiemDanh to int
  static int loaiDiemDanhToInt(LoaiDiemDanh loaidiemdanh) {
    return _loaiDiemDanhToIntMap[loaidiemdanh] ?? 0;
  }

// Convert int to LoaiDiemDanh
  static LoaiDiemDanh intToLoaiDiemDanh(int loaidiemdanh) {
    return _intToLoaiDiemDanhMap[loaidiemdanh] ?? LoaiDiemDanh.CO_MAT;
  }
}

class SinhVienDiemDanh extends DiemDanh {
  int index;
  final String lopSinhHoat;
  final String email;
  double diemTruDD;
  final String? ghiChu;
  bool isCheckBox;

  SinhVienDiemDanh(
      {required super.idSv,
      required super.maSV,
      required super.loaiDiemDanh,
      required super.hoTen,
      required this.email,
      required this.lopSinhHoat,
      required this.diemTruDD,
      required this.ghiChu,
      this.isCheckBox = true,
      required this.index});

  factory SinhVienDiemDanh.fromJson(Map<String, dynamic> json, int index) {
    return SinhVienDiemDanh(
      idSv: json['idSv'],
      maSV: json['maSV'],
      email: json['email'],
      loaiDiemDanh: DiemDanh.intToLoaiDiemDanh(json['loaiDiemDanh']),
      lopSinhHoat: json['lopSinhHoat'],
      hoTen: json['hoTen'],
      diemTruDD: json['diemTruDD'].toDouble(),
      ghiChu: json['ghiChu'] ?? "",
      isCheckBox: true, index: index, // Default to false if not provided
    );
  }
  // Convert SinhVienDiemDanh object to JSON
  Map<String, dynamic> toJson() {
    return {
      'idSv': idSv,
      'maSV': maSV,
      'email': email,
      'loaiDiemDanh': loaiDiemDanh,
      'lopSinhHoat': lopSinhHoat,
      'hoTen': hoTen,
      'diemTruDD': diemTruDD,
      'ghiChu': ghiChu,
      'isCheckBox': isCheckBox,
    };
  }
}

class DSSinhVienDiemDanh {
  List<SinhVienDiemDanh>? dsSinhVienDiemDanh;
  DSSinhVienDiemDanh({this.dsSinhVienDiemDanh});

  DSSinhVienDiemDanh.fromJson(List<dynamic> json) {
    dsSinhVienDiemDanh = <SinhVienDiemDanh>[];
    for (var entry in json.asMap().entries) {
      var index = entry.key; // Get the index
      var v = entry.value; // Get the value at this index
      dsSinhVienDiemDanh!.add(SinhVienDiemDanh.fromJson(v, index));
    }
  }

  List<Map<String, dynamic>> toJson() {
    if (dsSinhVienDiemDanh != null) return dsSinhVienDiemDanh!.map((v) => v.toJson()).toList();
    return [];
  }
}
