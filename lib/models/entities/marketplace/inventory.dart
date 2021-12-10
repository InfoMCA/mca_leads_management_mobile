import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/vehicle.dart';

part 'inventory.g.dart';

enum InventoryItemState {
  ACTIVE,
  TRANSFERRED_IN,
  TRANSFERRED_OUT,
  REMOVED,
  SOLD // inventory item was sold/auctioned outside the marketplace
}

extension InventoryItemStateExt on InventoryItemState {
  getViewTag() {
    switch (this) {

      case InventoryItemState.ACTIVE:
        return LeadViewTag.inventory;
      case InventoryItemState.TRANSFERRED_IN:
        return LeadViewTag.transferIn;
      case InventoryItemState.TRANSFERRED_OUT:
        return LeadViewTag.transferOut;
      case InventoryItemState.REMOVED:
        return LeadViewTag.listing;
    }
  }
}

@JsonSerializable()
class InventoryItem {
  String id;
  String vehicleId;
  String dealerId;
  double purchasedPrice;
  double deductionsAmount;
  double lenderAmount;
  double customerAmount;
  double withholdingAmount;
  InventoryItemState state;
  DateTime createdTime;
  DateTime lastModifiedTime;
  DateTime transferTime;
  String? sellerId;
  int? tradedPrice;


  InventoryItem(
      this.id,
      this.vehicleId,
      this.dealerId,
      this.purchasedPrice,
      this.deductionsAmount,
      this.lenderAmount,
      this.customerAmount,
      this.withholdingAmount,
      this.state,
      this.createdTime,
      this.lastModifiedTime,
      this.transferTime,
      this.sellerId,
      this.tradedPrice);

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);

}

@JsonSerializable()
class InventoryVehicle {
  InventoryItem inventoryItem;
  Vehicle vehicle;

  InventoryVehicle(this.inventoryItem, this.vehicle);
  factory InventoryVehicle.fromJson(Map<String, dynamic> json) =>
      _$InventoryVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryVehicleToJson(this);
}