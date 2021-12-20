// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportItemV1 _$ReportItemV1FromJson(Map<String, dynamic> json) => ReportItemV1(
      json['name'] as String,
      json['value'] as String?,
      json['comments'] as String?,
      json['format'] as String,
      json['type'] as String,
      json['category'] as String,
    );

Map<String, dynamic> _$ReportItemV1ToJson(ReportItemV1 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'comments': instance.comments,
      'format': instance.format,
      'type': instance.type,
      'category': instance.category,
    };

ReportV1 _$ReportV1FromJson(Map<String, dynamic> json) => ReportV1(
      (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
      (json['reportItems'] as List<dynamic>)
          .map((e) => ReportItemV1.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportV1ToJson(ReportV1 instance) => <String, dynamic>{
      'categories': instance.categories,
      'reportItems': instance.reportItems,
    };

GetReportResponse _$GetReportResponseFromJson(Map<String, dynamic> json) =>
    GetReportResponse(
      json['indexContents'] as String,
      ReportV1.fromJson(json['report'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetReportResponseToJson(GetReportResponse instance) =>
    <String, dynamic>{
      'indexContents': instance.indexContents,
      'report': instance.report,
    };
