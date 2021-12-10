import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/dialog/price_offer_dialog.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class MarketListingDetailView extends StatefulWidget {
  final LeadViewArguments args;
  static String routeName = '/home/marketplace-listing';

  const MarketListingDetailView({Key? key, required this.args}) : super(key: key);

  @override
  _MarketListingDetailViewState createState() => _MarketListingDetailViewState();
}

class _MarketListingDetailViewState extends State<MarketListingDetailView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late GetListingResponse? listingInfo;
  late Future<GetListingResponse> listingInfoFuture;
  final regionController = TextEditingController();

  late List<String> inspectors = [];
  late String inspector;
  late int inspectionTime;
  late DateTime scheduleDate;
  late TimeOfDay scheduleTime;
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
              title: FxText.sh1(
                'Marketplace Listing Detail',
                fontWeight: 600,
                color: theme.backgroundColor,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: lightColor.primary,
              selectedItemColor: Colors.white.withOpacity(.80),
              unselectedItemColor: Colors.white.withOpacity(.80),
              onTap: (value) {
                if (value == 1) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => OfferPriceDialog(
                        onSubmit: (text){
                          MarketplaceInterface().submitOffer(listingInfo!.listing.id, int.parse(text));
                        },));

                } else {
                  Navigator.pop(context);
                }
                setState(() =>
                _currentIndex = value); // Respond to item press.
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Buy',
                  icon: Icon(Icons.thumb_up),
                ),
                BottomNavigationBarItem(
                  label: 'Offer',
                  icon: Icon(Icons.local_offer),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: FxSpacing.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 16),
                        child: FxText.sh1(listingInfo!.vehicle.ymmt, fontWeight: 700)
                    ),
                    ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _panelsExpansionStatus[index] = !isExpanded;
                        });
                      },
                      animationDuration: const Duration(
                          milliseconds: 500),
                      children: [
                        ExpansionPanel(
                            backgroundColor: Colors.grey[100],
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: FxText.b1("Vehicle Information",
                                    color: isExpanded
                                        ? lightColor.primary
                                        : theme.colorScheme.onBackground,
                                    fontWeight: isExpanded ? 700 : 600),
                              );
                            },
                            body: Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        initialValue: listingInfo!.vehicle.vin,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: "VIN",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder: theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(
                                              Icons.confirmation_number_outlined,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: listingInfo!.vehicle.ymmt,
                                        decoration: InputDecoration(
                                          labelText: "Title",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(
                                              Icons.confirmation_number_outlined,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: listingInfo!.vehicle.color,
                                        decoration: InputDecoration(
                                          labelText: "Color",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon:
                                          const Icon(Icons.color_lens_outlined, size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: listingInfo!.vehicle.mileage.toString(),
                                        decoration: InputDecoration(
                                          labelText: "Mileage",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.speed,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: "3.5", //listingInfo!.vehicle.estimatedCr.toString(),
                                        decoration: InputDecoration(
                                          labelText: "Estimated CR",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.high_quality,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                            isExpanded: _panelsExpansionStatus[0]),
                        ExpansionPanel(
                            backgroundColor: Colors.grey[100],
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: FxText.b1("Listing Information",
                                    color: isExpanded
                                        ? lightColor.primary
                                        : theme.colorScheme.onBackground,
                                    fontWeight: isExpanded ? 700 : 600),
                              );
                            },
                            body: Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: listingInfo!.listing.initialOfferPrice.toString(),
                                        decoration: InputDecoration(
                                          labelText: "Listing Price",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.list,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: DateFormat('yyyy-MM-dd').format(listingInfo!.listing.expirationTime),
                                        decoration: InputDecoration(
                                          labelText: "Valid by:",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.price_change,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                            isExpanded: _panelsExpansionStatus[1]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: 80,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton.icon(
                      label: FxText.sh1('Buy'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.sell,
                          size: 32,
                          color: theme.colorScheme.primaryVariant
                              .withAlpha(220)),
                    ),
                    TextButton.icon(
                      label: FxText.sh1('Offer'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => OfferPriceDialog(
                            onSubmit: (text){
                              MarketplaceInterface().submitOffer(listingInfo!.listing.id, int.parse(text));
                            },));
                      },
                      icon: Icon(Icons.thumb_up_alt,
                          size: 32,
                          color: theme.colorScheme.primaryVariant
                              .withAlpha(220)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
