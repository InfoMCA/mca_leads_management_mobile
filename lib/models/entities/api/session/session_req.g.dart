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

TransportInfo _$TransportInfoFromJson(Map<String, dynamic> json) =>
    TransportInfo(
      json['firstName'] as String,
      json['lastName'] as String,
      json['address1'] as String,
      json['address2'] as String,
      json['city'] as String,
      json['state'] as String,
      json['zipCode'] as String,
      json['phone'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$TransportInfoToJson(TransportInfo instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'phone': instance.phone,
      'email': instance.email,
    };

PutNewOrderRequest _$PutNewOrderRequestFromJson(Map<String, dynamic> json) =>
    PutNewOrderRequest(
      json['customer'] as String,
      json['broker'] as String,
      json['vin'] as String,
      json['title'] as String,
      json['notes'] as String,
      TransportInfo.fromJson(json['source'] as Map<String, dynamic>),
      TransportInfo.fromJson(json['destination'] as Map<String, dynamic>),
      DateTime.parse(json['scheduledDate'] as String),
    );

Map<String, dynamic> _$PutNewOrderRequestToJson(PutNewOrderRequest instance) =>
    <String, dynamic>{
      'customer': instance.customer,
      'broker': instance.broker,
      'vin': instance.vin,
      'title': instance.title,
      'notes': instance.notes,
      'source': instance.source,
      'destination': instance.destination,
      'scheduledDate': instance.scheduledDate.toIso8601String(),
    };
