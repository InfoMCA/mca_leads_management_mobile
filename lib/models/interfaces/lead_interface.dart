import 'dart:developer' as dev;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/lead/lead_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/lead/lead_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/rest_api_interface.dart';

class LeadInterface extends RestAPIInterface {
  LeadInterface() : super(CommandObject.lead);

  Future<List<LeadSummary>?> getLeads(LogicalView logicalView) async {
    try {
      Response response = await sendGetReq(
          "/leads?username=${currentUser!.username}"
          "&leadView=${logicalView.getRestParam()}"
          "&selectedDate=${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
      GetLeadsResponse getLeadsResponse =
          GetLeadsResponse.fromJson(response.data);
      return getLeadsResponse.leadSummaries;
    } catch (e) {
      return [];
    }
  }

  Future<Lead?> getLead(String leadId) async {
    Response response = await sendGetReq("/leads/$leadId");
    return Lead.fromJson(response.data);
  }

  Future<Response> setForFollowUp(
      String leadId, LeadFollowUpInfo followUpInfo) async {
    return sendPatchReqWithData(
        "/leads/$leadId/manager-followup", json.encode(followUpInfo));
  }

  Future<Response> setAsUnAnswered(
      String leadId, LeadUnAnsweredInfo unAnsweredInfo) async {
    return sendPatchReqWithData(
        "/leads/$leadId/manager-unanswered", json.encode(unAnsweredInfo));
  }

  Future<Response> dispatch(
      String leadId, LeadDispatchRequest leadDispatchRequest) async {
    return sendPatchReqWithData(
        "/leads/$leadId/dispatch", json.encode(leadDispatchRequest));
  }

  Future<Response> setAsLost(String leadId, String lostReason) async {
    return sendPatchReqWithData("/leads/$leadId/manager-lost",
        json.encode(LeadLostRequest(currentUser!.username, lostReason)));
  }

  Future<Response> update(String leadId, LeadUpdateRequest leadUpdateRequest) {
    return sendPatchReqWithData(
        "/leads/$leadId/update", json.encode(leadUpdateRequest));
  }

  Future<LeadSummary> search(String keyword) async {
    Response response = await sendPostReq(
        "/leads/search", json.encode(LeadSearchRequest(keyword)));
    return LeadSummary.fromJson(response.data);
  }
}
