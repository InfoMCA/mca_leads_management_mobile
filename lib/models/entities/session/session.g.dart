// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String,
      title: json['title'] as String,
      vin: json['vin'] as String,
      color: json['color'] as String?,
      mileage: json['mileage'] as int?,
      estimatedCr: (json['estimatedCr'] as num).toDouble(),
      askingPrice: json['askingPrice'] as int?,
      offeredPrice: json['offeredPrice'] as int?,
      requestedPrice: json['requestedPrice'] as int?,
      mmr: json['mmr'] as int?,
      phone: json['phone'] as String,
      customerName: json['customerName'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      region: json['region'] as String?,
      service: json['service'] as String,
      staff: json['staff'] as String,
    )
      ..purchasedPrice = (json['purchasedPrice'] as num?)?.toDouble()
      ..deductionsAmount = (json['deductionsAmount'] as num?)?.toDouble()
      ..lenderAmount = (json['lenderAmount'] as num?)?.toDouble()
      ..customerAmount = (json['customerAmount'] as num?)?.toDouble()
      ..withholdingAmount = (json['withholdingAmount'] as num?)?.toDouble()
      ..scheduledTime = json['scheduledTime'] == null
          ? null
          : DateTime.parse(json['scheduledTime'] as String)
      ..purchasedDate = json['purchasedDate'] == null
          ? null
          : DateTime.parse(json['purchasedDate'] as String);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'vin': instance.vin,
      'color': instance.color,
      'mileage': instance.mileage,
      'estimatedCr': instance.estimatedCr,
      'askingPrice': instance.askingPrice,
      'offeredPrice': instance.offeredPrice,
      'requestedPrice': instance.requestedPrice,
      'mmr': instance.mmr,
      'purchasedPrice': instance.purchasedPrice,
      'deductionsAmount': instance.deductionsAmount,
      'lenderAmount': instance.lenderAmount,
      'customerAmount': instance.customerAmount,
      'withholdingAmount': instance.withholdingAmount,
      'scheduledTime': instance.scheduledTime?.toIso8601String(),
      'purchasedDate': instance.purchasedDate?.toIso8601String(),
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'staff': instance.staff,
      'region': instance.region,
      'service': instance.service,
      'phone': instance.phone,
      'customerName': instance.customerName,
    };
