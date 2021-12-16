import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lead_summary.g.dart';

enum LeadViewTag {
  approvalBuyNow,
  approvalAuction,
  approvalDealMade,
  approvalPotentialDeal,
  followUpBuyNow,
  followUpAuction,
  followUpAppraisal,
  appraisal,
  ready,
  activeProgress,
  activePendingApproval,
  approved,
  rejected,
  complete,
  inventory,
  listing,
  transferIn,
  transferOut,
}

extension LeadViewTagExt on LeadViewTag {
  String getAbbrv() {
    switch (this) {
      case LeadViewTag.approvalBuyNow:
        return "B";
      case LeadViewTag.followUpBuyNow:
        return "B";
      case LeadViewTag.approvalAuction:
        return "A";
      case LeadViewTag.followUpAuction:
        return "A";
      case LeadViewTag.appraisal:
        return "A";
      case LeadViewTag.approvalDealMade:
        return "D";
      case LeadViewTag.approvalPotentialDeal:
        return "P";
      case LeadViewTag.followUpAppraisal:
        return "P";
      case LeadViewTag.ready:
        return "D";
      case LeadViewTag.activeProgress:
        return "P";
      case LeadViewTag.activePendingApproval:
        return "A";
      case LeadViewTag.complete:
        return "C";
      case LeadViewTag.approved:
        return "A";
      case LeadViewTag.rejected:
        return "R";
      case LeadViewTag.inventory:
        return "I";
      case LeadViewTag.listing:
        return "L";
      case LeadViewTag.transferIn:
        return "TI";
      case LeadViewTag.transferOut:
        return "TO";

    }
  }

  Color getBackgroundColor() {
    switch (this) {
      case LeadViewTag.approvalBuyNow:
      case LeadViewTag.approvalAuction:
      case LeadViewTag.followUpBuyNow:
      case LeadViewTag.followUpAuction:
      case LeadViewTag.activePendingApproval:
      case LeadViewTag.rejected:
      case LeadViewTag.inventory:
        return const Color.fromARGB(255, 255, 236, 235);
      case LeadViewTag.approvalDealMade:
      case LeadViewTag.followUpAppraisal:
      case LeadViewTag.appraisal:
      case LeadViewTag.ready:
      case LeadViewTag.activeProgress:
      case LeadViewTag.approved:
      case LeadViewTag.listing:
      case LeadViewTag.transferIn:
        return const Color.fromARGB(255, 234, 241, 254);
      case LeadViewTag.approvalPotentialDeal:
      case LeadViewTag.complete:
      case LeadViewTag.transferOut:
        return const Color.fromARGB(255, 233, 249, 236);
    }
  }

  Color getForegroundColor() {
    switch (this) {
      case LeadViewTag.approvalBuyNow:
      case LeadViewTag.approvalAuction:
      case LeadViewTag.followUpBuyNow:
      case LeadViewTag.followUpAuction:
      case LeadViewTag.activePendingApproval:
      case LeadViewTag.rejected:
      case LeadViewTag.inventory:
        return const Color.fromARGB(255, 245, 45, 59);
      case LeadViewTag.approvalDealMade:
      case LeadViewTag.followUpAppraisal:
      case LeadViewTag.appraisal:
      case LeadViewTag.ready:
      case LeadViewTag.activeProgress:
      case LeadViewTag.approved:
      case LeadViewTag.listing:
      case LeadViewTag.transferIn:
        return const Color.fromARGB(255, 44, 121, 244);
      case LeadViewTag.approvalPotentialDeal:
      case LeadViewTag.complete:
      case LeadViewTag.transferOut:
        return const Color.fromARGB(255, 50, 175, 84);
    }
  }
}

@JsonSerializable()
class LeadSummary {
  LeadSummary(this.id, this.vehicleId, this.title, this.vin, this.viewTag, this.updateDate);

  String id;
  String vehicleId;
  String title;
  String vin;
  LeadViewTag viewTag;
  DateTime? updateDate;

  factory LeadSummary.fromJson(Map<String, dynamic> json) =>
      _$LeadSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$LeadSummaryToJson(this);

  String getPrettyTime() {
    if (updateDate == null) {
      return "";
    }
    return updateDate!.day.toString() + " " +
        DateFormat('MMM').format(DateTime(0, updateDate!.month));
  }

  String getCompactTitle() {
    if (title.length < 30) {
      return title;
    }
    return title.substring(0, 27) + "...";
  }
}

