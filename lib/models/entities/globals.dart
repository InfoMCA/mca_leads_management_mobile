import 'dart:developer' as dev;
import 'dart:collection';

import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';

String? inspectionConfigStr;
AuthUserModel? _user;
Map<LogicalView, List<LeadSummary>?> leadSummaries = HashMap();

List<Session> inventories = [];

AuthUserModel? get currentUser {
  return _user;
}

set currentUser(AuthUserModel? newUser) {
  _user = newUser;
}

Future<List<LeadSummary>?> getLeads(LogicalView logicalView) async {
  List<LeadSummary>? newLeads;
  if (logicalView.isLeadView()) {
    newLeads = await BackendInterface().getLeads(logicalView);
  } else if (logicalView.isSessionView()) {
    newLeads = await BackendInterface().getSessions(logicalView);
  } else if (logicalView.isInventory()) {
    newLeads = await BackendInterface().getInventories(logicalView);
  } else if (logicalView.isMarketplaceView()) {
    newLeads = await BackendInterface().getListings(logicalView);
  }


if (newLeads!.isNotEmpty) {
    leadSummaries.putIfAbsent(logicalView, () => newLeads);
  }
  return leadSummaries[logicalView];
}

sendSessionToInventoryMock(BackendReq backendReq) async {
  Session? session = await BackendInterface().getSession(backendReq.objectId!);
  inventories.add(session!);
  dev.log(inventories.length.toString());
}

List<LeadSummary> getInventoriesMock() {
  dev.log(inventories.length.toString());
  return inventories.map((e) => LeadSummary(e.id, e.title, e.vin, LeadViewTag.inventory, DateTime.now())).toList();
}
