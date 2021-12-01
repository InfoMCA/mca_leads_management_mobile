/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/leads/leads_view.dart';
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
                            FxText.sh1("Awaiting Approval", fontSize: 16, fontWeight: 700)),
                    Tab(child: FxText.sh1("Follow Up", fontSize: 16, fontWeight: 700)),
                    Tab(child: FxText.sh1("Appraisal", fontSize: 16, fontWeight: 700)),
                    Tab(child: FxText.sh1("Dispatched", fontSize: 16, fontWeight: 700)),
                    Tab(child: FxText.sh1("In Progress", fontSize: 16, fontWeight: 700)),
                    Tab(child: FxText.sh1("Completed", fontSize: 16, fontWeight: 700)),
                  ],
                )
              ],
            ),
          ),

          /*--------------- Build Tab body here -------------------*/
          body: TabBarView(
            children: <Widget>[
              LeadsList(leadView: LeadView.approval),
              LeadsList(leadView: LeadView.followUp),
              LeadsList(leadView: LeadView.appraisal),
              LeadsList(leadView: LeadView.dispatched),
              LeadsList(leadView: LeadView.active),
              LeadsList(leadView: LeadView.completed),
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
