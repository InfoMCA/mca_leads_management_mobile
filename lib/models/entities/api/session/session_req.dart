import 'package:json_annotation/json_annotation.dart';

part 'session_req.g.dart';

@JsonSerializable()
class SessionApproveRequest {
  String username;
  String customerName;
  double purchasedPrice;
  double deductionsAmount;
  double lenderAmount;
  double customerAmount;
  double withholdingAmount;

  SessionApproveRequest(this.username, this.customerName, this.purchasedPrice, this.deductionsAmount,
      this.lenderAmount, this.customerAmount, this.withholdingAmount);

  factory SessionApproveRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionApproveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SessionApproveRequestToJson(this);
}

@JsonSerializable()
class SessionRejectRequest {
  String username;

  SessionRejectRequest(this.username);

  factory SessionRejectRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRejectRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SessionRejectRequestToJson(this);
}

@JsonSerializable()
 class TransportInfo {

  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String zipCode;
  String phone;
  String email;

  TransportInfo(this.firstName, this.lastName, this.address1, this.address2,
      this.city, this.state, this.zipCode, this.phone, this.email);

  factory TransportInfo.fromJson(Map<String, dynamic> json) =>
      _$TransportInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TransportInfoToJson(this);

}

@JsonSerializable()
class PutNewOrderRequest {

  String customer;
  String broker;
  String vin;
  String title;
  String notes;
  TransportInfo source;
  TransportInfo destination;
  DateTime scheduledDate;

  PutNewOrderRequest(this.customer, this.broker, this.vin, this.title,
      this.notes, this.source, this.destination, this.scheduledDate);

  factory PutNewOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$PutNewOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PutNewOrderRequestToJson(this);

}