import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';

part 'offer.g.dart';

enum OfferState {
  BUYER_OFFER,
  SELLER_OFFER,
  BUYER_ACCEPTED,
  SELLER_ACCEPTED,
  BUYER_REJECTED,
  SELLER_REJECTED,
  EXPIRED
}

extension OfferStateExt on OfferState {
  getName() => toString().substring(toString().indexOf(".") + 1);

  getTitle() {
    switch (this) {
      case OfferState.BUYER_OFFER:
        return "Last offer from Buyer";
      case OfferState.SELLER_OFFER:
        return "Last Counter Offer from Seller";
      case OfferState.BUYER_ACCEPTED:
        return "Buyer Accepted Counter an Offer";
      case OfferState.SELLER_ACCEPTED:
        return "Buyer Accepted an Offer";
      case OfferState.BUYER_REJECTED:
        return "Buyer Rejected Counter an Offer";
      case OfferState.SELLER_REJECTED:
        return "Seller Rejected Counter an Offer";
      case OfferState.EXPIRED:
        return "Offer is Expired";
    }
  }

  String getAbbrv() {
    switch (this) {
      case OfferState.BUYER_OFFER:
        return "BO";
      case OfferState.SELLER_OFFER:
        return "SO";
      case OfferState.BUYER_ACCEPTED:
        return "BA";
      case OfferState.SELLER_ACCEPTED:
        return "SA";
      case OfferState.BUYER_REJECTED:
        return "BR";
      case OfferState.SELLER_REJECTED:
        return "SR";
      case OfferState.EXPIRED:
        return "EX";
    }
  }

  Color getBackgroundColor(LogicalView logicalView) {
    switch (this) {
      case OfferState.BUYER_OFFER:
        if (logicalView == LogicalView.sentOffer) {
          return darkColor.primary;
        } else {
          return darkColor.primaryVariant;
        }
      case OfferState.SELLER_OFFER:
        if (logicalView == LogicalView.receivedOffer) {
          return darkColor.primary;
        } else {
          return darkColor.primaryVariant;
        }
      case OfferState.BUYER_ACCEPTED:
      case OfferState.SELLER_ACCEPTED:
        return darkColor.secondary;
      case OfferState.BUYER_REJECTED:
      case OfferState.SELLER_REJECTED:
      case OfferState.EXPIRED:
        return darkColor.secondaryVariant;
    }
  }

  Color getTitleColor(LogicalView logicalView) {
    switch (this) {
      case OfferState.BUYER_OFFER:
      case OfferState.SELLER_OFFER:
        return Colors.white54;
      case OfferState.BUYER_ACCEPTED:
      case OfferState.SELLER_ACCEPTED:
      case OfferState.BUYER_REJECTED:
      case OfferState.SELLER_REJECTED:
      case OfferState.EXPIRED:
      return Colors.black45;
    }
  }

  Color getForegroundColor() {
    switch (this) {
      case OfferState.BUYER_OFFER:
      case OfferState.SELLER_OFFER:
        return const Color.fromARGB(255, 44, 121, 244);
      case OfferState.BUYER_ACCEPTED:
      case OfferState.SELLER_ACCEPTED:
        return const Color.fromARGB(255, 50, 175, 84);
      case OfferState.BUYER_REJECTED:
      case OfferState.SELLER_REJECTED:
      case OfferState.EXPIRED:
        return const Color.fromARGB(255, 245, 45, 59);
    }
  }
}

@JsonSerializable()
class Offer {
  String id;
  String sellerId;
  String buyerId;
  String listingId;
  OfferState state;
  int initialOfferPrice;
  int sellerOfferPrice;
  int buyerOfferPrice;
  DateTime createdTime;
  DateTime lastModifiedTime;
  DateTime expirationTime;
  DateTime listingExpirationTime;

  Offer(
      this.id,
      this.sellerId,
      this.buyerId,
      this.listingId,
      this.state,
      this.initialOfferPrice,
      this.sellerOfferPrice,
      this.buyerOfferPrice,
      this.createdTime,
      this.lastModifiedTime,
      this.expirationTime,
      this.listingExpirationTime);

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
