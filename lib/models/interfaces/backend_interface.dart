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


class AdminInterface {
  final String endpoint = dotenv.env['API_ADMIN_APP_REQUEST'] ?? "";
  var dio = Dio();

  Future<String> checkLoginCredentials(
      String username, String password) async {
    try {
      BackendReq appReq = BackendReq(
          cmd: AppReqCmd.login,
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
          cmd: AppReqCmd.getLeads, username: currentUser!.username, leadView: leadView);
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

}
