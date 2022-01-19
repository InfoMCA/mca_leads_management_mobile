import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/models/entities/api/marketplace/marketplace_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/utils/assets/marketplace_assets.dart';
import 'package:mca_leads_management_mobile/utils/theme/marketplace.dart';
import 'package:mca_leads_management_mobile/widgets/button/user_offer_tile.dart';
import 'package:mca_leads_management_mobile/widgets/container/info_card.dart';
import 'package:mca_leads_management_mobile/widgets/loader/full_screen_loader.dart';
import 'package:mca_leads_management_mobile/widgets/slider/gradient_slider.dart';

class MarketListingDetailView extends StatefulWidget {
  final String id;
  final LeadViewTag viewTag;
  static String routeName = '/home/marketplace-listing';

  const MarketListingDetailView(
      {Key? key, required this.id, required this.viewTag})
      : super(key: key);

  @override
  _MarketListingDetailViewState createState() =>
      _MarketListingDetailViewState();
}

class _MarketListingDetailViewState extends State<MarketListingDetailView> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getMarketplaceThemeData,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () => Modular.to.pop(),
          ),
          title: const Text("Vehicle description",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: MarketplaceInterface().getListing(widget.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const FullScreenLoader();
              }
              GetListingResponse response = snapshot.data as GetListingResponse;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  clipBehavior: Clip.none,
                  children: [
                    getGeneralInfoCard(),
                    const SizedBox(
                      height: 25,
                    ),
                    getConditionsInfoCard(),
                    const SizedBox(
                      height: 25,
                    ),
                    getOffersInfoCard()
                  ],
                ),
              );
            }),
      ),
    );
  }

  InfoCard getOffersInfoCard() {
    return InfoCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "Offers",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
        ),
        Divider(),
        Wrap(
          runSpacing: 20,
          children: [
            UserOfferTile(
              offerValue: 52900,
              buyerName: "John Doe",
              buyerCityState: "Irvine, CA",
              onOfferAccepted: () {},
            ),
            UserOfferTile(
              offerValue: 25000,
              buyerName: "Jay Ce",
              buyerCityState: "Irvine, CA",
              onOfferAccepted: () {},
            ),
            UserOfferTile(
              offerValue: 25000,
              buyerName: "Jay Ce",
              buyerCityState: "Irvine, CA",
              onOfferAccepted: () {},
            ),
            UserOfferTile(
              offerValue: 25000,
              buyerName: "Jay Ce",
              buyerCityState: "Irvine, CA",
              onOfferAccepted: () {},
            )
          ],
        )
      ],
    ));
  }

  InfoCard getConditionsInfoCard() {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "Vehicle condition",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ),
          const Divider(),
          Wrap(
            runSpacing: 20,
            children: [
              GradientSlider(label: "Paint Condition:", value: 91),
              GradientSlider(label: "Interior Condition:", value: 50),
              GradientSlider(label: "Mechanical Condition", value: 91),
              GradientSlider(label: "Brake Condition", value: 15),
              GradientSlider(label: "Tire Condition", value: 30),
              getDescriptionRow(name: "Structural/Frame Damage", value: "No"),
              getDescriptionRow(name: "Airbags deployed", value: "No"),
              getDescriptionRow(name: "Dents", value: "No"),
              getDescriptionRow(name: "Scratches", value: "No"),
              getDescriptionRow(name: "Odors", value: "No"),
              getDescriptionRow(name: "Modifications", value: "No"),
            ],
          )
        ],
      ),
    );
  }

  Widget getGeneralInfoCard() {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 165,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  MarketPlaceIcons.demoCar.asset,
                  width: double.maxFinite,
                  fit: BoxFit.fitWidth,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text("BMW M3 CS Limited",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          ),
          const Divider(),
          Wrap(
            runSpacing: 20,
            children: [
              getDescriptionRow(name: "Year", value: "2020"),
              getDescriptionRow(name: "Make", value: "BMW"),
              getDescriptionRow(name: "Model", value: "3 Series"),
              getDescriptionRow(name: "Style", value: "4D M3 Sedan CS Limited"),
              getDescriptionRow(name: "Color", value: "Gray"),
              getDescriptionRow(name: "Mileage", value: "Gray"),
              getDescriptionRow(name: "Fuel", value: "Gray"),
              getDescriptionRow(name: "Gearbox", value: "Gray"),
              getDescriptionRow(name: "Loan/Lease/Owned", value: "Gray"),
            ],
          )
        ],
      ),
    );
  }

  Row getDescriptionRow({required String name, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

