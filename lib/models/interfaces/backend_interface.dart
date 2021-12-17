import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';

class BackendInterface {
  final String leadEndpoint = dotenv.env['LEAD_SERVER'] ?? "";
  final String sessionEndpoint = dotenv.env['SESSION_SERVER'] ?? "";
  final String transportEndpoint = dotenv.env['TRANSPORT_SERVER'] ?? "";
  final String regionEndpoint = dotenv.env['USER_REGION_SERVER'] ?? "";
  final String userEndpoint = dotenv.env['USER_REGION_SERVER'] ?? "";
  final String marketplaceEndpoint = dotenv.env['MARKETPLACE_SERVER'] ?? "";


  String getEndPoint(BackendReq backendReq) {
    switch (backendReq.object) {

      case CommandObject.user:
        return userEndpoint;
      case CommandObject.region:
        return regionEndpoint;
      case CommandObject.lead:
        return leadEndpoint;
      case CommandObject.session:
        return sessionEndpoint;
      case CommandObject.inventory:
      case CommandObject.listing:
      case CommandObject.offer:
        return marketplaceEndpoint;
      case CommandObject.transport:
        return transportEndpoint;
    }
  }
  Dio dio = Dio();

  Future<BackendResp> sendPostReq(BackendReq backendReq) async {
    try {
      Response response =
      await dio.post(getEndPoint(backendReq), data: json.encode(backendReq));
      BackendResp appResp = BackendResp.fromJson(response.data);
      dev.log(appResp.message.toString());
      if (response.statusCode == HttpStatus.ok) {
        return appResp;
      }
      throw (appResp.message!);
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }


  Future<AuthUserModel> checkLoginCredentials(String username, String password) async {
    try {
      Response response = await dio.get(userEndpoint
          + "/users?userName=$username&password=$password&role=manager");
      if (response.statusCode != HttpStatus.ok) {
        throw ("Incorrect username or password!");
      }
      dev.log(response.data.toString());
      return AuthUserModel.fromJson(response.data);
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }
}
