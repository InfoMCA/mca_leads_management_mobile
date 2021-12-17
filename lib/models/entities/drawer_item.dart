import 'package:flutter/cupertino.dart';

import 'api/logical_view.dart';

enum DrawerPanel { leads, inspections }

extension DrawPanelExt on DrawerPanel {
  String getName() {
    switch (this) {
      case DrawerPanel.leads:
        return "Leads";
      case DrawerPanel.inspections:
        return "Inspections";
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
