import 'package:flutter/cupertino.dart';

import 'api/logical_view.dart';

enum DrawerPanel { leads, inspections, marketPlace, transport }

extension DrawPanelExt on DrawerPanel {
  String getName() {
    switch (this) {
      case DrawerPanel.leads:
        return "Leads";
      case DrawerPanel.inspections:
        return "Inspections";
      case DrawerPanel.marketPlace:
        return "MarketPlace";
      case DrawerPanel.transport:
        return "Transport";
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
