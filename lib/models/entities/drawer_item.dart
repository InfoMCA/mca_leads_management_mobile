import 'package:flutter/cupertino.dart';

import 'api/logical_view.dart';

//enum DrawerPanel { leads, inspections, marketPlace, transport }
enum DrawerPanel { marketPlace }

extension DrawPanelExt on DrawerPanel {
  String getName() {
    switch (this) {
      case DrawerPanel.marketPlace:
        return "MarketPlace";
    }
  }
}

class DrawerItem {
  DrawerPanel panel;
  LogicalView logicalView;
  IconData icon;
  int position;

  DrawerItem(
      {required this.panel,
      required this.logicalView,
      required this.icon,
      required this.position});
}
