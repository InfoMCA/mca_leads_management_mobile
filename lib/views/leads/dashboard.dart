/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/leads/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/leads/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/views/leads/leads_view.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/container/container.dart';
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
        title: FxText.sh1("MCA Lead Management", fontWeight: 600, color: theme.backgroundColor,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFollowUpDialog(context),
        child: Icon(Icons.search),
        backgroundColor: theme.colorScheme.primary,
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
                TabBar(
                    isScrollable: true,
                    tabs: LeadView.values.map((e) =>
                        Tab(child: FxText.sh1(
                          e.getName(), fontSize: 14, fontWeight: 500, color: theme.backgroundColor,)))
                        .toList()
                )
              ],
            ),
          ),
          body: TabBarView(
              children: LeadView.values.map((e) => LeadsView(leadView: e))
                  .toList()
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

  void _searchLead(context, keyword) async {
    try {
      BackendResp resp = await BackendInterface().searchLead(keyword);
      Navigator.pushNamed(
        context,
        LeadDetailsView.routeName,
        arguments: LeadViewArguments(
            resp.lead!.id,
            LeadView.approval
        ),
      );

    } catch (e, s) {
      showSnackBar(context: context, text: 'Lead was not found');
    }
  }

  void _showFollowUpDialog(context) {
    double height = 100;
    String keyword = "";
    bool isSearching = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
                color: Colors.transparent,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: FocusScope(
                            onFocusChange: (value) {
                              if (height == 100) {
                                height = 400;
                              } else if (!isSearching) {
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/home'));
                                isSearching = true;
                                _searchLead(context, keyword);
                              }
                            },
                          child: TextFormField(
                            onChanged: (text) => keyword = text,
                            decoration: InputDecoration(
                              labelText: "VIN or Last Six",
                              border: theme.inputDecorationTheme.border,
                              enabledBorder: theme.inputDecorationTheme.border,
                              focusedBorder: theme.inputDecorationTheme
                                  .focusedBorder,
                              prefixIcon:
                              const Icon(MdiIcons.numeric, size: 24),
                            ),
                          ),
                        )
                        ),
                      ],
                    ),
                  ),
              )
          );
        });
  }

}
