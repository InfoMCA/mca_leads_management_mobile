// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    InventoryItem(
      json['id'] as String,
      json['vehicleId'] as String,
      json['dealerId'] as String,
      (json['purchasedPrice'] as num).toDouble(),
      (json['deductionsAmount'] as num).toDouble(),
      (json['lenderAmount'] as num).toDouble(),
      (json['customerAmount'] as num).toDouble(),
      (json['withholdingAmount'] as num).toDouble(),
      $enumDecode(_$InventoryItemStateEnumMap, json['state']),
      DateTime.parse(json['createdTime'] as String),
      DateTime.parse(json['lastModifiedTime'] as String),
      DateTime.parse(json['transferTime'] as String),
      json['sellerId'] as String?,
      json['tradedPrice'] as int?,
    );

Map<String, dynamic> _$InventoryItemToJson(InventoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleId': instance.vehicleId,
      'dealerId': instance.dealerId,
      'purchasedPrice': instance.purchasedPrice,
      'deductionsAmount': instance.deductionsAmount,
      'lenderAmount': instance.lenderAmount,
      'customerAmount': instance.customerAmount,
      'withholdingAmount': instance.withholdingAmount,
      'state': _$InventoryItemStateEnumMap[instance.state],
      'createdTime': instance.createdTime.toIso8601String(),
      'lastModifiedTime': instance.lastModifiedTime.toIso8601String(),
      'transferTime': instance.transferTime.toIso8601String(),
      'sellerId': instance.sellerId,
      'tradedPrice': instance.tradedPrice,
    };

const _$InventoryItemStateEnumMap = {
  InventoryItemState.ACTIVE: 'ACTIVE',
  InventoryItemState.TRANSFERRED_IN: 'TRANSFERRED_IN',
  InventoryItemState.TRANSFERRED_OUT: 'TRANSFERRED_OUT',
  InventoryItemState.REMOVED: 'REMOVED',
  InventoryItemState.SOLD: 'SOLD',
};

InventoryVehicle _$InventoryVehicleFromJson(Map<String, dynamic> json) =>
    InventoryVehicle(
      InventoryItem.fromJson(json['inventoryItem'] as Map<String, dynamic>),
      Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InventoryVehicleToJson(InventoryVehicle instance) =>
    <String, dynamic>{
      'inventoryItem': instance.inventoryItem,
      'vehicle': instance.vehicle,
    };
