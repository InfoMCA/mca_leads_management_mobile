// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadSummary _$LeadSummaryFromJson(Map<String, dynamic> json) => LeadSummary(
      json['id'] as String,
      json['title'] as String,
      json['vin'] as String,
      $enumDecode(_$LeadViewTagEnumMap, json['viewTag']),
    );

Map<String, dynamic> _$LeadSummaryToJson(LeadSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'vin': instance.vin,
      'viewTag': _$LeadViewTagEnumMap[instance.viewTag],
    };

const _$LeadViewTagEnumMap = {
  LeadViewTag.approvalBuyNow: 'APPROVAL_BUY_NOW',
  LeadViewTag.approvalAuction: 'APPROVAL_AUCTION',
  LeadViewTag.approvalDealMade: 'APPROVAL_DEAL_MADE',
  LeadViewTag.approvalPotentialDeal: 'APPROVAL_POTENTIAL_DEAL',
  LeadViewTag.followUpBuyNow: 'FOLLOW_UP_BUY_NOW',
  LeadViewTag.followUpAuction: 'FOLLOW_UP_AUCTION',
  LeadViewTag.followUpAppraisal: 'FOLLOW_UP_APPRAISAL',
  LeadViewTag.appraisal: 'APPRAISAL',
  LeadViewTag.ready: 'READY',
  LeadViewTag.activeProgress: 'ACTIVE_IN_PROGRESS',
  LeadViewTag.activePendingApproval: 'ACTIVE_PENDING_APPROVAL',
  LeadViewTag.approved: 'APPROVED',
  LeadViewTag.complete: 'COMPLETE',
  LeadViewTag.rejected: 'REJECTED',
};
