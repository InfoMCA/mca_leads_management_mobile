import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/views/leads/DashBoard.dart';
import 'package:mca_leads_management_mobile/views/leads/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/leads/lead_schedule_view.dart';
import 'package:mca_leads_management_mobile/views/session/session_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_details_complete.dart';
import 'package:mca_leads_management_mobile/views/security/login_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/security/login', child: (_, args) => const LoginPage()),
    ChildRoute('/home', child: (_, args) => const DashBoard()),
    ChildRoute('/home/lead', child: (_, args) => LeadDetailsView(args: args.data)),
    ChildRoute('/home/lead-schedule', child: (_, args) => LeadScheduleView(lead: args.data)),
    ChildRoute('/home/session', child: (_, args) => const SessionDetails()),
    ChildRoute('/home/sessionComplete',
        child: (_, args) => SessionDetailsComplete()),
  ];
}
