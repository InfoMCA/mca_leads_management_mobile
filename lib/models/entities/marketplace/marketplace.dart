import 'package:json_annotation/json_annotation.dart';

part 'marketplace.g.dart';

@JsonSerializable()
class Marketplace {
  String id;
  String name;

  Marketplace(this.id, this.name);

  factory Marketplace.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceFromJson(json);

  Map<String, dynamic> toJson() => _$MarketplaceToJson(this);

}

@JsonSerializable()
class MarketplaceSale {
  String id;
  int createdTime;
  String offerId;
  String listingId;
  String vehicleId;
  String sellerId;
  String buyerId;
  int price;

  MarketplaceSale(this.id, this.createdTime, this.offerId, this.listingId,
      this.vehicleId, this.sellerId, this.buyerId, this.price);
  factory MarketplaceSale.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceSaleFromJson(json);

  Map<String, dynamic> toJson() => _$MarketplaceSaleToJson(this);
}