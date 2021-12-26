import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:collection';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/lead_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/session_interface.dart';

import 'api/logical_view.dart';
import 'marketplace/offer.dart';

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
}

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
  // return [
  //     LeadSummary("123","321", "Toyota 2019", "123ADSAS123",LeadViewTag.approved,DateTime.now()),
  //     LeadSummary("123","321", "Toyota 2019", "123ADSAS123",LeadViewTag.approved,DateTime.now()),
  //     LeadSummary("123","321", "Toyota 2019", "123ADSAS123",LeadViewTag.approved,DateTime.now()),
  // ];
  List<LeadSummary>? newLeads;
  if (logicalView.isLeadView()) {
    newLeads = await LeadInterface().getLeads(logicalView);
  } else if (logicalView.isSessionView()) {
    newLeads = await SessionInterface().getSessions(logicalView);
  } else if (logicalView.isInventory()) {
    newLeads = await MarketplaceInterface().getInventoriesSummary();
  } else if (logicalView.isMarketplaceView()) {
    newLeads = await MarketplaceInterface().getListingsSummary();
  } else if (logicalView == LogicalView.receivedOffer) {
    newLeads = await MarketplaceInterface().getListingsReceivedOffer();
  } else if (logicalView == LogicalView.sentOffer) {
    newLeads = await MarketplaceInterface().getListingsSentOffer();
  }
  return newLeads;
}
