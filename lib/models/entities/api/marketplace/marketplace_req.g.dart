// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterOfferRequest _$CounterOfferRequestFromJson(Map<String, dynamic> json) =>
    CounterOfferRequest(
      json['userId'] as String,
      json['listingId'] as String,
      json['offerId'] as String,
      json['offerPrice'] as int,
      DateTime.parse(json['offerExpirationTime'] as String),
    );

Map<String, dynamic> _$CounterOfferRequestToJson(
        CounterOfferRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'listingId': instance.listingId,
      'offerId': instance.offerId,
      'offerPrice': instance.offerPrice,
      'offerExpirationTime': instance.offerExpirationTime.toIso8601String(),
    };
