// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackendReq _$BackendReqFromJson(Map<String, dynamic> json) => BackendReq(
      username: json['username'] as String,
      commandObject: $enumDecode(_$CommandObjectEnumMap, json['commandObject']),
      commandIntent: $enumDecode(_$CommandIntentEnumMap, json['commandIntent']),
      actionType: json['actionType'],
      objectId: json['objectId'] as String?,
      value: json['value'],
    );

Map<String, dynamic> _$BackendReqToJson(BackendReq instance) =>
    <String, dynamic>{
      'username': instance.username,
      'commandObject': _$CommandObjectEnumMap[instance.commandObject],
      'commandIntent': _$CommandIntentEnumMap[instance.commandIntent],
      'objectId': instance.objectId,
      'actionType': instance.actionType,
      'value': instance.value,
    };

const _$CommandObjectEnumMap = {
  CommandObject.user: 'user',
  CommandObject.lead: 'lead',
  CommandObject.session: 'session',
};

const _$CommandIntentEnumMap = {
  CommandIntent.getById: 'getById',
  CommandIntent.getAll: 'getAll',
  CommandIntent.search: 'search',
  CommandIntent.action: 'action',
};
