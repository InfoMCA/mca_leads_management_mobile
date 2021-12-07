import 'package:json_annotation/json_annotation.dart';

part 'listing.g.dart';

enum ListingState {
  ACTIVE,
  SOLD,
  REMOVED,
  EXPIRED
}

@JsonSerializable()
class Listing {
  String id;
  String marketplaceId;
  String sellerId;
  String vehicleId;
  ListingState state;
  int initialOfferPrice;
  int salePrice;
  DateTime createdTime;
  DateTime lastModifiedTime;
  DateTime expirationTime;

  Listing(
      this.id,
      this.marketplaceId,
      this.sellerId,
      this.vehicleId,
      this.state,
      this.initialOfferPrice,
      this.salePrice,
      this.createdTime,
      this.lastModifiedTime,
      this.expirationTime);

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  Map<String, dynamic> toJson() => _$ListingToJson(this);

}
