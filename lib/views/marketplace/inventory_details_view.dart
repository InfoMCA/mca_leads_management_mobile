import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/inventory.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/vehicle.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/views/marketplace/listing_new_request_dialog.dart';
import 'package:mca_leads_management_mobile/views/marketplace/listing_request_view.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class InventoryDetailView extends StatefulWidget {
  final LeadViewArguments args;
  static String routeName = '/home/inventory';

  const InventoryDetailView({Key? key, required this.args}) : super(key: key);

  @override
  _InventoryDetailViewState createState() => _InventoryDetailViewState();
}

class _InventoryDetailViewState extends State<InventoryDetailView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late InventoryVehicle? inventoryVehicle;
  late InventoryItem inventoryItem;
  late Vehicle vehicle;
  late Future<InventoryVehicle?> inventoryVehicleFuture;

  var _currentIndex = 0;

  final _panelsExpansionStatus = [false, false, false, false];

  Future<void> _getInventoryVehicle(String inventoryId) async {
    inventoryVehicleFuture =
        MarketplaceInterface().getInventoryVehicle(inventoryId);
    inventoryVehicleFuture.whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getInventoryVehicle(widget.args.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: inventoryVehicleFuture,
        builder: (context, AsyncSnapshot<InventoryVehicle?> snapshot) {
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
          inventoryVehicle = snapshot.data;
          inventoryItem = inventoryVehicle!.inventoryItem;
          vehicle = inventoryVehicle!.vehicle;
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
                'Inventory Details',
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
                if (value == 0) {
                  if (inventoryItem.state == InventoryItemState.ACTIVE) {
                    MarketplaceInterface().getMarketPlaces().then((
                        marketplaces) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              ListingNewDialog(
                                onSubmit: (listingNewReq) {
                                  MarketplaceInterface().createNewListing(
                                      vehicle.id, inventoryItem.id,
                                      listingNewReq);
                                },
                                initOfferPrice: inventoryItem.purchasedPrice
                                    .toInt(),
                                marketplaces: marketplaces,
                              ));
                    });
                  } else {
                    showSnackBar(context: context,
                        text: "You can't put this vehicle in marketplace");
                  }
                }

                setState(() =>
                _currentIndex = value); // Respond to item press.
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'MarketPlace',
                  icon: Icon(Icons.storefront),
                ),
                BottomNavigationBarItem(
                  label: 'Transfer',
                  icon: Icon(Icons.emoji_transportation),
                ),
                BottomNavigationBarItem(
                  label: 'Sold',
                  icon: Icon(Icons.sell),
                )
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
                        child: FxText.sh1(vehicle.ymmt, fontWeight: 700)
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
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: vehicle.vin,
                                        decoration: InputDecoration(
                                          labelText: "VIN",
                                          border: theme
                                              .inputDecorationTheme
                                              .border,
                                          enabledBorder: theme
                                              .inputDecorationTheme
                                              .border,
                                          focusedBorder:
                                          theme.inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                              Icons
                                                  .confirmation_number_outlined,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: vehicle.color,
                                        decoration: InputDecoration(
                                          labelText: "Color",
                                          border: theme
                                              .inputDecorationTheme
                                              .border,
                                          enabledBorder:
                                          theme.inputDecorationTheme
                                              .border,
                                          focusedBorder:
                                          theme.inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                              Icons.color_lens_outlined,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: vehicle.mileage
                                            .toString(),
                                        decoration: InputDecoration(
                                          labelText: "Mileage",
                                          border: theme
                                              .inputDecorationTheme
                                              .border,
                                          enabledBorder:
                                          theme.inputDecorationTheme
                                              .border,
                                          focusedBorder:
                                          theme.inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.speed,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: vehicle.estimatedCr
                                            .toString(),
                                        decoration: InputDecoration(
                                          labelText: "Estimated CR",
                                          border: theme
                                              .inputDecorationTheme
                                              .border,
                                          enabledBorder:
                                          theme.inputDecorationTheme
                                              .border,
                                          focusedBorder:
                                          theme.inputDecorationTheme
                                              .focusedBorder,
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
                                title: FxText.b1("Price Information",
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
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: vehicle.askingPrice
                                            .toString(),
                                        decoration: InputDecoration(
                                          labelText: "Listing Price",
                                          border: theme
                                              .inputDecorationTheme
                                              .border,
                                          enabledBorder:
                                          theme.inputDecorationTheme
                                              .border,
                                          focusedBorder:
                                          theme.inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.list,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: vehicle.mmr.toString(),
                                        decoration: InputDecoration(
                                          labelText: "MMR",
                                          border: theme
                                              .inputDecorationTheme
                                              .border,
                                          enabledBorder:
                                          theme.inputDecorationTheme
                                              .border,
                                          focusedBorder:
                                          theme.inputDecorationTheme
                                              .focusedBorder,
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
                        ExpansionPanel(
                            backgroundColor: Colors.grey[100],
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: FxText.b1("Purchase Information",
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
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: (inventoryItem
                                            .purchasedPrice -
                                            inventoryItem.deductionsAmount)
                                            .toString(),
                                        decoration: InputDecoration(
                                          labelText: "Purchased Price",
                                          border: theme.inputDecorationTheme
                                              .border,
                                          enabledBorder: theme
                                              .inputDecorationTheme.border,
                                          focusedBorder: theme
                                              .inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.price_change,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: inventoryItem.lenderAmount
                                            .toString(),
                                        decoration: InputDecoration(
                                          labelText: "Lender Amount",
                                          border: theme.inputDecorationTheme
                                              .border,
                                          enabledBorder: theme
                                              .inputDecorationTheme.border,
                                          focusedBorder: theme
                                              .inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.price_change,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: inventoryItem
                                            .withholdingAmount.toString(),
                                        decoration: InputDecoration(
                                          labelText: "Withholding",
                                          border: theme.inputDecorationTheme
                                              .border,
                                          enabledBorder: theme
                                              .inputDecorationTheme.border,
                                          focusedBorder: theme
                                              .inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.price_change,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: inventoryItem
                                            .customerAmount.toString(),
                                        decoration: InputDecoration(
                                          labelText: "Customer Check",
                                          border: theme.inputDecorationTheme
                                              .border,
                                          enabledBorder: theme
                                              .inputDecorationTheme.border,
                                          focusedBorder: theme
                                              .inputDecorationTheme
                                              .focusedBorder,
                                          prefixIcon: const Icon(
                                            Icons.price_change,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                            isExpanded: _panelsExpansionStatus[2]),
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
                      label: FxText.sh1('MarketPlace', fontSize: 14,),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          ListingRequestView.routeName,
                          arguments: inventoryVehicle,
                        );
                      },
                      icon: Icon(Icons.storefront,
                          size: 20,
                          color: theme.colorScheme.primaryVariant
                              .withAlpha(220)),
                    ),
                    TextButton.icon(
                      label: FxText.sh1('Transfer', fontSize: 14,),
                      onPressed: () {},
                      icon: Icon(Icons.emoji_transportation,
                          size: 20,
                          color: theme.colorScheme.primaryVariant
                              .withAlpha(220)),
                    ),
                    TextButton.icon(
                      label: FxText.sh1('Sold', fontSize: 14,),
                      onPressed: () {},
                      icon: Icon(Icons.sell,
                          size: 20,
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
