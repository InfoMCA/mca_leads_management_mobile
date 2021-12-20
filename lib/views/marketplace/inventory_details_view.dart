import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:mca_leads_management_mobile/models/entities/api/transport/transport_req.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/inventory.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/vehicle.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/views/marketplace/listing_new_request_dialog.dart';
import 'package:mca_leads_management_mobile/views/transport/transport_request_view.dart';
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
  late LeadViewTag viewTag;

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
    viewTag = widget.args.leadViewTag;
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
              backgroundColor: lightColor.secondary,
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
            bottomNavigationBar: _buildActionBar(),
            body: SingleChildScrollView(
              child: Container(
                padding: FxSpacing.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 16),
                        child: FxText.sh1(vehicle.ymmt, fontWeight: 700)),
                    ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _panelsExpansionStatus[index] = !isExpanded;
                        });
                      },
                      animationDuration: const Duration(milliseconds: 500),
                      children: [
                        _buildVehicleInfoPanel(),
                        _buildPriceInfoPanel(),
                        _buildPurchaseInfoPanel(),
                        _buildTradeInfoPanel(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _buildTradeInfoPanel() {
    return ExpansionPanel(
        backgroundColor: Colors.grey[100],
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: FxText.b1("Trade Information",
                color: isExpanded
                    ? lightColor.primary
                    : theme.colorScheme.onBackground,
                fontWeight: isExpanded ? 700 : 600),
          );
        },
        body: (inventoryItem.state == InventoryItemState.TRANSFERRED_OUT ||
                inventoryItem.state == InventoryItemState.TRANSFERRED_IN)
            ? Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: inventoryItem.sellerName,
                      decoration: InputDecoration(
                        labelText: "Seller Name",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(
                          Icons.price_change,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: inventoryItem.buyerName,
                      decoration: InputDecoration(
                        labelText: "Buyer Name",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(
                          Icons.price_change,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: inventoryItem.tradedPrice.toString(),
                      decoration: InputDecoration(
                        labelText: "Traded Price",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(
                          Icons.price_change,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: DateFormat.yMMMd()
                          .format(inventoryItem.tradedTime ?? DateTime.now()),
                      decoration: InputDecoration(
                        labelText: "Traded Date",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(
                          Icons.price_change,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            : Container(),
        isExpanded: _panelsExpansionStatus[3]);
  }

  _buildActionBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightColor.secondary,
      selectedItemColor: Colors.white.withOpacity(.80),
      unselectedItemColor: Colors.white.withOpacity(.80),
      onTap: (value) {
        if (value == 0) {
          if (viewTag == LeadViewTag.inventory) {
            showDialog(
                context: context,
                builder: (BuildContext context) => ListingNewDialog(
                      onSubmit: (listingNewReq) {
                        MarketplaceInterface().createNewListing(
                            vehicle.id, inventoryItem.id, listingNewReq);
                        Navigator.pop(context);
                      },
                      initOfferPrice: inventoryItem.purchasedPrice.toInt(),
                    ));
          } else if (viewTag == LeadViewTag.listing) {
            showSnackBar(
                context: context,
                text: "The vehicle is already in the marketplace",
                backgroundColor: lightColor.defaultError.primaryVariant);
          } else {
            showSnackBar(
                context: context,
                text: "The vehicle is traded. You can't put it in marketplace",
                backgroundColor: lightColor.defaultError.primaryVariant);
          }
        } else if (value == 1) {
          Navigator.pushNamed(context, TransportRequestView.routeName,
              arguments:
                  PutNewOrderRequest.basicInfo(vehicle.vin, vehicle.ymmt));
        } else if (value == 2) {
          showSnackBar(
              context: context,
              text: "This feature is not implemented yet!",
              backgroundColor: lightColor.defaultError.primaryVariant);
        } else {
          Navigator.pop(context);
        }

        setState(() => _currentIndex = value); // Respond to item press.
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
        ),
        BottomNavigationBarItem(
          label: 'Close',
          icon: Icon(Icons.close),
        )
      ],
    );
  }

  _buildVehicleInfoPanel() {
    return ExpansionPanel(
        backgroundColor: Colors.grey[100],
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
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
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: vehicle.vin,
                decoration: InputDecoration(
                  labelText: "VIN",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon:
                      const Icon(Icons.confirmation_number_outlined, size: 24),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: vehicle.color,
                decoration: InputDecoration(
                  labelText: "Color",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(Icons.color_lens_outlined, size: 24),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: vehicle.mileage.toString(),
                decoration: InputDecoration(
                  labelText: "Mileage",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
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
                initialValue: vehicle.estimatedCr.toString(),
                decoration: InputDecoration(
                  labelText: "Estimated CR",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(
                    Icons.high_quality,
                    size: 24,
                  ),
                ),
              ),
            ),
          ]),
        ),
        isExpanded: _panelsExpansionStatus[0]);
  }

  _buildPriceInfoPanel() {
    return ExpansionPanel(
        backgroundColor: Colors.grey[100],
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
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
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: vehicle.askingPrice.toString(),
                decoration: InputDecoration(
                  labelText: "Listing Price",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
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
                initialValue: vehicle.mmr.toString(),
                decoration: InputDecoration(
                  labelText: "MMR",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(
                    Icons.price_change,
                    size: 24,
                  ),
                ),
              ),
            ),
          ]),
        ),
        isExpanded: _panelsExpansionStatus[1]);
  }

  _buildPurchaseInfoPanel() {
    return ExpansionPanel(
        backgroundColor: Colors.grey[100],
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
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
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: (inventoryItem.purchasedPrice -
                        inventoryItem.deductionsAmount)
                    .toString(),
                decoration: InputDecoration(
                  labelText: "Purchased Price",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(
                    Icons.price_change,
                    size: 24,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: inventoryItem.lenderAmount.toString(),
                decoration: InputDecoration(
                  labelText: "Lender Amount",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(
                    Icons.price_change,
                    size: 24,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: inventoryItem.withholdingAmount.toString(),
                decoration: InputDecoration(
                  labelText: "Withholding",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(
                    Icons.price_change,
                    size: 24,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: TextFormField(
                readOnly: true,
                initialValue: inventoryItem.customerAmount.toString(),
                decoration: InputDecoration(
                  labelText: "Customer Check",
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.border,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(
                    Icons.price_change,
                    size: 24,
                  ),
                ),
              ),
            ),
          ]),
        ),
        isExpanded: _panelsExpansionStatus[2]);
  }
}
