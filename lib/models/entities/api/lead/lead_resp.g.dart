// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLeadsResponse _$GetLeadsResponseFromJson(Map<String, dynamic> json) =>
    GetLeadsResponse(
      (json['leads'] as List<dynamic>)
          .map((e) => Lead.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['leadSummaries'] as List<dynamic>)
          .map((e) => LeadSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetLeadsResponseToJson(GetLeadsResponse instance) =>
    <String, dynamic>{
      'leads': instance.leads,
      'leadSummaries': instance.leadSummaries,
    };
