import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';

part 'backend_req.g.dart';

enum LeadMgmCmd {
  login,
  getLeads,
  getLead,
  searchLead,
  actionLead,
  getSession,
  getInspectors
}

enum LeadAction {
  schedule,
  followUp,
  unanswered,
  lost,
  dispatch
}

@JsonSerializable()
class BackendReq {
  final LeadMgmCmd cmd;
  String? username;
  String? password;
  String? keyword;
  String? zipcode;
  LeadView? leadView;
  String? leadId;
  String? sessionId;
  LeadAction? leadAction;
  bool? sendSms;
  bool? leftMessage;
  DateTime? followUpDate;
  String? followUpComment;
  String? lostReason;
  Lead? lead;
  String? inspector;
  int? inspectionTime;
  DateTime? scheduleDate;

  BackendReq({required this.cmd,
    this.username,
    this.password,
    this.keyword,
    this.zipcode,
    this.leadView,
    this.leadId,
    this.sessionId,
    this.leadAction,
    this.sendSms,
    this.leftMessage,
    this.followUpComment,
    this.followUpDate,
    this.lostReason,
    this.lead,
    this.inspector,
    this.inspectionTime,
    this.scheduleDate});

  factory BackendReq.fromJson(Map<String, dynamic> json) =>
      _$BackendReqFromJson(json);

  Map<String, dynamic> toJson() => _$BackendReqToJson(this);

}
