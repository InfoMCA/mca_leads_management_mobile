import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/inventory.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/marketplace.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/offer.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/vehicle.dart';

part 'marketplace_resp.g.dart';

@JsonSerializable()
class GetInventoryVehicleResponse {
  InventoryItem inventoryItem;
  Vehicle vehicle;

  GetInventoryVehicleResponse(this.inventoryItem, this.vehicle);

  factory GetInventoryVehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInventoryVehicleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetInventoryVehicleResponseToJson(this);
}

@JsonSerializable()
class GetInventoryResponse {
  List<GetInventoryVehicleResponse> inventory;

  GetInventoryResponse(this.inventory);

  factory GetInventoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInventoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetInventoryResponseToJson(this);
}

@JsonSerializable()
class GetListingResponse {
  Listing listing;
  InventoryItem inventoryItem;
  Vehicle vehicle;

  GetListingResponse(this.listing, this.inventoryItem, this.vehicle);

  factory GetListingResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListingResponseToJson(this);
}

@JsonSerializable()
class GetListingsResponse {
  List<GetListingResponse> listings;

  GetListingsResponse(this.listings);

  factory GetListingsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListingsResponseToJson(this);
}

@JsonSerializable()
class GetMarketplacesResponse {
  List<Marketplace> marketplaces;

  GetMarketplacesResponse(this.marketplaces);

  factory GetMarketplacesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMarketplacesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMarketplacesResponseToJson(this);
}

@JsonSerializable()
class GetOffersResponse {
  List<Offer> offers;

  GetOffersResponse(this.offers);

  factory GetOffersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOffersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetOffersResponseToJson(this);
}

@JsonSerializable()
class GetInventorySummaryResponse {
  List<GetInventoryVehicleSummaryResponse> inventorySummary;

  GetInventorySummaryResponse(this.inventorySummary);
  factory GetInventorySummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInventorySummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetInventorySummaryResponseToJson(this);
}

@JsonSerializable()
class GetInventoryVehicleSummaryResponse {
  InventoryItemSummary inventoryItemSummary;
  VehicleSummary vehicleSummary;

  GetInventoryVehicleSummaryResponse(
      this.inventoryItemSummary, this.vehicleSummary);

  factory GetInventoryVehicleSummaryResponse.fromJson(
          Map<String, dynamic> json) =>
      _$GetInventoryVehicleSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetInventoryVehicleSummaryResponseToJson(this);
}

@JsonSerializable()
class GetListingsSummaryResponse {
  List<GetListingSummaryResponse> listingSummary;

  GetListingsSummaryResponse(this.listingSummary);

  factory GetListingsSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListingsSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListingsSummaryResponseToJson(this);
}

@JsonSerializable()
class GetListingSummaryResponse {
  Listing listing;
  InventoryItemSummary inventoryItemSummary;
  VehicleSummary vehicleSummary;

  GetListingSummaryResponse(
      this.listing, this.inventoryItemSummary, this.vehicleSummary);

  factory GetListingSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListingSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListingSummaryResponseToJson(this);
}

@JsonSerializable()
class InventoryItemSummary {
  String id;
  String vehicleId;
  DateTime? purchaseDate;
  double purchasedPrice;
  InventoryItemState state;

  InventoryItemSummary(this.id, this.vehicleId, this.purchaseDate,
      this.purchasedPrice, this.state);

  factory InventoryItemSummary.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryItemSummaryToJson(this);
}

@JsonSerializable()
class VehicleSummary {
  String id;
  String vin;
  String ymmt;

  VehicleSummary(this.id, this.vin, this.ymmt);

  factory VehicleSummary.fromJson(Map<String, dynamic> json) =>
      _$VehicleSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleSummaryToJson(this);
}
