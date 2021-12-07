
import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/listing/listing_details_view.dart';
import 'package:mca_leads_management_mobile/views/session/session_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_details_complete.dart';

part 'lead.g.dart';

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
        return ListingDetailView.routeName;
      case LogicalView.marketplace:
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

  String? comments;
  String? conditionQuestions;

  // For Scheduling
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zipCode;
  String? region;


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
    required this.customerName,
    required this.comments,
    required this.conditionQuestions,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.region
  });


  factory Lead.fromJson(Map<String, dynamic> json) =>
      _$LeadFromJson(json);

  Map<String, dynamic> toJson() => _$LeadToJson(this);

}
