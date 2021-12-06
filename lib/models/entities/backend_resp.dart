import 'lead.dart';
import 'lead_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backend_resp.g.dart';

@JsonSerializable()
class BackendResp {
  int? statusCode;
  String? message;
  String? status;
  List<LeadSummary>? leadSummaries;
  Lead? lead;
  List<String>? inspectors;
  String? region;

  BackendResp({this.message,
    this.status,
    this.statusCode,
    this.leadSummaries,
    this.lead,
    this.inspectors,
    this.region});

  factory BackendResp.fromJson(Map<String, dynamic> json) =>
      _$BackendRespFromJson(json);

  Map<String, dynamic> toJson() => _$BackendRespToJson(this);
}