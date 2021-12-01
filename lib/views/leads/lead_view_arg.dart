// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
import 'package:mca_leads_management_mobile/models/entities/lead.dart';

class LeadViewArguments {
  final String id;
  final LeadView leadView;

  LeadViewArguments(this.id, this.leadView);
}