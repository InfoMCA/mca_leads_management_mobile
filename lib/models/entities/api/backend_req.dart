import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';

part 'backend_req.g.dart';

enum CommandObject { user, region, lead, session, inventory, listing, offer, transport }

enum CommandIntent {
  create,
  getById,
  getAll,
  search,
  save,
  action,
}

enum CommandAction {
  // Lead Actions
  leadDispatch,
  leadFollowUp,
  leadUnanswered,
  leadApprovedOffer,
  leadApprovedDeal,
  leadLost,
  // Session Actions
  sessionSchedule,
  sessionLost,
  sessionReport,
  // User Action
  userLogin,
  // Region Action
  regionGetByZipcode,
  regionGetInspectors,
  //
  listingNew,
  listingGetMarketplaces
}

@JsonSerializable()
class BackendReq {
  String username;
  CommandObject object;
  CommandIntent intent;
  CommandAction? action;
  String? objectId;
  Lead? lead;
  Session? session;

  ///Either LeadAction, SessionAction or UserAction enums
  Map<String, String>? params;

  BackendReq({required this.username,
    required this.object,
    required this.intent,
    this.action,
    this.objectId,
    this.lead,
    this.session,
    this.params});

  factory BackendReq.fromJson(Map<String, dynamic> json) =>
      _$BackendReqFromJson(json);

  Map<String, dynamic> toJson() => _$BackendReqToJson(this);
}
