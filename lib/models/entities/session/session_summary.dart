import 'package:json_annotation/json_annotation.dart';

part 'session_summary.g.dart';

@JsonSerializable()
class SessionSummary {
  SessionSummary(this.id, this.title, this.vin, this.updatedTime);

  String id;
  String title;
  String vin;
  DateTime updatedTime;

  factory SessionSummary.fromJson(Map<String, dynamic> json) =>
      _$SessionSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SessionSummaryToJson(this);
}