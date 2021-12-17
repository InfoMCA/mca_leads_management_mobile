import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';

part 'lead_resp.g.dart';

@JsonSerializable()
class GetLeadsResponse {
  final List<Lead> leads;
  final List<LeadSummary> leadSummaries;

  GetLeadsResponse(this.leads, this.leadSummaries);
  factory GetLeadsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetLeadsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLeadsResponseToJson(this);
}
