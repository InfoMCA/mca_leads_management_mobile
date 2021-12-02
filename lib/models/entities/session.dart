
import 'package:enum_to_string/enum_to_string.dart';

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

class Session {
  /// Items pertaining to Session object in the backend
  String id;
  SessionStatus? sessionStatus;
  String title;
  String vin;
  String color;
  int mileage;
  double estimatedCr;
  int askingPrice;
  int offeredPrice;
  int requestedPrice;
  int mmr;
  String address1;
  String address2;
  String city;
  String state;
  String zipCode;
  String staff;
  String region;
  String service;
  String scheduledDateTime; // Same as sessionDateTime but in string format
  String phone;
  String customerName;

  Session({
    required this.id,
    required this.sessionStatus,
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
    required this.scheduledDateTime
  });

  factory Session.fromJson(dynamic json) {
    return Session(
      id: json['id'] as String,
      sessionStatus: EnumToString.fromString(
          SessionStatus.values, json['status'] as String),
      title: json['title'] as String,
      vin: json['vin'] as String,
      mileage: json['mileage'] as int,
      color: json['color'] as String,
      estimatedCr: json['estimatedCr'] as double,
      askingPrice: json['askingPrice'] as int,
      mmr: json['mmr'] as int,
      requestedPrice: json['requestedPrice'] as int,
      offeredPrice: json['offeredPrice'] as int,
      address1: json['address1'] as String,
      address2: json['address2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      staff: json['staff'] as String,
      region: json['region'] as String,
      service: json['service'] as String,
      phone: json['phone'] as String,
      customerName: json['customerName'] ?? "N/A",
      scheduledDateTime: json['scheduledDateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sessionStatus': EnumToString.convertToString(sessionStatus),
      'title': title,
      'vin': vin,
      'color': color,
      'mileage': mileage,
      'estimatedCr': estimatedCr,
      'askingPrice': askingPrice,
      'requestedPrice': requestedPrice,
      'offeredPrice': offeredPrice,
      'mmr': mmr,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'staff': staff,
      'region': region,
      'service': service,
      'customerName': customerName,
      'phone': phone,
      'scheduledDateTime': scheduledDateTime
    };
  }

  String getAddress() {
    String address = address1 + ", ";
    if (address2.isNotEmpty) {
      address += address2 + ", ";
    }
    address += city + ", " + state + ", " + zipCode;
    return address;
  }
}
