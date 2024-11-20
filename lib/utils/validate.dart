class Validate {
  static bool isEmail(String email) {
    // Sử dụng regex để kiểm tra email hợp lệ
   final RegExp emailVKURegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@vku\.udn\.vn$',
);

    return emailVKURegex.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    // Kiểm tra mật khẩu với ít nhất 8 ký tự, bao gồm ít nhất một chữ cái và một số
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
  static bool checkPasswordMatch(String password, String confirmPassword) {
  
    return password == confirmPassword;
  }
}
