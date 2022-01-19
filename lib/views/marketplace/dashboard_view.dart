import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/utils/assets/marketplace_assets.dart';
import 'package:mca_leads_management_mobile/utils/theme/marketplace.dart';
import 'package:mca_leads_management_mobile/views/marketplace/marketplace_listing_details_view.dart';
import 'package:mca_leads_management_mobile/widgets/image/navigation_svg_icon.dart';
import 'package:mca_leads_management_mobile/widgets/loader/full_screen_loader.dart';

class MarketplaceDashboardView extends StatefulWidget {
  MarketplaceDashboardView({Key? key}) : super(key: key);

  @override
  State<MarketplaceDashboardView> createState() =>
      _MarketplaceDashboardViewState();
}

class _MarketplaceDashboardViewState extends State<MarketplaceDashboardView> {
  int _currentIndexSelected = 0;
  LogicalView logicalView = LogicalView.marketplace;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getMarketplaceThemeData,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFF3F3F3),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                    )),
                const VerticalDivider(
                  color: Colors.transparent,
                ),
                Text("Welcome to your marketplace"),
              ],
            ),
            actions: [
              Container(
                width: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFFF3F3F3),
                ),
                child: TextButton(
                    onPressed: () {},
                    child: SvgPicture.asset(MarketPlaceIcons.search.asset)),
              )
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset.fromDirection(1, 5),
                  color: Colors.grey,
                  blurRadius: 15,
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 100,
              currentIndex: _currentIndexSelected,
              items: [
                BottomNavigationBarItem(
                    icon: CustomNavigationSvgIcon(
                        asset: MarketPlaceIcons.dashboard.asset,
                        isActive: _currentIndexSelected == 0),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: CustomNavigationSvgIcon(
                        asset: MarketPlaceIcons.garage.asset,
                        isActive: _currentIndexSelected == 1),
                    label: "Garage"),
                BottomNavigationBarItem(
                    icon: CustomNavigationSvgIcon(
                        asset: MarketPlaceIcons.listing.asset,
                        isActive: _currentIndexSelected == 2),
                    label: "Listings"),
                BottomNavigationBarItem(
                    icon: CustomNavigationSvgIcon(
                        asset: MarketPlaceIcons.vehicle.asset,
                        isActive: _currentIndexSelected == 3),
                    label: "Sell"),
                BottomNavigationBarItem(
                    icon: CustomNavigationSvgIcon(
                        asset: MarketPlaceIcons.settings.asset,
                        isActive: _currentIndexSelected == 4),
                    label: "Settings"),
              ],
              onTap: (newIndex) {
                setState(() {
                  _currentIndexSelected = newIndex;
                });
              },
            ),
          ),
          body: FutureBuilder<Object>(
              future: getLeadsList(logicalView),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const FullScreenLoader();
                }
                List<Widget> cards = snapshot.data as List<Widget>;
                return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(children: cards));
              })),
    );
  }

  Future<List<Widget>> getLeadsList(LogicalView logicalView) async {
    try {
      List<LeadSummary>? newLeads = await getLeads(logicalView);
      List<Widget> leadsCards = [];
      for (LeadSummary lead in newLeads ?? []) {
        leadsCards.add(ListingCard(
            id: lead.id,
            viewTag: lead.viewTag,
            title: lead.title,
            vin: lead.vin));
      }
      return leadsCards;
    } catch (e, s) {
      log("Error fetching leads $e: ", stackTrace: s);
      return [];
    }
  }
}

class ListingCard extends StatelessWidget {
  final String id;
  final LeadViewTag viewTag;
  final String title;
  final String vin;

  const ListingCard(
      {Key? key,
      required this.id,
      required this.viewTag,
      this.title = "No title",
      this.vin = "No VIN"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(MarketListingDetailView.routeName,
            arguments: {"id": id, "viewTag": viewTag});
      },
      child: Container(
        height: 278,
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset.fromDirection(0),
              color: const Color(0x2F000000),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 145,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    MarketPlaceIcons.demoCar.asset,
                    width: double.maxFinite,
                    fit: BoxFit.fitWidth,
                  )),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: getFirstRow(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: getSecondRow(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Divider(
                    color: Color(0x7F707070),
                  ),
                ),
                getThirdRow()
              ],
            )
          ],
        ),
      ),
    );
  }

  Row getThirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(MarketPlaceIcons.speedometer.asset),
            const SizedBox(
              width: 5,
            ),
            Text("17k miles")
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(MarketPlaceIcons.gas.asset),
            const SizedBox(
              width: 5,
            ),
            Text("Diesel")
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(MarketPlaceIcons.gearshift.asset),
            const SizedBox(
              width: 5,
            ),
            Text("4.7 CR")
          ],
        ),
      ],
    );
  }

  Row getFirstRow() {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        )
      ],
    );
  }

  Row getSecondRow() {
    return Row(
      children: [
        Text(
          "\$54,000",
          style: TextStyle(color: Color(0xFF014F8B), fontSize: 14),
        )
      ],
    );
  }
}
