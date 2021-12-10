import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/offer.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';

class BackendInterface {
  final String leadEndpoint = dotenv.env['API_LEAD_APP_REQUEST'] ?? "";
  final String sessionEndpoint = dotenv.env['API_SESSION_APP_REQUEST'] ?? "";
  final String regionEndpoint = dotenv.env['API_REGION_APP_REQUEST'] ?? "";
  final String userEndpoint = dotenv.env['API_USER_APP_REQUEST'] ?? "";
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

  Future<String> checkLoginCredentials(String username, String password) async {
    try {
      BackendReq appReq = BackendReq(
          username: username,
          object: CommandObject.user,
          intent: CommandIntent.action,
          action: CommandAction.userLogin,
          params: {"username": username, "password": password});
      Response response = await dio.post(getEndPoint(appReq), data: json.encode(appReq));
      if (response.statusCode != HttpStatus.ok) {
        return "Username or Password incorrect";
      }
      return "";
    } catch (e) {
      dev.log(e.toString());
      return e.toString();
    }
  }

  Future<List<LeadSummary>?> getLeads(LogicalView logicalView) async {
    try {
      BackendResp appResp = await sendPostReq(
          BackendReq(
              username: currentUser!.username,
              object: CommandObject.lead,
              intent: CommandIntent.getAll,
              params: {
                'viewType': logicalView.getString()
              }));
      return appResp.leadSummaries;
    } catch (e) {
      return [];
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

  Future<Lead?> getLead(String leadId) async {
    BackendResp appResp = await sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.lead,
            intent: CommandIntent.getById,
            objectId: leadId));
    return appResp.lead;
  }


  Future<BackendResp> putLeadAsFollowUp(String leadId,
      LeadFollowUpInfo followUpInfo) async {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.lead,
            intent: CommandIntent.action,
            action: CommandAction.leadFollowUp,
            params: {
              "followUpDate": followUpInfo.date.toUtc().toIso8601String(),
              "followUpComment": followUpInfo.comment
            },
            objectId: leadId
        ));
  }

  Future<BackendResp> putLeadAsUnAnswered(String leadId, LeadUnAnsweredInfo unAnsweredInfo) async {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.lead,
            intent: CommandIntent.action,
            action: CommandAction.leadUnanswered,
            params: {
              "sendSms": unAnsweredInfo.sendSms.toString(),
              "leftMessage": unAnsweredInfo.leftMessage.toString()
            }));
  }

  Future<BackendResp> putLeadAsLost(String leadId, String lostReason) async {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.lead,
            intent: CommandIntent.action,
            action: CommandAction.leadLost,
            params: {"lostReason": lostReason}));
  }

  Future<BackendResp> searchLead(String keyword) async {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.lead,
            intent: CommandIntent.search,
            params: {"keyword": keyword}));
  }



  Future<BackendResp> getRegion(String zipcode) async {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.region,
            intent: CommandIntent.action,
            action: CommandAction.regionGetByZipcode,
            params: {"zipcode": zipcode}
        ));
  }

  Future<BackendResp> getInspectors(String region) async {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.region,
            intent: CommandIntent.action,
            action: CommandAction.regionGetInspectors,
            params: {"region": region}
        ));
  }

  Future<BackendResp> dispatchLead(
      Lead lead,
      String inspector,
      int inspectionTime,
      DateTime scheduleDate) {
    return sendPostReq(
        BackendReq(
            username: currentUser!.username,
            object: CommandObject.lead,
            intent: CommandIntent.action,
            action: CommandAction.leadDispatch,
            lead: lead,
            objectId: lead.id,
            params: {
              "inspector": inspector,
              "inspectionTime": inspectionTime.toString(),
              "scheduleDate": scheduleDate.toString()
            }
        ));
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
