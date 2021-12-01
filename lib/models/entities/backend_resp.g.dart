// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackendResp _$BackendRespFromJson(Map<String, dynamic> json) => BackendResp(
      message: json['message'] as String?,
      status: json['status'] as String?,
      statusCode: json['statusCode'] as int?,
      leadSummaries: (json['leadSummaries'] as List<dynamic>?)
          ?.map((e) => LeadSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      lead: json['lead'] == null
          ? null
          : Lead.fromJson(json['lead'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BackendRespToJson(BackendResp instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'status': instance.status,
      'leadSummaries': instance.leadSummaries,
      'lead': instance.lead,
    };
