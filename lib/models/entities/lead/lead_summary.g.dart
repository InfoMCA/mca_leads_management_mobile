// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadSummary _$LeadSummaryFromJson(Map<String, dynamic> json) => LeadSummary(
      json['id'] as String,
      json['vehicleId'] as String,
      json['title'] as String,
      json['vin'] as String,
      $enumDecode(_$LeadViewTagEnumMap, json['viewTag']),
      json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
    );

Map<String, dynamic> _$LeadSummaryToJson(LeadSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleId': instance.vehicleId,
      'title': instance.title,
      'vin': instance.vin,
      'viewTag': _$LeadViewTagEnumMap[instance.viewTag],
      'updateDate': instance.updateDate?.toIso8601String(),
    };

const _$LeadViewTagEnumMap = {
  LeadViewTag.callerReady: 'callerReady',
  LeadViewTag.callerFollowUp: 'callerFollowUp',
  LeadViewTag.callerDenied: 'callerDenied',
  LeadViewTag.callerLost: 'callerLost',
  LeadViewTag.approvalBuyNow: 'approvalBuyNow',
  LeadViewTag.approvalAuction: 'approvalAuction',
  LeadViewTag.approvalDealMade: 'approvalDealMade',
  LeadViewTag.approvalPotentialDeal: 'approvalPotentialDeal',
  LeadViewTag.followUpBuyNow: 'followUpBuyNow',
  LeadViewTag.followUpAuction: 'followUpAuction',
  LeadViewTag.followUpAppraisal: 'followUpAppraisal',
  LeadViewTag.appraisal: 'appraisal',
  LeadViewTag.ready: 'ready',
  LeadViewTag.activeProgress: 'activeProgress',
  LeadViewTag.activePendingApproval: 'activePendingApproval',
  LeadViewTag.approved: 'approved',
  LeadViewTag.rejected: 'rejected',
  LeadViewTag.complete: 'complete',
  LeadViewTag.inventory: 'inventory',
  LeadViewTag.listing: 'listing',
  LeadViewTag.transferIn: 'transferIn',
  LeadViewTag.transferOut: 'transferOut',
  LeadViewTag.ownership: 'ownership',
};
