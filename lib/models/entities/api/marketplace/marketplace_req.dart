import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';

part 'marketplace_req.g.dart';

@JsonSerializable()
class OfferRequest {
  String userId;
  String listingId;
  String offerId;
  int offerPrice;
  DateTime expirationTime;
  DateTime offerExpirationTime;

  OfferRequest(this.userId, this.listingId, this.offerId, this.offerPrice,
      this.expirationTime, this.offerExpirationTime);

  OfferRequest.build(
      userId, listingId, offerId, offerPrice, offerExpirationTime)
      : this(userId, listingId, offerId, offerPrice, offerExpirationTime,
            offerExpirationTime);

  OfferRequest.empty()
      : this(currentUser!.username, '', '', 0, DateTime.now().toUtc(),
            DateTime.now().toUtc());

  factory OfferRequest.fromJson(Map<String, dynamic> json) =>
      _$OfferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OfferRequestToJson(this);
}
