/*
* File : Selectable List
* Version : 1.0.0
* */
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead_summary.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/leads/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/leads/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/views/session/session_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_details_complete.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class LeadsList extends StatefulWidget {
  LeadView leadView;
  LeadsList({Key? key, required this.leadView}) : super(key: key);

  @override
  _LeadsListState createState() => _LeadsListState();
}

class _LeadsListState extends State<LeadsList> {
  final List<LeadSummary> _leadList = [];

  late CustomTheme customTheme;
  late ThemeData theme;
  late String routeName;

  void _getLeads() async {
    _leadList.clear();
    List<LeadSummary>? newLeads = await getLeads(widget.leadView);
    newLeads?.forEach((lead) => _leadList.add(lead));
    dev.log("Leads size (${widget.leadView}): ${_leadList.length.toString()}");
    setState(() {
    });
  }

  void _getRouteName() {
    switch (widget.leadView) {

      case LeadView.approval:
      case LeadView.followUp:
      case LeadView.appraisal:
        routeName = LeadDetails.routeName;
        break;
      case LeadView.dispatched:
        routeName = SessionDetails.routeName;
        break;
      case LeadView.active:
        routeName = SessionDetailsComplete.routeName;
        break;
      case LeadView.completed:
        routeName = SessionDetailsComplete.routeName;
        break;
    }

  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getRouteName();
    _getLeads();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: _leadList.length,
        itemBuilder: (context, index) {
          return Ink(
            color: theme.backgroundColor,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _leadList[index].viewTag.getBackgroundColor(),
                child: FxText.b1(_leadList[index].viewTag.getAbbrv(),
                    fontWeight: 600,
                    color: _leadList[index].viewTag.getForegroundColor()),
              ),
              subtitle: FxText.b2(_leadList[index].vin,
                  fontWeight: 500, color: theme.colorScheme.onBackground),
              title: FxText.b1(_leadList[index].title,
                  fontWeight: 700, color: theme.colorScheme.onBackground),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeName,
                  arguments: LeadViewArguments(
                      _leadList[index].id,
                      widget.leadView
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (_, __) => Divider(
              height: 0.5,
              color: theme.dividerColor,
            ));
  }
}
