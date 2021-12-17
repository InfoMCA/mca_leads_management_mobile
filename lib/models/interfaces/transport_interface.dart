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

class TransportInterface extends RestAPIInterface {
  TransportInterface() : super(CommandObject.transport);

  Future<Response> transfer(
      String id, PutNewOrderRequest putNewOrderRequest) async {
    return await sendPutReq(
        "/transport/new-order", json.encode(putNewOrderRequest));
  }
}
