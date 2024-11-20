class SnackbarNotificationModel {
  dynamic content; // Nội dung thông báo
  bool isError; // Xác định trạng thái đã đọc

  SnackbarNotificationModel({required this.content, required this.isError});
}
