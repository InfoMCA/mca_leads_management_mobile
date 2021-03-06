// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Listing _$ListingFromJson(Map<String, dynamic> json) => Listing(
      json['id'] as String,
      json['sellerId'] as String,
      json['vehicleId'] as String,
      json['inventoryItemId'] as String,
      $enumDecode(_$ListingStateEnumMap, json['state']),
      json['initialOfferPrice'] as int,
      json['offerCount'] as int,
      json['salePrice'] as int?,
      DateTime.parse(json['createdTime'] as String),
      DateTime.parse(json['lastModifiedTime'] as String),
      DateTime.parse(json['expirationTime'] as String),
    );

Map<String, dynamic> _$ListingToJson(Listing instance) => <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'vehicleId': instance.vehicleId,
      'inventoryItemId': instance.inventoryItemId,
      'state': _$ListingStateEnumMap[instance.state],
      'initialOfferPrice': instance.initialOfferPrice,
      'offerCount': instance.offerCount,
      'salePrice': instance.salePrice,
      'createdTime': instance.createdTime.toIso8601String(),
      'lastModifiedTime': instance.lastModifiedTime.toIso8601String(),
      'expirationTime': instance.expirationTime.toIso8601String(),
    };

const _$ListingStateEnumMap = {
  ListingState.ACTIVE: 'ACTIVE',
  ListingState.SOLD: 'SOLD',
  ListingState.REMOVED: 'REMOVED',
  ListingState.EXPIRED: 'EXPIRED',
};
