// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      json['id'] as String,
      json['vin'] as String,
      json['plate'] as String?,
      json['plateState'] as String?,
      json['ymmt'] as String,
      json['year'] as int?,
      json['make'] as String?,
      json['model'] as String?,
      json['trim'] as String?,
      json['mileage'] as int,
      json['color'] as String,
      json['engineType'] as String?,
      json['drivetrain'] as String?,
      json['transmission'] as String?,
      json['dealerId'] as String,
      $enumDecode(_$VehicleStateEnumMap, json['state']),
      DateTime.parse(json['createdTime'] as String),
      DateTime.parse(json['lastModifiedTime'] as String),
      json['dealerIdState'] as String,
      (json['estimatedCr'] as num).toDouble(),
      json['askingPrice'] as int,
      json['mmr'] as int,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'vin': instance.vin,
      'plate': instance.plate,
      'plateState': instance.plateState,
      'ymmt': instance.ymmt,
      'year': instance.year,
      'make': instance.make,
      'model': instance.model,
      'trim': instance.trim,
      'mileage': instance.mileage,
      'color': instance.color,
      'engineType': instance.engineType,
      'drivetrain': instance.drivetrain,
      'transmission': instance.transmission,
      'dealerId': instance.dealerId,
      'state': _$VehicleStateEnumMap[instance.state],
      'createdTime': instance.createdTime.toIso8601String(),
      'lastModifiedTime': instance.lastModifiedTime.toIso8601String(),
      'estimatedCr': instance.estimatedCr,
      'mmr': instance.mmr,
      'askingPrice': instance.askingPrice,
      'dealerIdState': instance.dealerIdState,
    };

const _$VehicleStateEnumMap = {
  VehicleState.LEAD_READY: 'LEAD_READY',
  VehicleState.LEAD_FOLLOWUP: 'LEAD_FOLLOWUP',
  VehicleState.LEAD_APPROVAL: 'LEAD_APPROVAL',
  VehicleState.LEAD_DENIED: 'LEAD_DENIED',
  VehicleState.LEAD_COMPLETE: 'LEAD_COMPLETE',
  VehicleState.LEAD_LOST: 'LEAD_LOST',
  VehicleState.INSPECTION_NEW: 'INSPECTION_NEW',
  VehicleState.INSPECTION_READY: 'INSPECTION_READY',
  VehicleState.INSPECTION_ACTIVE: 'INSPECTION_ACTIVE',
  VehicleState.INSPECTION_COMPLETE: 'INSPECTION_COMPLETE',
  VehicleState.INSPECTION_ARCHIVED: 'INSPECTION_ARCHIVED',
  VehicleState.INSPECTION_DELETED: 'INSPECTION_DELETED',
  VehicleState.INVENTORY: 'INVENTORY',
  VehicleState.MARKETPLACE_LISTED: 'MARKETPLACE_LISTED',
  VehicleState.SOLD: 'SOLD',
  VehicleState.TRANSPORTATION_SUBMITTED: 'TRANSPORTATION_SUBMITTED',
  VehicleState.TRANSPORTATION_DISPATCHED: 'TRANSPORTATION_DISPATCHED',
  VehicleState.TRANSPORTATION_ACTIVE: 'TRANSPORTATION_ACTIVE',
  VehicleState.TRANSPORTATION_COMPLETE: 'TRANSPORTATION_COMPLETE',
  VehicleState.TRANSPORTATION_CANCELLED: 'TRANSPORTATION_CANCELLED',
};
