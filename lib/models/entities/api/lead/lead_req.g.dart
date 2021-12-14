// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadFollowUpInfo _$LeadFollowUpInfoFromJson(Map<String, dynamic> json) =>
    LeadFollowUpInfo(
      json['username'] as String,
      json['followUpComment'] as String,
      DateTime.parse(json['followUpDate'] as String),
    );

Map<String, dynamic> _$LeadFollowUpInfoToJson(LeadFollowUpInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'followUpComment': instance.followUpComment,
      'followUpDate': instance.followUpDate.toIso8601String(),
    };

LeadUnAnsweredInfo _$LeadUnAnsweredInfoFromJson(Map<String, dynamic> json) =>
    LeadUnAnsweredInfo(
      json['username'] as String,
      json['sendSms'] as bool,
      json['leftMessage'] as bool,
    );

Map<String, dynamic> _$LeadUnAnsweredInfoToJson(LeadUnAnsweredInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'sendSms': instance.sendSms,
      'leftMessage': instance.leftMessage,
    };

LeadLostRequest _$LeadLostRequestFromJson(Map<String, dynamic> json) =>
    LeadLostRequest(
      json['username'] as String,
      json['lostReason'] as String,
    );

Map<String, dynamic> _$LeadLostRequestToJson(LeadLostRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'lostReason': instance.lostReason,
    };

GetInspectorsResp _$GetInspectorsRespFromJson(Map<String, dynamic> json) =>
    GetInspectorsResp(
      json['region'] as String,
      json['timeZone'] as String,
      json['userPhone'] as String,
      (json['inspectors'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GetInspectorsRespToJson(GetInspectorsResp instance) =>
    <String, dynamic>{
      'region': instance.region,
      'timeZone': instance.timeZone,
      'userPhone': instance.userPhone,
      'inspectors': instance.inspectors,
    };

LeadDispatchRequest _$LeadDispatchRequestFromJson(Map<String, dynamic> json) =>
    LeadDispatchRequest(
      json['username'] as String,
      json['userPhone'] as String,
      json['customerName'] as String,
      json['address1'] as String?,
      json['address2'] as String?,
      json['city'] as String?,
      json['state'] as String,
      json['zipCode'] as String,
      json['region'] as String,
      json['timeZone'] as String,
      json['inspector'] as String,
      json['inspectionTime'] as int,
      DateTime.parse(json['scheduleDate'] as String),
    );

Map<String, dynamic> _$LeadDispatchRequestToJson(
        LeadDispatchRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'userPhone': instance.userPhone,
      'customerName': instance.customerName,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'region': instance.region,
      'timeZone': instance.timeZone,
      'inspector': instance.inspector,
      'inspectionTime': instance.inspectionTime,
      'scheduleDate': instance.scheduleDate.toIso8601String(),
    };
