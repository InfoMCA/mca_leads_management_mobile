import 'lead_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backend_resp.g.dart';

@JsonSerializable()
class BackendResp {
  int? statusCode;
  String? message;
  String? status;
  List<LeadSummary>? leadSummaries;

  BackendResp({this.message,
    this.status,
    this.statusCode,
    this.leadSummaries});

  factory BackendResp.fromJson(Map<String, dynamic> json) =>
      _$BackendRespFromJson(json);

  Map<String, dynamic> toJson() => _$BackendRespToJson(this);
}