// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.

import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';

class LeadViewArguments {
  final String id;
  final String vehicleId;
  final String title;
  final String vin;
  final LogicalView logicalView;

  LeadViewArguments(
      this.id, this.vehicleId, this.vin, this.title, this.logicalView);
}
