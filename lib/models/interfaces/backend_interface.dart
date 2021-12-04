import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mca_leads_management_mobile/models/entities/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/session.dart';

class BackendInterface {
  final String endpoint = dotenv.env['API_ADMIN_APP_REQUEST'] ?? "";
  Dio dio = Dio();

  Future<String> checkLoginCredentials(String username, String password) async {
    try {
      BackendReq appReq = BackendReq(
          username: username,
          commandObject: CommandObject.user,
          commandIntent: CommandIntent.action,
          actionType: UserAction.login,
          value: {"username": username, "password": password});
      Response response = await dio.post(endpoint, data: json.encode(appReq));
      BackendResp authResponse = BackendResp.fromJson(response.data);
      authResponse.statusCode = response.statusCode;
      if (authResponse.statusCode != HttpStatus.ok) {
        return "Username or Password incorrect";
      }
      return "";
    } catch (e) {
      dev.log(e.toString());
      return e.toString();
    }
  }

  Future<List<LeadSummary>?> getLeads(LeadView leadView) async {
    try {
      BackendReq appReq = BackendReq(
          username: currentUser!.username,
          commandObject: CommandObject.lead,
          commandIntent: CommandIntent.getAll,
          value: leadView);
      Response response = await dio.post(endpoint, data: json.encode(appReq));
      BackendResp appResp = BackendResp.fromJson(response.data);
      dev.log(appResp.message.toString());

      if (appResp.statusCode == HttpStatus.ok) {
        return appResp.leadSummaries;
      } else {
        dev.log(appResp.statusCode.toString());
        return [];
      }
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString());
      dev.log(s.toString());
      throw ('Error getting sessions');
    }
  }

  Future<Lead?> getLead(String leadId) async {
    try {
      BackendReq appReq = BackendReq(
          username: currentUser!.username,
          commandObject: CommandObject.lead,
          commandIntent: CommandIntent.getById,
          objectId: leadId);
      Response response = await dio.post(endpoint, data: json.encode(appReq));
      BackendResp appResp = BackendResp.fromJson(response.data);
      dev.log(appResp.message.toString());

      if (appResp.statusCode == HttpStatus.ok) {
        return appResp.lead;
      }
      dev.log(appResp.statusCode.toString());
      throw ('Internal error');
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString());
      dev.log(s.toString());
      throw ('Error getting sessions');
    }
  }

  Future<BackendResp> sendPostReq(BackendReq backendReq) async {
    try {
      Response response =
          await dio.post(endpoint, data: json.encode(backendReq));
      BackendResp appResp = BackendResp.fromJson(response.data);
      dev.log(appResp.message.toString());
      if (appResp.statusCode == HttpStatus.ok) {
        return appResp;
      }
      throw (appResp.message!);
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }

  Future<BackendResp> putLeadAsFollowUp(
      String leadId, DateTime followupDate, String comment) async {
    return sendPostReq(BackendReq(
      username: currentUser!.username,
      commandObject: CommandObject.lead,
        commandIntent: CommandIntent.action,
        actionType: LeadAction.followUp,
        value: {
          "followUpDate": followupDate,
          "followUpComment": comment
        },
      objectId: leadId
        ));
  }

  Future<BackendResp> putLeadAsUnAnswered(
      String leadId, bool sendSms, bool leftMessage) async {
    return sendPostReq(BackendReq(
        username: currentUser!.username,
        commandObject: CommandObject.lead,
        commandIntent: CommandIntent.action,
        actionType: LeadAction.unanswered,
        value: {
          "sendSms": sendSms,
          "leftMessage": leftMessage
        }));
  }

  Future<BackendResp> putLeadAsLost(String leadId, String lostReason) async {
    return sendPostReq(BackendReq(
        username: currentUser!.username,
        commandObject: CommandObject.lead,
        commandIntent: CommandIntent.action,
        actionType: LeadAction.lost,
        value: {
          "lostReason": lostReason
        }));
  }

  Future<BackendResp> searchLead(String keyword) async {
    return sendPostReq(
        BackendReq(
          username: currentUser!.username,
        commandObject: CommandObject.lead,
        commandIntent: CommandIntent.search,
        value: keyword));
  }

  Future<BackendResp> getInspectors(String zipCode) async {
    return sendPostReq(BackendReq(
      username: currentUser!.username,
        commandObject: CommandObject.lead,
        commandIntent: CommandIntent.action,
        actionType: SessionAction.getInspectors,
        value: {
          "zipCode": zipCode
        }
        ));
  }

  Future<BackendResp> dispatchLead(
      Lead lead, String inspector, int inspectionTime, DateTime scheduleDate) {
    return sendPostReq(BackendReq(
        username: currentUser!.username,
commandObject: CommandObject.lead,
        commandIntent: CommandIntent.action,
        actionType: SessionAction.dispatch,
        objectId: lead.id,
        value: {
          "lead": lead, ///TODO: Do we need the entire lead object?
          "leadId": lead.id,
          "inspector": inspector,
          "inspectionTime": inspectionTime,
          "scheduleDate": scheduleDate
        }
    ));
  }

  Future<Session?> getSession(String sessionId) async {
    try {
      BackendResp backendResp = await sendPostReq(
          BackendReq(
              username: currentUser!.username,
              commandObject: CommandObject.session,
              commandIntent: CommandIntent.getById,
              objectId: sessionId));
      return backendResp.session;
    } catch (e) {
      return null;
    }
  }
}
