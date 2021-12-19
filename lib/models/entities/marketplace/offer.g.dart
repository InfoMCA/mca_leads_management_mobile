// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      json['id'] as String,
      json['sellerId'] as String,
      json['buyerId'] as String,
      json['listingId'] as String,
      $enumDecode(_$OfferStateEnumMap, json['state']),
      json['initialOfferPrice'] as int,
      json['sellerOfferPrice'] as int,
      json['buyerOfferPrice'] as int,
      DateTime.parse(json['createdTime'] as String),
      DateTime.parse(json['lastModifiedTime'] as String),
      DateTime.parse(json['expirationTime'] as String),
      DateTime.parse(json['listingExpirationTime'] as String),
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'buyerId': instance.buyerId,
      'listingId': instance.listingId,
      'state': _$OfferStateEnumMap[instance.state],
      'initialOfferPrice': instance.initialOfferPrice,
      'sellerOfferPrice': instance.sellerOfferPrice,
      'buyerOfferPrice': instance.buyerOfferPrice,
      'createdTime': instance.createdTime.toIso8601String(),
      'lastModifiedTime': instance.lastModifiedTime.toIso8601String(),
      'expirationTime': instance.expirationTime.toIso8601String(),
      'listingExpirationTime': instance.listingExpirationTime.toIso8601String(),
    };

const _$OfferStateEnumMap = {
  OfferState.BUYER_OFFER: 'BUYER_OFFER',
  OfferState.SELLER_OFFER: 'SELLER_OFFER',
  OfferState.BUYER_ACCEPTED: 'BUYER_ACCEPTED',
  OfferState.SELLER_ACCEPTED: 'SELLER_ACCEPTED',
  OfferState.BUYER_REJECTED: 'BUYER_REJECTED',
  OfferState.SELLER_REJECTED: 'SELLER_REJECTED',
  OfferState.EXPIRED: 'EXPIRED',
};
