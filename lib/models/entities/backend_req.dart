import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';

part 'backend_req.g.dart';

enum LeadMgmCmd {
  login,
  getLeads,
  getLead,
  searchLead,
  actionLead,
  getInspectors
}

enum LeadAction {
  schedule,
  followUp,
  unanswered,
  lost
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
  LeadAction? leadAction;
  bool? sendSms;
  bool? leftMessage;
  DateTime? followUpDate;
  String? followUpComment;
  String? lostReason;

  BackendReq({required this.cmd,
    this.username,
    this.password,
    this.keyword,
    this.zipcode,
    this.leadView,
    this.leadId,
    this.leadAction,
    this.sendSms,
    this.leftMessage,
    this.followUpComment,
    this.followUpDate,
    this.lostReason});

  factory BackendReq.fromJson(Map<String, dynamic> json) =>
      _$BackendReqFromJson(json);

  Map<String, dynamic> toJson() => _$BackendReqToJson(this);

}
