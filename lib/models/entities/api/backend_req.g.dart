// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackendReq _$BackendReqFromJson(Map<String, dynamic> json) => BackendReq(
      username: json['username'] as String,
      object: $enumDecode(_$CommandObjectEnumMap, json['object']),
      intent: $enumDecode(_$CommandIntentEnumMap, json['intent']),
      action: $enumDecodeNullable(_$CommandActionEnumMap, json['action']),
      objectId: json['objectId'] as String?,
      lead: json['lead'] == null
          ? null
          : Lead.fromJson(json['lead'] as Map<String, dynamic>),
      session: json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>),
      params: json['params'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BackendReqToJson(BackendReq instance) =>
    <String, dynamic>{
      'username': instance.username,
      'object': _$CommandObjectEnumMap[instance.object],
      'intent': _$CommandIntentEnumMap[instance.intent],
      'action': _$CommandActionEnumMap[instance.action],
      'objectId': instance.objectId,
      'lead': instance.lead,
      'session': instance.session,
      'params': instance.params,
    };

const _$CommandObjectEnumMap = {
  CommandObject.user: 'user',
  CommandObject.region: 'region',
  CommandObject.lead: 'lead',
  CommandObject.session: 'session',
  CommandObject.inventory: 'inventory',
  CommandObject.listing: 'listing',
};

const _$CommandIntentEnumMap = {
  CommandIntent.create: 'create',
  CommandIntent.getById: 'getById',
  CommandIntent.getAll: 'getAll',
  CommandIntent.search: 'search',
  CommandIntent.save: 'save',
  CommandIntent.action: 'action',
};

const _$CommandActionEnumMap = {
  CommandAction.leadDispatch: 'leadDispatch',
  CommandAction.leadFollowUp: 'leadFollowUp',
  CommandAction.leadUnanswered: 'leadUnanswered',
  CommandAction.leadApprovedOffer: 'leadApprovedOffer',
  CommandAction.leadApprovedDeal: 'leadApprovedDeal',
  CommandAction.leadLost: 'leadLost',
  CommandAction.sessionSchedule: 'sessionSchedule',
  CommandAction.sessionLost: 'sessionLost',
  CommandAction.sessionReport: 'sessionReport',
  CommandAction.userLogin: 'userLogin',
  CommandAction.regionGetByZipcode: 'regionGetByZipcode',
  CommandAction.regionGetInspectors: 'regionGetInspectors',
};
