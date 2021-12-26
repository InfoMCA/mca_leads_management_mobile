import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/dialog/price_offer_dialog.dart';
import 'package:mca_leads_management_mobile/widgets/image/ImageCarousel.dart';

class MarketListingDetailView extends StatefulWidget {
  final LeadViewArguments args;
  static String routeName = '/home/marketplace-listing';

  const MarketListingDetailView({Key? key, required this.args})
      : super(key: key);

  @override
  _MarketListingDetailViewState createState() =>
      _MarketListingDetailViewState();
}

class _MarketListingDetailViewState extends State<MarketListingDetailView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late GetListingResponse? listingInfo;
  late Future<GetListingResponse> listingInfoFuture;
  late LeadViewTag viewTag;

  var _currentIndex = 1;
  final _panelsExpansionStatus = [false, true];

  Future<void> _getListingInfo(String listingId) async {
    listingInfoFuture = MarketplaceInterface().getListing(listingId);
    listingInfoFuture.whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getListingInfo(widget.args.id);
    viewTag = widget.args.leadViewTag;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listingInfoFuture,
        builder: (context, AsyncSnapshot<GetListingResponse> snapshot) {
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
          listingInfo = snapshot.data;
          print(listingInfo);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Modular.to.pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                listingInfo!.vehicle.ymmt,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.black,
                  ),
                )
              ],
              backgroundColor: Colors.white,
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Container(
                    color: Color.fromRGBO(119, 147, 246, 1),
                    child: TextButton(
                      onPressed: () {
                        if (viewTag != LeadViewTag.ownership) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  OfferPriceDialog(
                                    onSubmit: (offerRequest) {
                                      offerRequest.listingId =
                                          listingInfo!.listing.id;
                                      offerRequest.offerExpirationTime =
                                          listingInfo!.listing.expirationTime;
                                      MarketplaceInterface()
                                          .submitOffer(offerRequest);
                                    },
                                  ));
                        } else {
                          showSnackBar(
                              context: context,
                              text: "You can't offer for your listed vehicle!",
                              backgroundColor:
                                  lightColor.defaultError.primaryVariant);
                        }
                      },
                      child: Text(
                        "Offer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Container(
                    color: Color.fromRGBO(119, 147, 246, 1),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "BUY",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 10),
                    child: ImageCarousel(
                      [Image.asset("assets/car_pic.png")],
                    ),
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(48, 54, 105, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ListView(children: [
                      getDescriptionRow(Icons.sell_outlined, "Listing Price",
                          listingInfo!.listing.initialOfferPrice.toString()),
                      getDescriptionRow(
                          Icons.calendar_today_outlined,
                          "Listing expires",
                          DateFormat('yyyy-MM-dd')
                              .format(listingInfo!.listing.expirationTime)),
                      getDescriptionRow(Icons.speed, "Odometer",
                          "${listingInfo!.vehicle.mileage} mi"),
                      getDescriptionRow(Icons.local_gas_station_outlined,
                          "Fuel type", "Gas/Electric"),
                      getDescriptionRow(
                          Icons.title, "Title status", "Clean title"),
                      getDescriptionRow(
                          Icons.title, "VIN", listingInfo!.vehicle.vin),
                      getDescriptionRow(Icons.palette_outlined, "Color",
                          listingInfo!.vehicle.color),
                      getDescriptionRow(Icons.title, "Estimated CR",
                          listingInfo!.vehicle.estimatedCr.toString()),
                    ]),
                  ),
                  flex: 3,
                )
              ],
            ),
          );
        });
  }

  Widget getDescriptionRow(IconData icon, String title, String value) {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            VerticalDivider(),
            Container(
              width: 120,
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        Divider(color: Colors.grey),
      ],
    );
  }
}
