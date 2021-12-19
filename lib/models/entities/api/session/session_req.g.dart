// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionApproveRequest _$SessionApproveRequestFromJson(
        Map<String, dynamic> json) =>
    SessionApproveRequest(
      json['username'] as String,
      json['customerName'] as String,
      (json['purchasedPrice'] as num).toDouble(),
      (json['deductionsAmount'] as num).toDouble(),
      (json['lenderAmount'] as num).toDouble(),
      (json['customerAmount'] as num).toDouble(),
      (json['withholdingAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$SessionApproveRequestToJson(
        SessionApproveRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'customerName': instance.customerName,
      'purchasedPrice': instance.purchasedPrice,
      'deductionsAmount': instance.deductionsAmount,
      'lenderAmount': instance.lenderAmount,
      'customerAmount': instance.customerAmount,
      'withholdingAmount': instance.withholdingAmount,
    };

SessionRejectRequest _$SessionRejectRequestFromJson(
        Map<String, dynamic> json) =>
    SessionRejectRequest(
      json['username'] as String,
    );

Map<String, dynamic> _$SessionRejectRequestToJson(
        SessionRejectRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
    };
