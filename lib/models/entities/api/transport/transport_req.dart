import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';

part 'transport_req.g.dart';

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

  TransportInfo.fromSession(Session session)
      : this(
            session.customerName ?? "",
            "",
            session.address1 ?? "",
            session.address2 ?? "",
            session.city,
            session.state,
            session.zipCode,
            session.phone,
            "");

  TransportInfo.empty() : this('', '', '', '', '', '', '', '', '');

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

  PutNewOrderRequest.basicInfo(vin, title)
      : this('', '', vin, title, '', TransportInfo.empty(),
            TransportInfo.empty(), DateTime.now().toUtc());

  PutNewOrderRequest.fromSession(Session session)
      : this(
            '',
            '',
            session.vin,
            session.title,
            '',
            TransportInfo.fromSession(session),
            TransportInfo.empty(),
            DateTime.now().toUtc());

  factory PutNewOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$PutNewOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PutNewOrderRequestToJson(this);
}
