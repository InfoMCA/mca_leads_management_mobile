// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferRequest _$OfferRequestFromJson(Map<String, dynamic> json) => OfferRequest(
      json['userId'] as String,
      json['listingId'] as String,
      json['offerId'] as String,
      json['offerPrice'] as int,
      DateTime.parse(json['expirationTime'] as String),
      DateTime.parse(json['offerExpirationTime'] as String),
    );

Map<String, dynamic> _$OfferRequestToJson(OfferRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'listingId': instance.listingId,
      'offerId': instance.offerId,
      'offerPrice': instance.offerPrice,
      'expirationTime': instance.expirationTime.toIso8601String(),
      'offerExpirationTime': instance.offerExpirationTime.toIso8601String(),
    };
