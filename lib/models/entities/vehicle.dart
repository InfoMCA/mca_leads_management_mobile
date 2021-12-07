import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

enum VehicleState {
  LEAD_READY,
  LEAD_FOLLOWUP,
  LEAD_APPROVAL,
  LEAD_DENIED,
  LEAD_COMPLETE,
  LEAD_LOST,
  INSPECTION_NEW,
  INSPECTION_READY,
  INSPECTION_ACTIVE,
  INSPECTION_COMPLETE,
  INSPECTION_ARCHIVED,
  INSPECTION_DELETED,
  INVENTORY,
  MARKETPLACE_LISTED,
  SOLD,
  TRANSPORTATION_SUBMITTED,
  TRANSPORTATION_DISPATCHED,
  TRANSPORTATION_ACTIVE,
  TRANSPORTATION_COMPLETE,
  TRANSPORTATION_CANCELLED
}

@JsonSerializable()
class Vehicle {
  String id;
  String vin;
  String plate;
  String plateState;
  int year;
  String make;
  String model;
  String trim;
  int mileage;
  String color;
  String engineType;
  String drivetrain;
  String transmission;

  String dealerId;
  VehicleState state;
  DateTime createdTime;
  DateTime lastModifiedTime;

  // Used for indexing
  String dealerIdState;

  Vehicle(
      this.id,
      this.vin,
      this.plate,
      this.plateState,
      this.year,
      this.make,
      this.model,
      this.trim,
      this.mileage,
      this.color,
      this.engineType,
      this.drivetrain,
      this.transmission,
      this.dealerId,
      this.state,
      this.createdTime,
      this.lastModifiedTime,
      this.dealerIdState);

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);

}

