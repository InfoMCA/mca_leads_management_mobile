import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mca_leads_management_mobile/utils/assets/marketplace_assets.dart';
import 'package:mca_leads_management_mobile/utils/theme/marketplace.dart';
import 'package:mca_leads_management_mobile/widgets/image/navigation_svg_icon.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndexSelected = 0;

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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [ListingCard()],
          ),
        ),
      ),
    );
  }
}

class ListingCard extends StatelessWidget {
  const ListingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Row(
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
              )
            ],
          )
        ],
      ),
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

  Row getFirstRow() {
    return Row(
      children: [
        Text(
          "2010 BMW M3 CS Limited",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        )
      ],
    );
  }
}
