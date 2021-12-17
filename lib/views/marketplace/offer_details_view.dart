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

  bool isOfferAcceptable(OfferState offerState) {
    if (offerState == OfferState.BUYER_ACCEPTED ||
        offerState == OfferState.BUYER_REJECTED ||
        offerState == OfferState.SELLER_ACCEPTED ||
        offerState == OfferState.BUYER_REJECTED) {
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
                          offers![index].state.getTitle(),
                          fontWeight: 600,
                          color: lightColor.primary,
                          xMuted: true,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: FxText.b2(
                                "Buyer: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              offers![index].buyerId,
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
                                "Seller: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              offers![index].sellerId,
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
                                "Offer: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              oCcy.format(offers![index].buyerOfferPrice),
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
                              DateFormat.yMMMd()
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
                                "Listing expires at: ",
                                fontWeight: 700,
                                color: Colors.black,
                                xMuted: true,
                              ),
                            ),
                            FxText.b2(
                              DateFormat.yMMMd()
                                  .format(offers![index].expirationTime),
                              fontWeight: 800,
                              color: Colors.black,
                              xMuted: true,
                            ),
                          ],
                        ),
                        const Divider(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FxButton.rounded(
                              onPressed: () {
                                if (isOfferAcceptable(offers![index].state)) {
                                  Navigator.pop(context);
                                  MarketplaceInterface().acceptOffer(
                                      offers![index].id,
                                      offers![index].listingId);
                                }
                              },
                              child: Icon(Icons.check,
                                  color: isOfferAcceptable(offers![index].state)
                                      ? Colors.green
                                      : Colors.grey),
                              backgroundColor: theme.backgroundColor,
                            ),
                            FxButton.rounded(
                              onPressed: () {
                                Navigator.pop(context);
                                MarketplaceInterface().rejectOffer(
                                    offers![index].id,
                                    offers![index].listingId);
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                              backgroundColor: theme.backgroundColor,
                            ),
                            FxButton.rounded(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          OfferPriceDialog(
                                            onSubmit: (text) {
                                              MarketplaceInterface()
                                                  .counterOffer(
                                                      offers![index].id,
                                                      offers![index].listingId,
                                                      int.parse(text));
                                              _getOffers(
                                                  offers![index].listingId,
                                                  logicalView);
                                              setState(() {});
                                            },
                                          ));
                                },
                                child: Icon(
                                  Icons.sell,
                                  color: theme.primaryColor,
                                ),
                                backgroundColor: theme.backgroundColor),
                            FxButton.rounded(
                                onPressed: () {},
                                child: Icon(
                                  Icons.history,
                                  color: theme.primaryColor,
                                ),
                                backgroundColor: theme.backgroundColor),
                          ],
                        )
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
              body: Column(
                children: [
                  Expanded(
                    child: _buildItemList(),
                  ),
                ],
              ));
        });
  }
}
