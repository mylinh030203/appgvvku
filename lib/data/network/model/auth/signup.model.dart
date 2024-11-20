class SignupRequestModel {
  final String username;
  final String password;
  final String email;

  SignupRequestModel({
    required this.username,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }
}

class SignupResponseModel {
  final String message;
  SignupResponseModel({required this.message});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      message: json['message'] ?? '',
    );
  }
}
