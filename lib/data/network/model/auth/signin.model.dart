
class LoginRequestModel {
  final String username;
  final String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class LoginResponseModel {
  final String token;
  //final String userName;
  LoginResponseModel({
    required this.token,
   // required this.userName
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '', 
      //userName: json['username'] ??'',
    );
  }
}