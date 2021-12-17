import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/views/dashboard.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_schedule_view.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_question_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/inventory_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/listing_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/listing_request_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/marketplace_listing_details_view.dart';
import 'package:mca_leads_management_mobile/views/marketplace/offer_details_view.dart';
import 'package:mca_leads_management_mobile/views/session/session_active_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_complete_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_details.dart';
import 'package:mca_leads_management_mobile/views/security/login_page.dart';
import 'package:mca_leads_management_mobile/views/session/session_schedule_view.dart';
import 'package:mca_leads_management_mobile/views/session/session_transport_view.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/security/login', child: (_, args) => const LoginPage()),
    ChildRoute('/home', child: (_, args) => const DashBoard()),
    ChildRoute('/home/lead',
        child: (_, args) => LeadDetailsView(args: args.data)),
    ChildRoute('/home/lead-schedule',
        child: (_, args) => LeadScheduleView(lead: args.data)),
    ChildRoute('/home/lead-question',
        child: (_, args) => LeadQuestionView(lead: args.data)),
    ChildRoute('/home/session',
        child: (_, args) => SessionDetails(args: args.data)),
    ChildRoute('/home/session-active',
        child: (_, args) => SessionActiveDetailsView(args: args.data)),
    ChildRoute('/home/session-schedule',
        child: (_, args) => SessionScheduleView(session: args.data)),
    ChildRoute('/home/session-transport',
        child: (_, args) => SessionTransportView(session: args.data)),
    ChildRoute('/home/session-complete-report',
        child: (_, args) => SessionDetailsCompleteReport(args: args.data)),
    ChildRoute('/home/listing',
        child: (_, args) => ListingDetailView(args: args.data)),
    ChildRoute('/home/listing-new',
        child: (_, args) => ListingRequestView(args: args.data)),
    ChildRoute('/home/marketplace-listing',
        child: (_, args) => MarketListingDetailView(args: args.data)),
    ChildRoute('/home/offer',
        child: (_, args) => OfferDetailView(args: args.data)),
    ChildRoute('/home/inventory',
        child: (_, args) => InventoryDetailView(args: args.data)),
  ];
}
