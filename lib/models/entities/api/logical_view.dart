import 'package:mca_leads_management_mobile/views/lead/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/inventory_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/listing_details_view.dart';
import 'package:mca_leads_management_mobile/views/session/session_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_details_complete.dart';

enum LogicalView {
  approval,
  followUpManager,
  appraisal,
  dispatched,
  active,
  completed,
  inventory,
  trading,
  traded,
  marketplace,
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
        return 'Dispatched';
      case LogicalView.active:
        return 'In Progress';
      case LogicalView.completed:
        return 'Completed';
      case LogicalView.inventory:
        return 'Inventory';
      case LogicalView.trading:
        return 'Trading';
      case LogicalView.traded:
        return 'Traded';
      case LogicalView.marketplace:
        return 'Marketplace';
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
        return SessionDetailsComplete.routeName;
      case  LogicalView.completed:
        return SessionDetailsComplete.routeName;
      case LogicalView.inventory:
        return InventoryDetailView.routeName;
      case LogicalView.marketplace:
        return ListingDetailView.routeName;
      case LogicalView.traded:
      case LogicalView.trading:
        return "";
    }
  }

  String getString() {
    return toString().substring(toString().lastIndexOf('.') + 1);
  }

  bool isLeadView() {
    return [LogicalView.approval, LogicalView.followUpManager, LogicalView.appraisal].contains(this);
  }

  bool isSessionView() {
    return [LogicalView.dispatched, LogicalView.active, LogicalView.completed].contains(this);
  }

  bool isInventory() {
    return [LogicalView.inventory].contains(this);
  }

  bool isMarketplaceView() {
    return [LogicalView.trading, LogicalView.traded, LogicalView.marketplace].contains(this);
  }
}