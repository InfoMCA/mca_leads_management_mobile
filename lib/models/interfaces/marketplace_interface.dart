import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/inventory.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/offer.dart';
import 'package:mca_leads_management_mobile/models/interfaces/rest_api_interface.dart';

class MarketplaceInterface extends RestAPIInterface {
  MarketplaceInterface() : super(CommandObject.inventory);

  Future<GetInventoryResponse> getInventories() async {
    Response response =
        await sendGetReq("/inventory?dealerId=" + currentUser!.username);
    return GetInventoryResponse.fromJson(response.data);
  }

  Future<List<LeadSummary>> getInventoriesSummary() async {
    Response response =
        await sendGetReq("/inventory/summary?userId=" + currentUser!.username);
    GetInventorySummaryResponse inventorySummaryResponse =
        GetInventorySummaryResponse.fromJson(response.data);
    return inventorySummaryResponse.inventorySummary
        .map((e) => LeadSummary(
            e.inventoryItemSummary.id,
            e.inventoryItemSummary.vehicleId,
            e.vehicleSummary.ymmt,
            e.vehicleSummary.vin,
            e.inventoryItemSummary.state.getViewTag(),
            e.inventoryItemSummary.purchaseDate ?? DateTime.now()))
        .toList();
  }

  Future<InventoryVehicle> getInventoryVehicle(String inventoryId) async {
    Response response = await sendGetReq("/inventory/item?id=$inventoryId");
    return InventoryVehicle.fromJson(response.data);
  }

  Future<GetListingsResponse> getListings() async {
    Response response =
        await sendGetReq("/listing/all/user?id=" + currentUser!.username);
    return GetListingsResponse.fromJson(response.data);
  }

  Future<List<LeadSummary>> getListingsSummary() async {
    Response response = await sendGetReq("/listing/all/summary"
            "?states=" +
        ListingState.ACTIVE.getName());

    List<LeadSummary> leadSummaries =
        GetListingsSummaryResponse.fromJson(response.data)
            .listingSummary
            .map((e) => LeadSummary(
                e.listing.id,
                e.listing.vehicleId,
                e.vehicleSummary.ymmt,
                e.vehicleSummary.vin,
                e.listing.sellerId == currentUser!.dealerId
                    ? LeadViewTag.ownership
                    : e.inventoryItemSummary.state.getViewTag(),
                e.listing.expirationTime))
            .toList();
    return leadSummaries;
  }

  Future<List<LeadSummary>> getListingsReceivedOffer() async {
    Response response = await sendGetReq("/listing/seller?userId=" +
        currentUser!.username +
        "&states=" +
        ListingState.ACTIVE.getName());

    List<LeadSummary> leadSummaries =
        GetListingsResponse.fromJson(response.data)
            .listings
            .where((element) => element.listing.offerCount != 0)
            .map((e) => LeadSummary(
                e.listing.id,
                e.listing.vehicleId,
                e.vehicle.ymmt,
                e.vehicle.vin,
                LeadViewTag.listing,
                e.listing.expirationTime))
            .toList();
    return leadSummaries;
  }

  Future<List<LeadSummary>> getListingsSentOffer() async {
    String states = [
      OfferState.BUYER_OFFER,
      OfferState.SELLER_REJECTED,
      OfferState.SELLER_OFFER
    ].map((e) => e.getName()).join(",");
    Response response = await sendGetReq(
        "/listing/buyer?userId=" + currentUser!.username + "&states=" + states);

    List<LeadSummary> leadSummaries =
        GetListingsResponse.fromJson(response.data)
            .listings
            .map((e) => LeadSummary(
                e.listing.id,
                e.listing.vehicleId,
                e.vehicle.ymmt,
                e.vehicle.vin,
                LeadViewTag.listing,
                e.listing.expirationTime))
            .toList();
    return leadSummaries;
  }

  Future<List<Offer>> getOffers(String listingId) async {
    Response response =
        await sendGetReq("/offers/listing?listingId=" + listingId);
    return GetOffersResponse.fromJson(response.data).offers;
  }

  Future<List<LeadSummary>> getOffersSummary() async {
    Response response =
        await sendGetReq("/offers/summary?listingId=" + currentUser!.username);
    return [];
  }

  Future<GetInventoryVehicleResponse> getInventory(String inventoryId) async {
    Response response = await sendGetReq("/inventory/item?id=" + inventoryId);
    return GetInventoryVehicleResponse.fromJson(response.data);
  }

  Future<GetListingResponse> getListing(String listingId) async {
    Response response = await sendGetReq("/listing?id=" + listingId);
    return GetListingResponse.fromJson(response.data);
  }

  void sendSessionToInventory(String sessionId) async {
    sendPostReq(
            "/inventory/from-session?sessionId=$sessionId&dealerId=${currentUser!.dealerId}",
            '')
        .whenComplete(() {
      InventoryItem inventoryItem = InventoryItem(
          sessionId,
          sessionId,
          currentUser!.username,
          0.0,
          0.0,
          0.0,
          0.0,
          0.0,
          InventoryItemState.ACTIVE,
          DateTime.now().toUtc(),
          DateTime.now().toUtc(),
          DateTime.now().toUtc(),
          "",
          0);
      sendPostReq('/inventory/item?userId=' + currentUser!.username,
          json.encode(inventoryItem));
    });
  }

  void createNewListing(
      String vehicleId, String inventoryId, ListingNewReq listingNewReq) {
    Listing listing = Listing(
        "",
        currentUser!.username,
        vehicleId,
        inventoryId,
        ListingState.ACTIVE,
        listingNewReq.offerPrice,
        0,
        0,
        DateTime.now().toUtc(),
        DateTime.now().toUtc(),
        listingNewReq.expirationDate.toUtc());
    sendPostReq(
        '/listing?userId=' + currentUser!.username, json.encode(listing));
  }

  void submitOffer(OfferRequest offerRequest) {
    sendPostReq(
        '/offers?userId=' + currentUser!.username, json.encode(offerRequest));
  }

  void acceptOffer(String offerId, String listingId) {
    sendPatchReq("/offers/accept?userId="
        "${currentUser!.username}&listingId=$listingId&offerId=$offerId");
  }

  void rejectOffer(String offerId, String listingId) {
    sendPatchReq("/offers/reject?userId="
        "${currentUser!.username}&listingId=$listingId&offerId=$offerId");
  }

  void counterOffer(OfferRequest offerRequest) {
    sendPostReq("/offers/counter/", json.encode(offerRequest));
  }
}
