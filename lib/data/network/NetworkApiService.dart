// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../AppException.dart';
import 'BaseApiService.dart';

class NetworkApiService extends BaseApisService {
  @override
  Future getApiResponse(String url, String? token) async {
    dynamic responseJson;
    try {
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final response = await get(Uri.parse(url), headers: headers).timeout(Duration(seconds: 5));
      // print("in network service ${returnResponse(response)}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      // print("ee $e");
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic data, String? token) async {
    dynamic responseJson;
    try {
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      Response response = await post(Uri.parse(url), body: jsonEncode(data), headers: headers).timeout(Duration(seconds: 10));

      // print("data ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw e;
    }

    return responseJson;
  }

  @override
  Future putApiResponse(String url, dynamic data, String? token) async {
    dynamic responseJson;
    try {
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      Response response = await put(Uri.parse(url), body: jsonEncode(data), headers: headers).timeout(Duration(seconds: 10));

      // print("data ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw e;
    }

    return responseJson;
  }

  @override
  Future fileApiResponse(String url, File data, String? token) async {
    dynamic responseJson;
    try {
      final headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      final request = await MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(await MultipartFile.fromPath('file', data.path));

      var streamedResponse = await request.send();
      var response = await Response.fromStream(streamedResponse);
      // print("data ${response}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw e;
    }
    return responseJson;
  }
}

dynamic returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      return responseJson;
    case 204:
      return true;
    case 400:
      throw BadRequestException(jsonDecode(response.body)['message'].toString());
    case 401:
      throw UnauthorisedException(jsonDecode(utf8.decode(response.bodyBytes))['message'].toString());
    case 500:
      throw BadRequestException(jsonDecode(response.body)['message'].toString());
    case 404:
      throw UnauthorisedException(jsonDecode(response.body)['message'].toString());
    case 406:
      throw NotAcceptableException(jsonDecode(utf8.decode(response.bodyBytes))['message'].toString());
    default:
      throw FetchDataException('Error accured while communicating with server' + 'with status code' + response.statusCode.toString());
  }
}
