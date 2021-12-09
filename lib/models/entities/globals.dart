import 'dart:collection';

import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';

String? inspectionConfigStr;
AuthUserModel? _user;
Map<LogicalView, List<LeadSummary>?> leadSummaries = HashMap();

AuthUserModel? get currentUser {
  return _user;
}

set currentUser(AuthUserModel? newUser) {
  _user = newUser;
}

Future<List<LeadSummary>?> getLeads(LogicalView logicalView) async {
  List<LeadSummary>? newLeads;
  if (logicalView.isLeadView()) {
    newLeads = await BackendInterface().getLeads(logicalView);
  } else {
    newLeads = await BackendInterface().getSessions(logicalView);
  }
  if (newLeads!.isNotEmpty) {
    leadSummaries.putIfAbsent(logicalView, () => newLeads);
  }
  return leadSummaries[logicalView];
}
