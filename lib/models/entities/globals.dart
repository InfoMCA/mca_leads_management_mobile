import 'dart:collection';

import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';

String? inspectionConfigStr;
AuthUserModel? _user;
Map<LeadView, List<LeadSummary>?> leadSummaries = new HashMap();

AuthUserModel? get currentUser {
  return _user;
}

set currentUser(AuthUserModel? newUser) {
  _user = newUser;
}

Future<List<LeadSummary>?> getLeads(LeadView leadView) async {
  List<LeadSummary>? newLeads = await BackendInterface().getLeads(leadView);
  if (newLeads!.isNotEmpty) {
    leadSummaries.putIfAbsent(leadView, () => newLeads);
  }
  return leadSummaries[leadView];
}

