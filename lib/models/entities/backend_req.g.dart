// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackendReq _$BackendReqFromJson(Map<String, dynamic> json) => BackendReq(
      cmd: $enumDecode(_$AppReqCmdEnumMap, json['cmd']),
      username: json['username'] as String?,
      password: json['password'] as String?,
      leadView: $enumDecodeNullable(_$LeadViewEnumMap, json['leadView']),
      leadId: json['leadId'] as String?,
    );

Map<String, dynamic> _$BackendReqToJson(BackendReq instance) =>
    <String, dynamic>{
      'cmd': _$AppReqCmdEnumMap[instance.cmd],
      'username': instance.username,
      'password': instance.password,
      'leadView': _$LeadViewEnumMap[instance.leadView],
      'leadId': instance.leadId,
    };

const _$AppReqCmdEnumMap = {
  AppReqCmd.login: 'Login',
  AppReqCmd.getLeads: 'GetLeads',
  AppReqCmd.getLead: 'GetLead',
};

const _$LeadViewEnumMap = {
  LeadView.approval: 'APPROVAL',
  LeadView.followUp: 'FOLLOW_UP_MANAGER',
  LeadView.appraisal: 'APPRAISAL',
  LeadView.dispatched: 'DISPATCHED',
  LeadView.active: 'ACTIVE',
  LeadView.completed: 'COMPLETED'
};
