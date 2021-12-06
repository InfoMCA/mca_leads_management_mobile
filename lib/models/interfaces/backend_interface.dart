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


class BackendInterface {
  final String endpoint = dotenv.env['API_ADMIN_APP_REQUEST'] ?? "";
  var dio = Dio();

  Future<String> checkLoginCredentials(String username, String password) async {
    try {
      BackendReq appReq = BackendReq(
          cmd: LeadMgmCmd.login,
          username: username,
          password: password);
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
          cmd: LeadMgmCmd.getLeads,
          username: currentUser!.username,
          leadView: leadView);
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
          cmd: LeadMgmCmd.getLead,
          username: currentUser!.username,
          leadId: leadId);
      Response response = await dio.post(endpoint, data: json.encode(appReq));
      BackendResp appResp = BackendResp.fromJson(response.data);
      dev.log(appResp.message.toString());

      if (appResp.statusCode == HttpStatus.ok) {
        return appResp.lead;
      } else {
        dev.log(appResp.statusCode.toString());
        return null;
      }
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString());
      dev.log(s.toString());
      throw ('Error getting sessions');
    }
  }

  Future<BackendResp> sendPostReq(BackendReq backendReq) async {
    try {
      Response response = await dio.post(
          endpoint, data: json.encode(backendReq));
      BackendResp appResp = BackendResp.fromJson(response.data);
      dev.log(appResp.message.toString());
      if (appResp.statusCode == HttpStatus.ok) {
        return appResp;
      }
      throw (appResp.message!);
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString());
      //dev.log(s.toString());
      throw (e.toString());
    }
  }

  Future<BackendResp> putLeadFollowUp(String leadId, DateTime followupDate,
      String comment) async {
    return sendPostReq(BackendReq(
        cmd: LeadMgmCmd.actionLead,
        leadAction: LeadAction.followUp,
        leadId: leadId,
        followUpDate: followupDate,
        followUpComment: comment));
  }

  Future<BackendResp> putLeadUnAnswered(String leadId, bool sendSms, bool leftMessage) async {
    return sendPostReq(BackendReq(
        cmd: LeadMgmCmd.actionLead,
        leadAction: LeadAction.unanswered,
        leadId: leadId,
        sendSms: sendSms,
        leftMessage: leftMessage));
  }

  Future<BackendResp> putLeadLost(String leadId, String lostReason) async {
    return sendPostReq(BackendReq(
        cmd: LeadMgmCmd.actionLead,
        leadAction: LeadAction.lost,
        leadId: leadId,
        lostReason: lostReason));
  }

  Future<BackendResp> searchLead(String keyword) async {
    return sendPostReq(BackendReq(
        cmd: LeadMgmCmd.searchLead,
        keyword: keyword)
    );
  }

  Future<BackendResp> getInspectors(String zipCode) async {
    return sendPostReq(BackendReq(
        cmd: LeadMgmCmd.getInspectors,
        username: currentUser!.username,
        zipcode: zipCode)
    );
  }

}
