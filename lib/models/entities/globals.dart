import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:collection';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/lead_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';

import 'api/logical_view.dart';
import 'marketplace/offer.dart';

String? inspectionConfigStr;
AuthUserModel? _user;
Map<LogicalView, List<LeadSummary>?> leadSummaries = HashMap();

List<Session> inventories = [];
List<Listing> listings = [];
List<Session> vehicles = [];
List<Offer> offers = [];

FlexSchemeColor darkColor = FlexColor.deepPurple.dark;
FlexSchemeColor lightColor = FlexColor.deepPurple.light;

AuthUserModel? get currentUser {
  return _user;
}

set currentUser(AuthUserModel? newUser) {
  _user = newUser;
}

Future<List<LeadSummary>?> getLeads(LogicalView logicalView) async {
  List<LeadSummary>? newLeads;
  if (logicalView.isLeadView()) {
    newLeads = await LeadInterface().getLeads(logicalView);
  } else if (logicalView.isSessionView()) {
    newLeads = await BackendInterface().getSessions(logicalView);
  } else if (logicalView.isInventory()) {
    newLeads = await MarketplaceInterface().getInventoriesSummary();
  } else if (logicalView.isMarketplaceView()) {
    newLeads = await MarketplaceInterface().getListingsSummary();
  } else if (logicalView == LogicalView.receivedOffer) {
    newLeads = await MarketplaceInterface().getListingsReceivedOffer();
  }  else if (logicalView == LogicalView.sentOffer) {
    newLeads = await MarketplaceInterface().getListingsSentOffer();
  }
  return newLeads;
}

void sendSessionToInventoryMock(BackendReq backendReq) async {
  Session? session = await BackendInterface().getSession(backendReq.objectId!);
  inventories.add(session!);
  vehicles.add(session);
  dev.log(inventories.length.toString());
}

List<LeadSummary> getInventoriesMock() {
  return inventories.map((e) => LeadSummary(e.id, e.id, e.title, e.vin, LeadViewTag.inventory, DateTime.now())).toList();
}


List<LeadSummary> getListingsMock() {
  return getUniqueList(listings.map((e) {
    Session session = vehicles
        .where((element) => e.vehicleId == element.id)
        .first;
    return LeadSummary(
        e.id, e.id, session.title, session.vin, LeadViewTag.listing,
        e.expirationTime);
  }).toList());
}

Future<List<String>> getMarketPlacesMock(BackendReq backendReq) {
  return Future.value(['First MarketPlace', 'Lexus MarketPlace', 'Irvine MarketPlace']);
}

List<LeadSummary> getUniqueList(List<LeadSummary> list) {
  Set<String> visitedVin = {};
  List<LeadSummary> result = [];
  for (var leadSummary in list) {
    if (visitedVin.contains(leadSummary.vin)) {
      continue;
    }
    visitedVin.add(leadSummary.vin);
    result.add(leadSummary);
  }
  return result;
}
