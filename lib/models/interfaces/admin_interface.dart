import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


enum AppReqCmd {
  login
}

class AppReq {
  final AppReqCmd cmd;
  String? username;
  String? password;

  AppReq(
      {required this.cmd,
      this.username,
      this.password});

  Map<String, dynamic> toJson() {
    return {
      'cmd': EnumToString.convertToString(cmd),
      'username': username,
      'password': password,
    };
  }
}

class AppResp {
  int? statusCode;
  String? message;
  String? status;


  AppResp(
      {this.message,
      this.status,
      this.statusCode});

  factory AppResp.fromJson(Map<String, dynamic> parsedJson) {
    return AppResp(
        message: parsedJson['message'],
        status: parsedJson['status'],
        statusCode: parsedJson['statusCode']);
  }
}

class AdminInterface {
  final String endpoint = dotenv.env['API_ADMIN_APP_REQUEST'] ?? "";
  var dio = Dio();

  Future<AppResp> checkLoginCredentials(
      String username, String password) async {
    try {
      AppReq appReq = AppReq(
          cmd: AppReqCmd.login,
          username: username,
          password: password);
      Response response = await dio.post(endpoint, data: json.encode(appReq));
      AppResp authResponse = AppResp.fromJson(response.data);
      authResponse.statusCode = response.statusCode;
      return authResponse;
    } catch (e) {
      AppResp authResponse = AppResp();
      authResponse.statusCode = HttpStatus.clientClosedRequest;
      return authResponse;
    }
  }
}
