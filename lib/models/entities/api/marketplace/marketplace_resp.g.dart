// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marketplace_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInventoryVehicleResponse _$GetInventoryVehicleResponseFromJson(
        Map<String, dynamic> json) =>
    GetInventoryVehicleResponse(
      InventoryItem.fromJson(json['inventoryItem'] as Map<String, dynamic>),
      Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetInventoryVehicleResponseToJson(
        GetInventoryVehicleResponse instance) =>
    <String, dynamic>{
      'inventoryItem': instance.inventoryItem,
      'vehicle': instance.vehicle,
    };

GetInventoryResponse _$GetInventoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetInventoryResponse(
      (json['inventory'] as List<dynamic>)
          .map((e) =>
              GetInventoryVehicleResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetInventoryResponseToJson(
        GetInventoryResponse instance) =>
    <String, dynamic>{
      'inventory': instance.inventory,
    };

GetListingResponse _$GetListingResponseFromJson(Map<String, dynamic> json) =>
    GetListingResponse(
      Listing.fromJson(json['listing'] as Map<String, dynamic>),
      InventoryItem.fromJson(json['inventoryItem'] as Map<String, dynamic>),
      Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetListingResponseToJson(GetListingResponse instance) =>
    <String, dynamic>{
      'listing': instance.listing,
      'inventoryItem': instance.inventoryItem,
      'vehicle': instance.vehicle,
    };

GetListingsResponse _$GetListingsResponseFromJson(Map<String, dynamic> json) =>
    GetListingsResponse(
      (json['listings'] as List<dynamic>)
          .map((e) => GetListingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetListingsResponseToJson(
        GetListingsResponse instance) =>
    <String, dynamic>{
      'listings': instance.listings,
    };

GetMarketplacesResponse _$GetMarketplacesResponseFromJson(
        Map<String, dynamic> json) =>
    GetMarketplacesResponse(
      (json['marketplaces'] as List<dynamic>)
          .map((e) => Marketplace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMarketplacesResponseToJson(
        GetMarketplacesResponse instance) =>
    <String, dynamic>{
      'marketplaces': instance.marketplaces,
    };

GetOffersResponse _$GetOffersResponseFromJson(Map<String, dynamic> json) =>
    GetOffersResponse(
      (json['offers'] as List<dynamic>)
          .map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOffersResponseToJson(GetOffersResponse instance) =>
    <String, dynamic>{
      'offers': instance.offers,
    };

GetInventorySummaryResponse _$GetInventorySummaryResponseFromJson(
        Map<String, dynamic> json) =>
    GetInventorySummaryResponse(
      (json['inventorySummary'] as List<dynamic>)
          .map((e) => GetInventoryVehicleSummaryResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetInventorySummaryResponseToJson(
        GetInventorySummaryResponse instance) =>
    <String, dynamic>{
      'inventorySummary': instance.inventorySummary,
    };

GetInventoryVehicleSummaryResponse _$GetInventoryVehicleSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    GetInventoryVehicleSummaryResponse(
      InventoryItemSummary.fromJson(
          json['inventoryItemSummary'] as Map<String, dynamic>),
      VehicleSummary.fromJson(json['vehicleSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetInventoryVehicleSummaryResponseToJson(
        GetInventoryVehicleSummaryResponse instance) =>
    <String, dynamic>{
      'inventoryItemSummary': instance.inventoryItemSummary,
      'vehicleSummary': instance.vehicleSummary,
    };

GetListingsSummaryResponse _$GetListingsSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    GetListingsSummaryResponse(
      (json['listingSummary'] as List<dynamic>)
          .map((e) =>
              GetListingSummaryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetListingsSummaryResponseToJson(
        GetListingsSummaryResponse instance) =>
    <String, dynamic>{
      'listingSummary': instance.listingSummary,
    };

GetListingSummaryResponse _$GetListingSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    GetListingSummaryResponse(
      Listing.fromJson(json['listing'] as Map<String, dynamic>),
      InventoryItemSummary.fromJson(
          json['inventoryItemSummary'] as Map<String, dynamic>),
      VehicleSummary.fromJson(json['vehicleSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetListingSummaryResponseToJson(
        GetListingSummaryResponse instance) =>
    <String, dynamic>{
      'listing': instance.listing,
      'inventoryItemSummary': instance.inventoryItemSummary,
      'vehicleSummary': instance.vehicleSummary,
    };

InventoryItemSummary _$InventoryItemSummaryFromJson(
        Map<String, dynamic> json) =>
    InventoryItemSummary(
      json['id'] as String,
      json['vehicleId'] as String,
      json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      (json['purchasedPrice'] as num).toDouble(),
      $enumDecode(_$InventoryItemStateEnumMap, json['state']),
    );

Map<String, dynamic> _$InventoryItemSummaryToJson(
        InventoryItemSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleId': instance.vehicleId,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'purchasedPrice': instance.purchasedPrice,
      'state': _$InventoryItemStateEnumMap[instance.state],
    };

const _$InventoryItemStateEnumMap = {
  InventoryItemState.ACTIVE: 'ACTIVE',
  InventoryItemState.LISTED: 'LISTED',
  InventoryItemState.TRANSFERRED_IN: 'TRANSFERRED_IN',
  InventoryItemState.TRANSFERRED_OUT: 'TRANSFERRED_OUT',
  InventoryItemState.REMOVED: 'REMOVED',
  InventoryItemState.SOLD: 'SOLD',
};

VehicleSummary _$VehicleSummaryFromJson(Map<String, dynamic> json) =>
    VehicleSummary(
      json['id'] as String,
      json['vin'] as String,
      json['ymmt'] as String,
    );

Map<String, dynamic> _$VehicleSummaryToJson(VehicleSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vin': instance.vin,
      'ymmt': instance.ymmt,
    };
