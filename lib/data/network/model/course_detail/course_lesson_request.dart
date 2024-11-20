class DiemDanhFormRequest {
  int idLophp;
  String noiDung;
  String toaDoX;
  String toaDoY;
  double thoihan;
  int typeRequest;
  // DIEM_DANH_THUONG, DIEM_DANH_QR, DIEM_DANH_QR_VI_TRI

  // Main constructor with parameters
  DiemDanhFormRequest(
    this.noiDung,
    this.toaDoX,
    this.toaDoY,
    this.typeRequest, {
    required this.idLophp,
    this.thoihan = 5,
  });

  // Parameterless constructor with default values
  DiemDanhFormRequest.defaultConstructor()
      : idLophp = 0,
        noiDung = '',
        toaDoX = 'z',
        toaDoY = 'z',
        thoihan = 5,
        typeRequest = 0;

  // Method to convert an object instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'idLophp': idLophp,
      'noiDung': noiDung,
      'toaDoX': toaDoX,
      'toaDoY': toaDoY,
      'thoiHan': thoihan,
      // Convert enum to string
    };
  }
}
