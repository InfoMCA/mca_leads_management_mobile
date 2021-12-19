import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/vehicle.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';

part 'listing.g.dart';

enum ListingState { ACTIVE, SOLD, REMOVED, EXPIRED }

extension ListingStateExt on ListingState {
  getName() {
    return toString().substring(toString().lastIndexOf(".") + 1);
  }
}

@JsonSerializable()
class Listing {
  String id;
  String sellerId;
  String vehicleId;
  String inventoryItemId;
  ListingState state;
  int initialOfferPrice;
  int offerCount;
  int? salePrice;
  DateTime createdTime;
  DateTime lastModifiedTime;
  DateTime expirationTime;

  Listing(
      this.id,
      this.sellerId,
      this.vehicleId,
      this.inventoryItemId,
      this.state,
      this.initialOfferPrice,
      this.offerCount,
      this.salePrice,
      this.createdTime,
      this.lastModifiedTime,
      this.expirationTime);

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);

  Map<String, dynamic> toJson() => _$ListingToJson(this);
}

class ListingNewReq {
  int offerPrice;
  DateTime expirationDate;

  ListingNewReq(this.offerPrice, this.expirationDate);
}
