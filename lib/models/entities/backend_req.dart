import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';

part 'backend_req.g.dart';

enum AppReqCmd {
  login,
  getLeads,
  getLead,
  leadAction
}

enum LeadAction {
  schedule,
  followUp,
  unanswered,
  lost
}

@JsonSerializable()
class BackendReq {
  final AppReqCmd cmd;
  String? username;
  String? password;
  LeadView? leadView;
  String? leadId;
  LeadAction? action;
  bool? sendSms;
  bool? leftMessage;
  DateTime? followUpDate;
  String? followUpComment;
  String? lostReason;

  BackendReq({required this.cmd,
    this.username,
    this.password,
    this.leadView,
    this.leadId});

  factory BackendReq.fromJson(Map<String, dynamic> json) =>
      _$BackendReqFromJson(json);

  Map<String, dynamic> toJson() => _$BackendReqToJson(this);

}
