import 'package:json_annotation/json_annotation.dart';

part 'lead.g.dart';

enum LeadView {
  approval,
  followUp,
  appraisal,
  dispatched,
  active,
  completed
}

extension LeadViewExt on LeadView {
  String getName() {
    switch (this) {
      case LeadView.approval:
        return 'Awaiting Approval';
      case LeadView.followUp:
        return 'Follow Up';
      case LeadView.appraisal:
        return 'Appraisal';
      case LeadView.dispatched:
        return 'Dispatched';
      case LeadView.active:
        return 'In Progress';
      case LeadView.completed:
        return 'Completed';
    }
  }
}

@JsonSerializable()
class Lead {
  /// Items pertaining to Session object in the backend
  String id;
  String name;
  String vin;
  String color;
  int mileage;
  double estimatedCr;
  int askingPrice;
  int? offeredPrice;
  int? requestedPrice;
  int mmr;
  String mobileNumber;
  String? customerName;
  String? payoffStatus;


  Lead({
    required this.id,
    required this.name,
    required this.vin,
    required this.color,
    required this.mileage,
    required this.estimatedCr,
    required this.askingPrice,
    required this.offeredPrice,
    required this.requestedPrice,
    required this.mmr,
    required this.mobileNumber,
    required this.customerName
  });


  factory Lead.fromJson(Map<String, dynamic> json) =>
      _$LeadFromJson(json);

  Map<String, dynamic> toJson() => _$LeadToJson(this);

}
