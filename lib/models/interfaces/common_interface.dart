import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/lead/lead_req.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/interfaces/rest_api_interface.dart';

class CommonInterface extends RestAPIInterface {

  CommonInterface() : super(CommandObject.user);

  Future<GetInspectorsResp> getInspectors(String zipCode) async {
    Response response = await sendGetReq(
        "/regions/inspectors?zipCode=$zipCode"
        "&userName=${currentUser!.username}");
    GetInspectorsResp getLeadsResponse = GetInspectorsResp.fromJson(
        response.data);
    dev.log(getLeadsResponse.toJson().toString());
    return getLeadsResponse;
  }
}
