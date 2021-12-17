import 'package:mca_leads_management_mobile/views/lead/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/inventory_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/marketplace_listing_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/offer_details_view.dart';
import 'package:mca_leads_management_mobile/views/session/session_active_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_complete_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_details.dart';

enum LogicalView {
  approval,
  followUpManager,
  appraisal,
  dispatched,
  active,
  completed,
  inventory,
  receivedOffer,
  sentOffer,
  marketplace,
  transferRequest,
  transferPlaced,
  transferActive,
  transferCompleted,
}

extension LogicalViewExt on LogicalView {
  String getName() {
    switch (this) {
      case LogicalView.approval:
        return 'Awaiting Approval';
      case LogicalView.followUpManager:
        return 'Follow Up';
      case LogicalView.appraisal:
        return 'Appraisal';
      case LogicalView.dispatched:
        return 'Scheduled';
      case LogicalView.active:
        return 'In Progress';
      case LogicalView.completed:
        return 'Completed';
      case LogicalView.inventory:
        return 'Inventory';
      case LogicalView.receivedOffer:
        return 'Received Offers';
      case LogicalView.sentOffer:
        return 'Sent Offer';
      case LogicalView.marketplace:
        return 'Marketplace';
      case LogicalView.transferRequest:
        return 'Requested';
      case LogicalView.transferPlaced:
        return 'Scheduled';
      case LogicalView.transferActive:
        return 'In Progress';
      case LogicalView.transferCompleted:
        return 'Completed';
    }
  }

  String getRouteName() {
    switch (this) {
      case LogicalView.approval:
      case LogicalView.followUpManager:
      case LogicalView.appraisal:
        return LeadDetailsView.routeName;
      case LogicalView.dispatched:
        return SessionDetails.routeName;
      case LogicalView.active:
        return SessionActiveDetailsView.routeName;
      case LogicalView.completed:
        return SessionDetailsCompleteReport.routeName;
      case LogicalView.inventory:
        return InventoryDetailView.routeName;
      case LogicalView.marketplace:
        return MarketListingDetailView.routeName;
      case LogicalView.sentOffer:
      case LogicalView.receivedOffer:
        return OfferDetailView.routeName;
      case LogicalView.transferRequest:
      case LogicalView.transferPlaced:
      case LogicalView.transferActive:
      case LogicalView.transferCompleted:
        return LeadDetailsView.routeName;
    }
  }

  String getString() {
    return toString().substring(toString().lastIndexOf('.') + 1);
  }

  String getRestParam() {
    switch (this) {
      case LogicalView.approval:
      case LogicalView.appraisal:
      case LogicalView.dispatched:
      case LogicalView.active:
      case LogicalView.completed:
      case LogicalView.inventory:
        return getString().toUpperCase();
      case LogicalView.followUpManager:
        return "FOLLOW_UP_MANAGER";
      case LogicalView.receivedOffer:
      case LogicalView.sentOffer:
      case LogicalView.marketplace:
      case LogicalView.transferRequest:
      case LogicalView.transferPlaced:
      case LogicalView.transferActive:
      case LogicalView.transferCompleted:
        return "";
    }
  }

  bool isLeadView() {
    return [
      LogicalView.approval,
      LogicalView.followUpManager,
      LogicalView.appraisal
    ].contains(this);
  }

  bool isSessionView() {
    return [LogicalView.dispatched, LogicalView.active, LogicalView.completed]
        .contains(this);
  }

  bool isInventory() {
    return [LogicalView.inventory].contains(this);
  }

  bool isOfferView() {
    return [LogicalView.sentOffer, LogicalView.receivedOffer].contains(this);
  }

  bool isMarketplaceView() {
    return [LogicalView.marketplace].contains(this);
  }
}
