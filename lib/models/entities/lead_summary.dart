import 'package:flutter/material.dart';
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
  complete
}

extension LeadViewTagExt on LeadViewTag {
  String getAbbrv() {
    switch (this) {
      case LeadViewTag.approvalBuyNow:
      case LeadViewTag.followUpBuyNow:
        return "B";
      case LeadViewTag.approvalAuction:
      case LeadViewTag.followUpAuction:
      case LeadViewTag.appraisal:
        return "A";
      case LeadViewTag.approvalDealMade:
        return "D";
      case LeadViewTag.approvalPotentialDeal:
      case LeadViewTag.followUpAppraisal:
        return "P";
      case LeadViewTag.ready:
        return "D";
      case LeadViewTag.activeProgress:
        return "P";
      case LeadViewTag.activePendingApproval:
      case LeadViewTag.complete:
        return "C";
      case LeadViewTag.approved:
        return "A";
      case LeadViewTag.rejected:
        return "R";
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
        return const Color.fromARGB(255, 255, 236, 235);
      case LeadViewTag.approvalDealMade:
      case LeadViewTag.followUpAppraisal:
      case LeadViewTag.appraisal:
      case LeadViewTag.ready:
      case LeadViewTag.activeProgress:
      case LeadViewTag.approved:
        return const Color.fromARGB(255, 234, 241, 254);
      case LeadViewTag.approvalPotentialDeal:
      case LeadViewTag.complete:
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
        return const Color.fromARGB(255, 245, 45, 59);
      case LeadViewTag.approvalDealMade:
      case LeadViewTag.followUpAppraisal:
      case LeadViewTag.appraisal:
      case LeadViewTag.ready:
      case LeadViewTag.activeProgress:
      case LeadViewTag.approved:
        return const Color.fromARGB(255, 44, 121, 244);
      case LeadViewTag.approvalPotentialDeal:
      case LeadViewTag.complete:
        return const Color.fromARGB(255, 50, 175, 84);
    }
  }
}

@JsonSerializable()
class LeadSummary {
  LeadSummary(this.id, this.title, this.vin, this.viewTag);

  String id;
  String title;
  String vin;
  LeadViewTag viewTag;

  factory LeadSummary.fromJson(Map<String, dynamic> json) =>
      _$LeadSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$LeadSummaryToJson(this);
}
