// ignore: file_names
import 'dart:io';

abstract class BaseApisService {
  Future<dynamic> getApiResponse(String url, String? token);

  Future<dynamic> postApiResponse(String url, dynamic data, String? token);

  Future<dynamic> putApiResponse(String url, dynamic data, String? token);

  Future<dynamic> fileApiResponse(String url, File data, String? token);
}
