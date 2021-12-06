// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackendResp _$BackendRespFromJson(Map<String, dynamic> json) => BackendResp(
      message: json['message'] as String?,
      status: json['status'] as String?,
      leadSummaries: (json['leadSummaries'] as List<dynamic>?)
          ?.map((e) => LeadSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      lead: json['lead'] == null
          ? null
          : Lead.fromJson(json['lead'] as Map<String, dynamic>),
      session: json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>),
      inspectors: (json['inspectors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      region: json['region'] as String?,
    );

Map<String, dynamic> _$BackendRespToJson(BackendResp instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'leadSummaries': instance.leadSummaries,
      'lead': instance.lead,
      'session': instance.session,
      'inspectors': instance.inspectors,
      'region': instance.region,
    };
