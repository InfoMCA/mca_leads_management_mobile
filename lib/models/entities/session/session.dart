import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/utils/datetime_tools.dart';

part 'session.g.dart';

enum SessionStatus {
  None,
  // In progress, indicating session starts by client.
  Progress,
  // Session is created and assigned to staff.
  Dispatched,
  // Session is completed by staff waiting for user approval.
  PendingApproval,
  // Session is approved.
  Approved,
  // Session is rejected.
  Rejected,
  // All uploaded document are reviewed by title team
  Reviewing,
  // Session is completed and received all documents.
  Completed,
  // Report is uploading
  UpLoading,
  // Report is Active
  Active,
}

extension SessionStatusString on SessionStatus {
  String getName() {
    switch (this) {
      case SessionStatus.Progress:
        return "In progress";
      case SessionStatus.Dispatched:
        return "Dispatched Session";
      case SessionStatus.PendingApproval:
        return "Pending Approval";
      case SessionStatus.Approved:
        return "Approved (Needs documents)";
      case SessionStatus.Rejected:
        return "Rejected";
      case SessionStatus.Reviewing:
        return "Reviewing";
      case SessionStatus.Completed:
        return "Completed";
      case SessionStatus.UpLoading:
        return "Uploading";
      case SessionStatus.Active:
        return "Active";
      case SessionStatus.None:
      default:
        return "Unknown";
    }
  }
}

@JsonSerializable()
class Session {
  /// Items pertaining to Session object in the backend
  String id;
  String title;
  String vin;
  String? color;
  int? mileage;
  double estimatedCr;
  int? askingPrice;
  int? offeredPrice;
  int? requestedPrice;
  int? mmr;
  double? purchasedPrice;
  double? deductionsAmount;
  double? lenderAmount;
  double? customerAmount;
  double? withholdingAmount;
  DateTime? purchasedDate;
  String? address1;
  String? address2;
  String city;
  String state;
  String zipCode;
  String staff;
  String? region;
  String service;
  String _scheduledDateTime;
  String phone;
  String? customerName;

  DateTime? get scheduledDateTime => DateTime.tryParse(_scheduledDateTime);

  set scheduledDate(DateTime date) =>
      (scheduledDateTime ?? DateTime.now()).setDate(date);

  set scheduledTime(TimeOfDay timeOfDay) =>
      (scheduledDateTime ?? DateTime.now()).setTime(timeOfDay);

  Session(
      {required this.id,
      required this.title,
      required this.vin,
      required this.color,
      required this.mileage,
      required this.estimatedCr,
      required this.askingPrice,
      required this.offeredPrice,
      required this.requestedPrice,
      required this.mmr,
      required this.phone,
      required this.customerName,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.zipCode,
      required this.region,
      required this.service,
      required this.staff,
      required String scheduledDateTime})
      : _scheduledDateTime = scheduledDateTime;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  String getAddress() {
    String address = address1 ?? "" ", ";
    if (address2!.isNotEmpty) {
      address += address2! + ", ";
    }
    address += city + ", " + state + ", " + zipCode;
    return address;
  }

  DateTime setDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
