// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Marketplace _$MarketplaceFromJson(Map<String, dynamic> json) => Marketplace(
      json['id'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$MarketplaceToJson(Marketplace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

MarketplaceSale _$MarketplaceSaleFromJson(Map<String, dynamic> json) =>
    MarketplaceSale(
      json['id'] as String,
      json['createdTime'] as int,
      json['offerId'] as String,
      json['listingId'] as String,
      json['vehicleId'] as String,
      json['sellerId'] as String,
      json['buyerId'] as String,
      json['price'] as int,
    );

Map<String, dynamic> _$MarketplaceSaleToJson(MarketplaceSale instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdTime': instance.createdTime,
      'offerId': instance.offerId,
      'listingId': instance.listingId,
      'vehicleId': instance.vehicleId,
      'sellerId': instance.sellerId,
      'buyerId': instance.buyerId,
      'price': instance.price,
    };
