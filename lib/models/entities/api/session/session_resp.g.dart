// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSessionsResponse _$GetSessionsResponseFromJson(Map<String, dynamic> json) =>
    GetSessionsResponse(
      (json['sessions'] as List<dynamic>)
          .map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sessionSummaries'] as List<dynamic>)
          .map((e) => LeadSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSessionsResponseToJson(
        GetSessionsResponse instance) =>
    <String, dynamic>{
      'sessions': instance.sessions,
      'sessionSummaries': instance.sessionSummaries,
    };
