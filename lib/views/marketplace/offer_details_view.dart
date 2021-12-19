import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/offer.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/button/button.dart';
import 'package:mca_leads_management_mobile/widgets/card/card_widget.dart';
import 'package:mca_leads_management_mobile/widgets/dialog/price_offer_dialog.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class OfferDetailView extends StatefulWidget {
  final LeadViewArguments args;
  static String routeName = '/home/offer';

  const OfferDetailView({Key? key, required this.args}) : super(key: key);

  @override
  _OfferDetailViewState createState() => _OfferDetailViewState();
}

class _OfferDetailViewState extends State<OfferDetailView> {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  late CustomTheme customTheme;
  late ThemeData theme;
  late List<Offer>? offers;
  late Future<List<Offer>> offersFuture;
  late LogicalView logicalView;

  Future<void> _getOffers(String listingId, LogicalView logicalView) async {
    offersFuture = MarketplaceInterface().getOffers(listingId);
    offersFuture.whenComplete(() => setState(() {}));
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    _getOffers(widget.args.id, widget.args.logicalView);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getOffers(widget.args.id, widget.args.logicalView);
    logicalView = widget.args.logicalView;
  }

  bool isAcceptable(OfferState offerState) {
    if (offerState == OfferState.BUYER_ACCEPTED ||
        offerState == OfferState.BUYER_REJECTED ||
        offerState == OfferState.SELLER_ACCEPTED ||
        offerState == OfferState.SELLER_REJECTED ||
        offerState == OfferState.EXPIRED) {
      return false;
    }
    if (offerState == OfferState.BUYER_OFFER &&
        logicalView == LogicalView.sentOffer) {
      return false;
    }
    if (offerState == OfferState.SELLER_OFFER &&
        logicalView == LogicalView.receivedOffer) {
      return false;
    }
    return true;
  }

  bool isRejectable(OfferState offerState) {
    if (offerState == OfferState.BUYER_ACCEPTED ||
        offerState == OfferState.BUYER_ACCEPTED ||
        offerState == OfferState.SELLER_ACCEPTED ||
        offerState == OfferState.SELLER_REJECTED ||
        offerState == OfferState.EXPIRED) {
      return false;
    }
    return true;
  }

  String _getTitle(Offer offer) {
    switch (offer.state) {
      case OfferState.BUYER_OFFER:
        return "${oCcy.format(offer.buyerOfferPrice)} Offer ";
      case OfferState.SELLER_OFFER:
        return "${oCcy.format(offer.sellerOfferPrice)} Counter Offer";
      case OfferState.BUYER_ACCEPTED:
      case OfferState.SELLER_ACCEPTED:
        return "Accepted Offer";
      case OfferState.BUYER_REJECTED:
      case OfferState.SELLER_REJECTED:
        return "Rejected Offer";
      case OfferState.EXPIRED:
        return "Expired Offer";
    }
  }

  String _getTitleColor(Offer offer) {
    switch (offer.state) {
      case OfferState.BUYER_OFFER:
        return "${oCcy.format(offer.buyerOfferPrice)} Offer ";
      case OfferState.SELLER_OFFER:
        return "${oCcy.format(offer.sellerOfferPrice)} Counter Offer";
      case OfferState.BUYER_ACCEPTED:
      case OfferState.SELLER_ACCEPTED:
        return "Accepted Offer";
      case OfferState.BUYER_REJECTED:
      case OfferState.SELLER_REJECTED:
        return "Rejected Offer";
      case OfferState.EXPIRED:
        return "Expired Offer";
    }
  }

  Widget _buildItemList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
          itemCount: offers!.length,
          itemBuilder: (context, index) {
            return Ink(
              child: Column(
                children: [
                  Container(height: 16),
                  FxCard(
                    margin: FxSpacing.fromLTRB(8, 0, 8, 0),
                    color: offers![index].state.getBackgroundColor(logicalView),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FxText.h6(
                          _getTitle(offers![index]),
                          color: offers![index].state.getTitleColor(logicalView),
                          fontWeight: 600,
                          xMuted: true,
                        ),
                        Divider(),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FxText.b2(
                                "Last Seller Price: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              oCcy.format(offers![index].sellerOfferPrice),
                              fontWeight: 800,
                              color: Colors.black,
                              xMuted: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FxText.b2(
                                "Initial Seller Price: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              oCcy.format(offers![index].initialOfferPrice),
                              fontWeight: 800,
                              color: Colors.black,
                              xMuted: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FxText.b2(
                                "Offer put at: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              DateFormat('EEE, MMM d hh:mm')
                                  .format(offers![index].lastModifiedTime),
                              fontWeight: 800,
                              color: Colors.black,
                              xMuted: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FxText.b2(
                                "Offer expires at: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              DateFormat('EEE, MMM d hh:mm')
                                  .format(offers![index].expirationTime),
                              fontWeight: 800,
                              color: Colors.black,
                              xMuted: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FxText.b2(
                                "Listing expires at: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              DateFormat('EEE, MMM d hh:mm')
                                  .format(offers![index].listingExpirationTime),
                              fontWeight: 800,
                              color: Colors.black,
                              xMuted: true,
                            ),
                          ],
                        ),
                        const Divider(
                          height: 16,
                        ),
                        _buildActionRow(offers![index]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(
                height: 0.5,
                color: theme.dividerColor,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: offersFuture,
        builder: (context, AsyncSnapshot<List<Offer>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
          offers = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: lightColor.secondary,
                leading: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    FeatherIcons.chevronLeft,
                    size: 20,
                    color: theme.backgroundColor,
                  ),
                ),
                title: Column(
                  children: [
                    FxText.sh1(
                      widget.args.logicalView.getName(),
                      fontWeight: 500,
                      color: theme.backgroundColor,
                    ),
                    FxText.sh2(
                      widget.args.title,
                      fontWeight: 300,
                      color: theme.backgroundColor,
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: lightColor.secondaryVariant,
                onPressed: _onRefresh,
                child: const Icon(Icons.refresh),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: _buildItemList(),
                  ),
                ],
              ));
        });
  }

  Widget _buildActionRow(Offer offer) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isAcceptable(offer.state)
            ? FxButton.rounded(
                onPressed: () {
                  Navigator.pop(context);
                  MarketplaceInterface().acceptOffer(offer.id, offer.listingId);
                },
                child: const Icon(Icons.check, color: Colors.green),
                backgroundColor: theme.backgroundColor,
              )
            : Container(width: 48),
        isRejectable(offer.state)
            ? FxButton.rounded(
                onPressed: () {
                  Navigator.pop(context);
                  MarketplaceInterface().rejectOffer(offer.id, offer.listingId);
                },
                child: const Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                backgroundColor: theme.backgroundColor,
              )
            : Container(width: 48),
        isRejectable(offer.state)
            ? FxButton.rounded(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => OfferPriceDialog(
                            onSubmit: (offerRequest) {
                              offerRequest.listingId = offer.listingId;
                              offerRequest.offerId = offer.id;
                              offerRequest.expirationTime =
                                  offer.listingExpirationTime;
                              MarketplaceInterface().counterOffer(offerRequest);
                              _getOffers(offer.listingId, logicalView);
                              setState(() {});
                            },
                          ));
                },
                child: Icon(
                  Icons.sell,
                  color: theme.primaryColor,
                ),
                backgroundColor: theme.backgroundColor)
            : Container(width: 48),
        FxButton.rounded(
            onPressed: () {},
            child: Icon(
              Icons.history,
              color: theme.primaryColor,
            ),
            backgroundColor: theme.backgroundColor),
      ],
    );
  }
}
