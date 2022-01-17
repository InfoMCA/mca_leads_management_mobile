enum MarketPlaceIcons {
  dashboard,
  garage,
  listing,
  settings,
  vehicle,
  search,
  gas,
  gearshift,
  speedometer,
  demoCar
}

extension StringNames on MarketPlaceIcons {
  String get asset {
    switch (this) {
      case MarketPlaceIcons.dashboard:
        return "assets/marketplace_icons/dashboard.svg";
      case MarketPlaceIcons.garage:
        return "assets/marketplace_icons/garage.svg";
      case MarketPlaceIcons.listing:
        return "assets/marketplace_icons/listing.svg";
      case MarketPlaceIcons.settings:
        return "assets/marketplace_icons/settings.svg";
      case MarketPlaceIcons.vehicle:
        return "assets/marketplace_icons/vehicle.svg";
      case MarketPlaceIcons.search:
        return "assets/marketplace_icons/search.svg";
      case MarketPlaceIcons.gas:
        return "assets/marketplace_icons/gas.svg";
      case MarketPlaceIcons.gearshift:
        return "assets/marketplace_icons/gearshift.svg";
      case MarketPlaceIcons.speedometer:
        return "assets/marketplace_icons/speedometer.svg";
      case MarketPlaceIcons.demoCar:
        return "assets/marketplace_icons/demo-car.png";
    }
  }
}
