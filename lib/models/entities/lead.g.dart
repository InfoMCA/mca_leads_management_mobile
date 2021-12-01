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
    };
