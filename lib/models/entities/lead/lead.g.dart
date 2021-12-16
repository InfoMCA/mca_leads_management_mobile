// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lead _$LeadFromJson(Map<String, dynamic> json) => Lead(
      id: json['id'] as String,
      name: json['name'] as String,
      vin: json['vin'] as String,
      color: json['color'] as String,
      mileage: json['mileage'] as int,
      estimatedCr: (json['estimatedCr'] as num).toDouble(),
      askingPrice: json['askingPrice'] as int,
      offeredPrice: json['offeredPrice'] as int?,
      requestedPrice: json['requestedPrice'] as int?,
      mmr: json['mmr'] as int,
      mobileNumber: json['mobileNumber'] as String,
      customerName: json['customerName'] as String?,
      comments: json['comments'] as String?,
      conditionQuestions: json['conditionQuestions'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      region: json['region'] as String?,
    )..payoffStatus = json['payoffStatus'] as String?;

Map<String, dynamic> _$LeadToJson(Lead instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'vin': instance.vin,
      'color': instance.color,
      'mileage': instance.mileage,
      'estimatedCr': instance.estimatedCr,
      'askingPrice': instance.askingPrice,
      'offeredPrice': instance.offeredPrice,
      'requestedPrice': instance.requestedPrice,
      'mmr': instance.mmr,
      'mobileNumber': instance.mobileNumber,
      'customerName': instance.customerName,
      'payoffStatus': instance.payoffStatus,
      'comments': instance.comments,
      'conditionQuestions': instance.conditionQuestions,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'region': instance.region,
    };
