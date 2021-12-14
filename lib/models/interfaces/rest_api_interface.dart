import 'dart:developer' as dev;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';

class RestAPIInterface {
  final String leadEndpoint = dotenv.env['LEAD_SERVER'] ?? "";
  final String sessionEndpoint = dotenv.env['API_SESSION_APP_REQUEST'] ?? "";
  final String regionEndpoint = dotenv.env['API_REGION_APP_REQUEST'] ?? "";
  final String userEndpoint = dotenv.env['USER_SERVER'] ?? "";
  final String marketplaceEndpoint = dotenv
      .env['API_MARKETPLACE_APP_REQUEST'] ?? "";
  late String endpoint;
  Dio dio = Dio();

  String getEndPoint(CommandObject commandObject) {
    switch (commandObject) {
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
    }
  }

  RestAPIInterface(CommandObject commandObject) {
    endpoint = getEndPoint(commandObject);
  }

  Future<Response> sendGetReq(String path) async {
    try {
      dev.log("Get Req: $path");
      Response response = await dio.get(endpoint + path);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw ("Error code: ${response.statusCode}");
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }

  Future<Response> sendPatchReq(String path) async {
    try {
      dev.log("Patch Req: $path");
      Response response = await dio.patch(endpoint + path);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw ("Error code: ${response.statusCode}");
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }

  Future<Response> sendPatchReqWithData(String path, String data) async {
    try {
      dev.log("Patch Req: $path");
      dev.log("Patch Req: $data");
      Response response = await dio.patch(endpoint + path, data:data);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw ("Error code: ${response.statusCode}");
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }

  Future<Response> sendPostReq(String path, String data) async {
    try {
      dev.log("Post Req: $path");
      dev.log("Post Req: $data");
      Response response = await dio.post(endpoint + path, data: data);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw ("Error code: ${response.statusCode}");
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }
}