// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionSummary _$SessionSummaryFromJson(Map<String, dynamic> json) =>
    SessionSummary(
      json['id'] as String,
      json['title'] as String,
      json['vin'] as String,
      DateTime.parse(json['updatedTime'] as String),
    );

Map<String, dynamic> _$SessionSummaryToJson(SessionSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'vin': instance.vin,
      'updatedTime': instance.updatedTime.toIso8601String(),
    };
