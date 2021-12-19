import 'dart:developer' as dev;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/transport/transport_req.dart';
import 'package:mca_leads_management_mobile/models/interfaces/rest_api_interface.dart';

class TransportInterface extends RestAPIInterface {
  TransportInterface() : super(CommandObject.transport);

  Future<Response> transfer(PutNewOrderRequest putNewOrderRequest) async {
    return await sendPutReq(
        "/transport/new-order", json.encode(putNewOrderRequest));
  }
}
