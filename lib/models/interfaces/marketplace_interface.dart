import 'dart:developer' as dev;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_req.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/inventory.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/marketplace.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/offer.dart';

class MarketplaceInterface {
  final String marketplaceEndpoint = dotenv
      .env['API_MARKETPLACE_APP_REQUEST'] ?? "";

  Dio dio = Dio();

  Future<Response> sendGetReq(String path) async {
    try {
      dev.log("Get Req:" + path);
      Response response = await dio.get(marketplaceEndpoint + path);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw ("Error code: ${response.statusCode}");
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }

  Future<Response> sendPatchReq(String path) async {
    try {
      Response response = await dio.patch(marketplaceEndpoint + path);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw ("Error code: ${response.statusCode}");
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }

  Future<Response> sendPostReq(String path, String data) async {
    try {
      dev.log("Path: $path");
      dev.log(data);
      Response response = await dio.post(
          marketplaceEndpoint + path, data: data);
      if (response.statusCode == HttpStatus.ok) {
        return response;
      }
      throw ("Error code: ${response.statusCode}");
    } catch (e, s) {
      dev.log('Get Leads Error:' + e.toString(), stackTrace: s);
      throw (e.toString());
    }
  }

  Future<GetInventoryResponse> getInventories() async {
    Response response = await sendGetReq(
        "inventory?dealerId=" + currentUser!.username);
    return GetInventoryResponse.fromJson(response.data);
  }

  Future<List<LeadSummary>> getInventoriesSummary() async {
    Response response = await sendGetReq(
        "inventory/summary?userId=" + currentUser!.username);
    GetInventorySummaryResponse inventorySummaryResponse = GetInventorySummaryResponse.fromJson(
        response.data);
    dev.log(inventorySummaryResponse.toJson().toString());
    return inventorySummaryResponse.inventorySummary.map((e) => LeadSummary(
        e.inventoryItemSummary.id, e.inventoryItemSummary.vehicleId, e.vehicleSummary.ymmt, e.vehicleSummary.vin,
        e.inventoryItemSummary.state.getViewTag(), e.inventoryItemSummary.purchaseDate ?? DateTime.now()))
        .toList();
  }

  Future<InventoryVehicle> getInventoryVehicle(String inventoryId) async {
    Response response = await sendGetReq("inventory/item?id=$inventoryId");
    return InventoryVehicle.fromJson(response.data);
  }

  Future<List<Marketplace>> getMarketPlaces() async {
    Response response = await sendGetReq(
        "marketplaces?userId=" + currentUser!.username);
    return GetMarketplacesResponse.fromJson(response.data).marketplaces;
  }

  Future<GetListingsResponse> getListings() async {
    Response response = await sendGetReq(
        "listing/user?id=" + currentUser!.username);
    return GetListingsResponse.fromJson(response.data);
  }

  Future<List<LeadSummary>> getListingsSummary() async {
    /*Response response = await sendGetReq(
        "listing/summary?id=" + currentUser!.username);*/
    Response response = await sendGetReq(
        "listing/user?userId=" + currentUser!.username + "&states=" + ListingState.ACTIVE.getName());

    List<LeadSummary> leadSummaries = GetListingsResponse
        .fromJson(response.data)
        .listings
        .map((e) => LeadSummary(
        e.listing.id, e.listing.vehicleId, e.vehicle.ymmt, e.vehicle.vin, LeadViewTag.listing,
        e.listing.expirationTime))
        .toList();
    return leadSummaries;
  }

  Future<List<LeadSummary>> getListingsReceivedOffer() async {
    /*Response response = await sendGetReq(
        "listing/summary?id=" + currentUser!.username);*/
    Response response = await sendGetReq(
        "listing/seller?userId=" + currentUser!.username + "&states=" + ListingState.ACTIVE.getName());

    List<LeadSummary> leadSummaries = GetListingsResponse
        .fromJson(response.data)
        .listings
        .where((element) => element.listing.offerCount != 0)
        .map((e) =>
        LeadSummary(
            e.listing.id, e.listing.vehicleId, e.vehicle.ymmt, e.vehicle.vin,
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
        "listing/buyer?userId=" + currentUser!.username + "&states=" + states);

    List<LeadSummary> leadSummaries = GetListingsResponse
        .fromJson(response.data)
        .listings
        .map((e) =>
        LeadSummary(
            e.listing.id, e.listing.vehicleId, e.vehicle.ymmt, e.vehicle.vin,
            LeadViewTag.listing,
            e.listing.expirationTime))
        .toList();
    return leadSummaries;
  }

  Future<List<Offer>> getOffers(String listingId) async {
    Response response = await sendGetReq("offers/listing?listingId=" + listingId);
    return GetOffersResponse.fromJson(response.data).offers;
  }

  Future<List<LeadSummary>> getOffersSummary() async {
    Response response = await sendGetReq(
        "offers/summary?listingId=" + currentUser!.username);
    return [];
  }

  Future<GetInventoryVehicleResponse> getInventory(String inventoryId) async {
    Response response = await sendGetReq("inventory/item?id=" + inventoryId);
    return GetInventoryVehicleResponse.fromJson(response.data);
  }

  Future<GetListingResponse> getListing(String listingId) async {
    Response response = await sendGetReq("listing?id=" + listingId);
    return GetListingResponse.fromJson(response.data);
  }

  void sendSessionToInventory(String sessionId) async {
    sendPostReq(
        "vehicles/from-session?sessionId=$sessionId&dealerId=${currentUser!.dealerId}",
        '').whenComplete(() {
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
      sendPostReq('inventory/item?userId=' + currentUser!.username,
          json.encode(inventoryItem));
    });
  }

  void createNewListing(String vehicleId, String inventoryId, ListingNewReq listingNewReq) {
    for (String marketPlace in listingNewReq.marketPlaces) {
      Listing listing = Listing(
          "",
          marketPlace,
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
      sendPostReq('listing?userId=' + currentUser!.username, json.encode(listing));
    }
  }

  void submitOffer(String listingId, int offerPrice) {
    Offer offer = Offer(
        "",
        "",
        "",
        listingId,
        OfferState.BUYER_OFFER,
        0,
        0,
        offerPrice,
        DateTime.now().toUtc(),
        DateTime.now().toUtc(),
        DateTime.now().toUtc());
    sendPostReq('offers?userId=' + currentUser!.username, json.encode(offer));
  }

  void acceptOffer(String offerId, String listingId) {
    sendPatchReq("offers/accept?userId=${currentUser!
        .username}&listingId=$listingId&offerId=$offerId");
  }

  void rejectOffer(String offerId, String listingId) {
    sendPatchReq("offers/reject?userId=${currentUser!
        .username}&listingId=$listingId&offerId=$offerId");

  }

  void counterOffer(String offerId, String listingId, int offerPrice) {
    CounterOfferRequest counterOfferRequest = CounterOfferRequest(currentUser!
        .username, listingId, offerId, offerPrice, DateTime.now().toUtc());
    sendPostReq("offers/counter/", json.encode(counterOfferRequest));
  }
}
