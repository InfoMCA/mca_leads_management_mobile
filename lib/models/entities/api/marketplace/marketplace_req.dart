
import 'package:json_annotation/json_annotation.dart';

part 'marketplace_req.g.dart';

@JsonSerializable()
class CounterOfferRequest {
  String userId;
  String listingId;
  String offerId;
  int offerPrice;
  DateTime offerExpirationTime;

  CounterOfferRequest(this.userId, this.listingId, this.offerId,
      this.offerPrice, this.offerExpirationTime);

  factory CounterOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$CounterOfferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CounterOfferRequestToJson(this);

}