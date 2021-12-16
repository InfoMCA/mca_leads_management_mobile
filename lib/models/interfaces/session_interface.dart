import 'dart:developer' as dev;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/lead/lead_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/lead/lead_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/api/session/session_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/session/session_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/session/report.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/rest_api_interface.dart';

class SessionInterface extends RestAPIInterface {

  SessionInterface() : super(CommandObject.session);

  Future<List<LeadSummary>?> getSessions(LogicalView logicalView) async {
    Response response = await sendGetReq(
        "/sessions?username=${currentUser!.username}"
            "&leadView=${logicalView.getRestParam()}");
    GetSessionsResponse getLeadsResponse = GetSessionsResponse.fromJson(
        response.data);
    return getLeadsResponse.sessionSummaries;
  }

  Future<Session?> get(String sessionId) async {
    Response response = await sendGetReq("/sessions/$sessionId");
    return Session.fromJson(response.data);
  }

  Future<LeadSummary> search(String keyword) async {
    Response response = await sendPostReq("/sessions/search",
        json.encode(LeadSearchRequest(keyword)));
    return LeadSummary.fromJson(response.data);
  }

  Future<Response> dispatch(String sessionId,
      LeadDispatchRequest leadDispatchRequest) async {
    return sendPatchReqWithData("/sessions/$sessionId/update",
        json.encode(leadDispatchRequest));
  }

  Future<Response> delete(String sessionId) async {
    return sendPatchReq("/sessions/$sessionId/delete");
  }

  Future<Response> approve(String sessionId, SessionApproveRequest sessionApproveRequest) {
    return sendPatchReqWithData("/sessions/$sessionId/approve",
        json.encode(sessionApproveRequest));
  }

  Future<Response> reject(String sessionId) {
    return sendPatchReqWithData("/sessions/$sessionId/reject",
        json.encode(SessionRejectRequest(currentUser!.username)));
  }

  Future<GetReportResponse> getSessionObject(String sessionId) async {
    Response response = await sendGetReq("/sessions/$sessionId/report");
    return GetReportResponse.fromJson(response.data);
  }
}
