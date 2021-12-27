import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/inventory.dart';


class VehicleHighlight {
  String vin;
  String title;
  int? year;
  String? make;
  String? model;
  int mmr;
  int mileage;
  String color;
  double? purchasedPrice;
  double estimatedCr;
  DateTime? purchasedDate;
  DateTime? expiredListingDate;


  VehicleHighlight(this.vin,
      this.title,
      this.year,
      this.make,
      this.model,
      this.mmr,
      this.mileage,
      this.color,
      this.estimatedCr,
      this.purchasedPrice,
      this.expiredListingDate);

  VehicleHighlight.fromInventoryVehicle(
      GetInventoryVehicleResponse inventoryVehicle) :
        this(
          inventoryVehicle.vehicle.vin,
          inventoryVehicle.vehicle.ymmt,
          inventoryVehicle.vehicle.year,
          inventoryVehicle.vehicle.make,
          inventoryVehicle.vehicle.model,
          inventoryVehicle.vehicle.mmr,
          inventoryVehicle.vehicle.mileage,
          inventoryVehicle.vehicle.color,
          inventoryVehicle.vehicle.estimatedCr,
          inventoryVehicle.inventoryItem.purchasedPrice,
          null);

  String getCompactTitle() {
    if (title.length < 25) {
      return title;
    }
    return title.substring(0, 22) + "...";
  }
}
