import 'package:json_annotation/json_annotation.dart';

part 'lead_req.g.dart';

@JsonSerializable()
class LeadFollowUpInfo {
  String username;
  String followUpComment;
  DateTime followUpDate;

  LeadFollowUpInfo(this.username, this.followUpComment, this.followUpDate);

  factory LeadFollowUpInfo.fromJson(Map<String, dynamic> json) =>
      _$LeadFollowUpInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LeadFollowUpInfoToJson(this);
}

@JsonSerializable()
class LeadUnAnsweredInfo {
  String username;
  bool sendSms;
  bool leftMessage;

  LeadUnAnsweredInfo(this.username, this.sendSms, this.leftMessage);

  factory LeadUnAnsweredInfo.fromJson(Map<String, dynamic> json) =>
      _$LeadUnAnsweredInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LeadUnAnsweredInfoToJson(this);
}

@JsonSerializable()
class LeadLostRequest {
  String username;
  String lostReason;

  LeadLostRequest(this.username, this.lostReason);

  factory LeadLostRequest.fromJson(Map<String, dynamic> json) =>
      _$LeadLostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeadLostRequestToJson(this);
}

@JsonSerializable()
class LeadUpdateRequest {
  String customerName;
  int offerPrice;
  int requestedPrice;
  String payoffStatus;
  String comment;

  LeadUpdateRequest(this.customerName, this.offerPrice, this.requestedPrice,
      this.payoffStatus, this.comment);

  factory LeadUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$LeadUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeadUpdateRequestToJson(this);
}

@JsonSerializable()
class GetInspectorsResp {
  String region;
  String timeZone;
  String userPhone;
  List<String> inspectors;

  GetInspectorsResp(
      this.region, this.timeZone, this.userPhone, this.inspectors);

  factory GetInspectorsResp.fromJson(Map<String, dynamic> json) =>
      _$GetInspectorsRespFromJson(json);

  Map<String, dynamic> toJson() => _$GetInspectorsRespToJson(this);
}

@JsonSerializable()
class LeadDispatchRequest {
  String username;
  String userPhone;
  String customerName;
  String? address1;
  String? address2;
  String? city;
  String state;
  String zipCode;
  String region;
  String timeZone;
  String inspector;
  int inspectionTime;
  DateTime scheduleDate;

  LeadDispatchRequest(
      this.username,
      this.userPhone,
      this.customerName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zipCode,
      this.region,
      this.timeZone,
      this.inspector,
      this.inspectionTime,
      this.scheduleDate);

  factory LeadDispatchRequest.fromJson(Map<String, dynamic> json) =>
      _$LeadDispatchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeadDispatchRequestToJson(this);
}

@JsonSerializable()
class LeadSearchRequest {
  String keyword;

  LeadSearchRequest(this.keyword);

  factory LeadSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$LeadSearchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeadSearchRequestToJson(this);
}
