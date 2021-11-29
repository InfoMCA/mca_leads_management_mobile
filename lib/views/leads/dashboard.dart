/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/leads/leads.dart';
import 'package:mca_leads_management_mobile/views/leads/sessions.dart';
import 'package:mca_leads_management_mobile/views/leads/sessions_complete.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: FxText.sh1("MCA Lead Management", fontWeight: 600),
      ),
      body: DefaultTabController(
        length: 6,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*-------------- Build Tabs here ------------------*/
                TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(
                        child:
                            FxText.sh1("Awaiting Approval", fontWeight: 600)),
                    Tab(child: FxText.sh1("Follow Up", fontWeight: 600)),
                    Tab(child: FxText.sh1("Appraisal", fontWeight: 600)),
                    Tab(child: FxText.sh1("Dispatched", fontWeight: 600)),
                    Tab(child: FxText.sh1("In Progress", fontWeight: 600)),
                    Tab(child: FxText.sh1("Completed", fontWeight: 600)),
                  ],
                )
              ],
            ),
          ),

          /*--------------- Build Tab body here -------------------*/
          body: const TabBarView(
            children: <Widget>[
              LeadsList(leadType: 'Awaiting Approval'),
              LeadsList(leadType: 'Follow Up'),
              LeadsList(leadType: 'Appraisal'),
              SessionsList(sessionType: 'Dispatched'),
              SessionsCompleteList(sessionCompleteType: 'In Progress'),
              SessionsCompleteList(sessionCompleteType: 'Completed'),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTabContent(String text) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: FxText.sh1(text, fontWeight: 600),
      ),
    );
  }
}
