// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackendReq _$BackendReqFromJson(Map<String, dynamic> json) => BackendReq(
      cmd: $enumDecode(_$LeadMgmCmdEnumMap, json['cmd']),
      username: json['username'] as String?,
      password: json['password'] as String?,
      keyword: json['keyword'] as String?,
      zipcode: json['zipcode'] as String?,
      leadView: $enumDecodeNullable(_$LeadViewEnumMap, json['leadView']),
      leadId: json['leadId'] as String?,
      sessionId: json['sessionId'] as String?,
      leadAction: $enumDecodeNullable(_$LeadActionEnumMap, json['leadAction']),
      sendSms: json['sendSms'] as bool?,
      leftMessage: json['leftMessage'] as bool?,
      followUpComment: json['followUpComment'] as String?,
      followUpDate: json['followUpDate'] == null
          ? null
          : DateTime.parse(json['followUpDate'] as String),
      lostReason: json['lostReason'] as String?,
      lead: json['lead'] == null
          ? null
          : Lead.fromJson(json['lead'] as Map<String, dynamic>),
      inspector: json['inspector'] as String?,
      inspectionTime: json['inspectionTime'] as int?,
      scheduleDate: json['scheduleDate'] == null
          ? null
          : DateTime.parse(json['scheduleDate'] as String),
    );

Map<String, dynamic> _$BackendReqToJson(BackendReq instance) =>
    <String, dynamic>{
      'cmd': _$LeadMgmCmdEnumMap[instance.cmd],
      'username': instance.username,
      'password': instance.password,
      'keyword': instance.keyword,
      'zipcode': instance.zipcode,
      'leadView': _$LeadViewEnumMap[instance.leadView],
      'leadId': instance.leadId,
      'sessionId': instance.sessionId,
      'leadAction': _$LeadActionEnumMap[instance.leadAction],
      'sendSms': instance.sendSms,
      'leftMessage': instance.leftMessage,
      'followUpDate': instance.followUpDate?.toIso8601String(),
      'followUpComment': instance.followUpComment,
      'lostReason': instance.lostReason,
      'lead': instance.lead,
      'inspector': instance.inspector,
      'inspectionTime': instance.inspectionTime,
      'scheduleDate': instance.scheduleDate?.toIso8601String(),
    };

const _$LeadMgmCmdEnumMap = {
  LeadMgmCmd.login: 'login',
  LeadMgmCmd.getLeads: 'getLeads',
  LeadMgmCmd.getLead: 'getLead',
  LeadMgmCmd.searchLead: 'searchLead',
  LeadMgmCmd.actionLead: 'actionLead',
  LeadMgmCmd.getSession: 'getSession',
  LeadMgmCmd.getInspectors: 'getInspectors',
};

const _$LeadViewEnumMap = {
  LeadView.approval: 'approval',
  LeadView.followUpManager: 'followUpManager',
  LeadView.appraisal: 'appraisal',
  LeadView.dispatched: 'dispatched',
  LeadView.active: 'active',
  LeadView.completed: 'completed',
};

const _$LeadActionEnumMap = {
  LeadAction.schedule: 'schedule',
  LeadAction.followUp: 'followUp',
  LeadAction.unanswered: 'unanswered',
  LeadAction.lost: 'lost',
  LeadAction.dispatch: 'dispatch',
};
