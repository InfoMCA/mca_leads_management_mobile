import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';

part 'session_resp.g.dart';

@JsonSerializable()
class GetSessionsResponse {
  final List<Session> sessions;
  final List<LeadSummary> sessionSummaries;

  GetSessionsResponse(this.sessions, this.sessionSummaries);
  factory GetSessionsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSessionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetSessionsResponseToJson(this);
}
