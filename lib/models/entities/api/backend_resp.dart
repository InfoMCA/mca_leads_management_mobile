import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';

import 'package:json_annotation/json_annotation.dart';

part 'backend_resp.g.dart';

@JsonSerializable()
class BackendResp {
  String? message;
  String? status;
  List<LeadSummary>? leadSummaries;
  Lead? lead;
  Session? session;
  List<String>? inspectors;
  String? region;
  List<String>? reportItemLinks;
  dynamic indexContents;

  BackendResp(
      {this.message,
      this.status,
      this.leadSummaries,
      this.lead,
      this.session,
      this.inspectors,
      this.region,
      this.reportItemLinks,
      this.indexContents});

  factory BackendResp.fromJson(Map<String, dynamic> json) =>
      _$BackendRespFromJson(json);

  Map<String, dynamic> toJson() => _$BackendRespToJson(this);
}
