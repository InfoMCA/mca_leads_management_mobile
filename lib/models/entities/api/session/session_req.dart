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

  SessionApproveRequest(
      this.username,
      this.customerName,
      this.purchasedPrice,
      this.deductionsAmount,
      this.lenderAmount,
      this.customerAmount,
      this.withholdingAmount);

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
