import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';

class BackendInterface {
  final String leadEndpoint = dotenv.env['LEAD_SERVER'] ?? "";
  final String sessionEndpoint = dotenv.env['API_SESSION_APP_REQUEST'] ?? "";
  final String regionEndpoint = dotenv.env['API_REGION_APP_REQUEST'] ?? "";
  final String userEndpoint = dotenv.env['USER_SERVER'] ?? "";
  final String marketplaceEndpoint = dotenv
      .env['API_MARKETPLACE_APP_REQUEST'] ?? "";


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
          + "user?userName=$username&password=$password&role=manager");
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

  Future<List<LeadSummary>?> getSessions(LogicalView logicalView) async {
    try {
      BackendResp appResp = await sendPostReq(
          BackendReq(
              username: currentUser!.username,
              object: CommandObject.session,
              intent: CommandIntent.getAll,
              params: {
                'viewType': logicalView.getString()
              }));
      return appResp.leadSummaries;
    } catch (e) {
      return [];
    }
  }


  Future<BackendResp> searchLead(String keyword) async {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.lead,
            intent: CommandIntent.search,
            params: {"keyword": keyword}));
  }


  Future<Session?> getSession(String sessionId) async {
    BackendResp backendResp = await sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.session,
            intent: CommandIntent.getById,
            objectId: sessionId));
    return backendResp.session;
  }

  Future<BackendResp> getSessionObject(String sessionId, List<String> reportItems) async {
    BackendReq backendReq = BackendReq(
        username: currentUser!.username,
        object: CommandObject.session,
        intent: CommandIntent.action,
        action: CommandAction.sessionReport,
        objectId: sessionId,
        params: {
          "reportItems": reportItems.join(","),
          "viewType": "active"
        });
    BackendResp resp = await sendPostReq(backendReq);
    return resp;
  }
}
