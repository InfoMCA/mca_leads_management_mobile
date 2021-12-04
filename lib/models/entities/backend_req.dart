import 'package:json_annotation/json_annotation.dart';

part 'backend_req.g.dart';

enum CommandObject { user, lead, session }

enum CommandIntent {
  getById,
  getAll,
  search,
  action,
}

enum LeadAction { schedule, followUp, unanswered, lost, save }

enum SessionAction { dispatch, lost, getInspectors, save }

enum UserAction { login }

@JsonSerializable()
class BackendReq {
  String username;
  CommandObject commandObject;
  CommandIntent commandIntent;
  String? objectId;

  ///Either LeadAction, SessionAction or UserAction enums
  dynamic actionType;
  dynamic value;

  BackendReq(
      {required this.username,
      required this.commandObject,
      required this.commandIntent,
      this.actionType,
      this.objectId,
      this.value});

  factory BackendReq.fromJson(Map<String, dynamic> json) =>
      _$BackendReqFromJson(json);

  Map<String, dynamic> toJson() => _$BackendReqToJson(this);
}
