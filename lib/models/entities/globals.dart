import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:collection';

import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';

import 'api/logical_view.dart';

String? inspectionConfigStr;
AuthUserModel? _user;
Map<LogicalView, List<LeadSummary>?> leadSummaries = HashMap();

List<Session> inventories = [];
List<Listing> listings = [];
List<Session> vehicles = [];

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
  vehicles.add(session);
  dev.log(inventories.length.toString());
}

List<LeadSummary> getInventoriesMock() {
  return inventories.map((e) => LeadSummary(e.id, e.title, e.vin, LeadViewTag.inventory, DateTime.now())).toList();
}


List<LeadSummary> getListingsMock() {
  return listings.map((e) {
    Session session = vehicles
        .where((element) => e.vehicleId == element.id)
        .first;
    return LeadSummary(
        session.id, session.title, session.vin, LeadViewTag.listing,
        e.expirationTime);
  }).toList();
}

Future<List<String>> getMarketPlacesMock(BackendReq backendReq) {
  return Future.value(['First MarketPlace', 'Lexus MarketPlace', 'Irvine MarketPlace']);
}

createNewListingMock(BackendReq backendReq) {
  List<String> marketPlaces = json.decode(backendReq.params!['marketPlaceIds']!).cast<String>();

  listings.addAll(marketPlaces.map((element) =>
    Listing(
        backendReq.objectId! + "_" + element,
        element,
        currentUser!.username,
        backendReq.objectId!,
        ListingState.ACTIVE,
        int.parse(backendReq.params!['listingPrice']!),
        0,
        DateTime.now(), DateTime.now(),
        DateTime.parse(backendReq.params!['expirationDate']!))

  ).toList());
  dev.log("Listing Size: ${listings.length}");
  inventories.remove(inventories.where((element) => element.id == backendReq.objectId).first);

}