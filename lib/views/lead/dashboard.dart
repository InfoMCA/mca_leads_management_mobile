/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_details_view.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/views/session/session_details.dart';
import 'package:mca_leads_management_mobile/views/session/session_details_complete.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late CustomTheme customTheme;
  late ThemeData theme;

  int _selectedPage = 0;
  List<bool> _dataExpansionPanel = [false, true, false];
  final List<LeadSummary> _leadList = [];
  late LogicalView logicalView;


  void _getLeads() async {
    _leadList.clear();
    List<LeadSummary>? newLeads = await getLeads(logicalView);
    newLeads?.forEach((lead) => _leadList.add(lead));
    dev.log("Leads size ($logicalView): ${_leadList.length.toString()}");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    logicalView = LogicalView.approval;
    _getLeads();
  }

  Drawer _buildDrawer() {
    return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*---------- Drawer Header ----------------*/
            Expanded(
              flex: 2,
              child: DrawerHeader(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
            child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, bottom: 8, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const <Widget>[
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.h6(currentUser!.username,
                              color: theme.colorScheme.onPrimary,
                              fontWeight: 600),
                          FxText.b2("manager1@mycarauction.com",
                              color: theme.colorScheme.onPrimary,
                              fontWeight: 400)
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(color: theme.primaryColor),
              ),
            ),

            /*------------- Drawer Content -------------*/
            Expanded(
              flex: 8,
              child: Container(
                color: theme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: <Widget>[
                      ExpansionPanelList(
                        expandedHeaderPadding: const EdgeInsets.all(0),
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _dataExpansionPanel[index] = !isExpanded;
                          });
                        },
                        animationDuration: const Duration(milliseconds: 500),
                        children: <ExpansionPanel>[
                          ExpansionPanel(
                              canTapOnHeader: true,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: FxText.b1("Leads",
                                      color: isExpanded
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onBackground,
                                      fontWeight: isExpanded ? 700 : 600),
                                );
                              },
                              body: Container(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  children: [
                                    _singleDrawerItem(
                                        MdiIcons.starOutline, LogicalView.approval,
                                        1),
                                    _singleDrawerItem(
                                        MdiIcons.clockOutline,
                                        LogicalView.followUpManager, 2),
                                    _singleDrawerItem(
                                        MdiIcons.send, LogicalView.appraisal, 3),
                                  ],
                                ),
                              ),
                              isExpanded: _dataExpansionPanel[0]),
                          ExpansionPanel(
                              canTapOnHeader: true,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: FxText.b1("Inspections",
                                      color: isExpanded
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onBackground,
                                      fontWeight: isExpanded ? 700 : 600),
                                );
                              },
                              body: Column(
                                children: [
                                  _singleDrawerItem(
                                      MdiIcons.emailOutline,
                                      LogicalView.dispatched, 4),
                                  _singleDrawerItem(
                                      MdiIcons.accountGroupOutline,
                                      LogicalView.active, 5),
                                  _singleDrawerItem(
                                      MdiIcons.tagOutline, LogicalView.completed,
                                      6),
                                ],
                              ),
                              isExpanded: _dataExpansionPanel[1]),
                          ExpansionPanel(
                              canTapOnHeader: true,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: FxText.b1("Market Place",
                                      color: isExpanded
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onBackground,
                                      fontWeight: isExpanded ? 700 : 600),
                                );
                              },
                              body: Column(
                                children: [
                                  _singleDrawerItem(
                                      MdiIcons.emailOutline,
                                      LogicalView.inventory, 7),
                                  _singleDrawerItem(
                                      MdiIcons.accountGroupOutline,
                                      LogicalView.marketplace, 8),
                                  _singleDrawerItem(
                                      MdiIcons.tagOutline, LogicalView.traded,
                                      9),
                                ],
                              ),
                              isExpanded: _dataExpansionPanel[2]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildItemList() {
    return ListView.separated(
        itemCount: _leadList.length,
        itemBuilder: (context, index) {
          return Ink(
            color: theme.backgroundColor,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _leadList[index].viewTag
                    .getBackgroundColor(),
                child: FxText.b1(_leadList[index].viewTag.getAbbrv(),
                    fontWeight: 600,
                    color: _leadList[index].viewTag
                        .getForegroundColor()),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FxText.b2(_leadList[index].vin,
                      fontSize: 13,
                      fontWeight: 500,
                      color: theme.colorScheme.onBackground),
                  FxText.b2(_leadList[index].getPrettyTime(),
                      fontSize: 13,
                      fontWeight: 500,
                      color: theme.colorScheme.onBackground),
                ],
              ),
              title: FxText.b1(_leadList[index].getCompactTitle(),
                  fontWeight: 700,
                  color: theme.colorScheme.onBackground),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  logicalView.getRouteName(),
                  arguments: LeadViewArguments(
                      _leadList[index].id,
                      logicalView
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (_, __) =>
            Divider(
              height: 0.5,
              color: theme.dividerColor,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: FxText.sh1(logicalView.getName(), fontWeight: 600, color: theme.backgroundColor,),
        iconTheme: IconThemeData(color: theme.backgroundColor),
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: 12, top: 8, right: 12, bottom: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey[100],
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "VIN or Last Six",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme
                            .border,
                        focusedBorder: theme.inputDecorationTheme
                            .focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.numeric, size: 24),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
            NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  setState(() {});
                }
                return true;
              },
              child: _buildItemList(),
            ),
          ),
        ],
      )
      /*DefaultTabController(
        length: 6,
        initialIndex: _selectedPage,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabs: LeadView.values.map((e) =>
                        Tab(child: FxText.sh1(
                          e.getName(), fontSize: 14,
                          fontWeight: 500,
                          color: theme.backgroundColor,)))
                        .toList()
                )
              ],
            ),
          ),
          body: TabBarView(
              controller: _tabController,
              children: LeadView.values.map((e) => LeadsView(logicalView: e))
                  .toList()
          ),
        ),
      ),*/
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
            LogicalView.approval
        ),
      );
    } catch (e, s) {
      showSnackBar(context: context, text: 'Lead was not found');
    }
  }

  void _showSearchDialog(context) {
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
                                enabledBorder: theme.inputDecorationTheme
                                    .border,
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

  Widget _singleDrawerItem(IconData iconData, LogicalView logicalView, int position) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.only(top: 0.0, left: 16, right: 16, bottom: 0),
      leading: Icon(iconData,
          size: 20,
          color: _selectedPage == position
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground.withAlpha(240)),
      title: FxText.sh2(logicalView.getName(),
          fontSize: 14,
          fontWeight: _selectedPage == position ? 600 : 500,
          letterSpacing: 0.2,
          color: _selectedPage == position
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground.withAlpha(240)),
      onTap: () {
        setState(() {
          this.logicalView = logicalView;
          _getLeads();
          _selectedPage = position;
        });
        _scaffoldKey.currentState!.openEndDrawer();
      }
    );
  }

}
