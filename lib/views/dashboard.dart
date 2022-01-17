/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/controllers/notification_handler.dart';
import 'package:mca_leads_management_mobile/models/entities/api/logical_view.dart';
import 'package:mca_leads_management_mobile/models/entities/drawer_item.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead_summary.dart';
import 'package:mca_leads_management_mobile/models/interfaces/common_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/lead_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/session_interface.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/views/marketplace/dashboard_view.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });

  String? title;
  String? body;
}

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
  final List<bool> _panelsExpansionStatus = [];
  final List<LeadSummary> _leadList = [];
  late LogicalView logicalView;
  List<DrawerItem> drawerItems = [];

  late PushNotification _notificationInfo;
  var _totalNotifications = 0;

  void _getLeads() async {
    _leadList.clear();
    List<LeadSummary>? newLeads = await getLeads(logicalView);
    newLeads?.forEach((lead) => _leadList.add(lead));
    dev.log("Leads size ($logicalView): ${_leadList.length.toString()}");
    setState(() {});
  }

  bool hasDetail(LeadViewTag leadViewTag) {
    return leadViewTag != LeadViewTag.activeProgress;
  }

  @override
  void initState() {
    super.initState();
    //registerNotification();
    NotificationHandler.start();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    logicalView = LogicalView.approval;
    _getLeads();
    for (var element in DrawerPanel.values) {
      _panelsExpansionStatus.add(false);
    }
    drawerItems = [
      DrawerItem(
          panel: DrawerPanel.leads,
          logicalView: LogicalView.approval,
          icon: Icons.approval,
          position: 1),
      DrawerItem(
          panel: DrawerPanel.leads,
          logicalView: LogicalView.followUpManager,
          icon: MdiIcons.contain,
          position: 2),
      DrawerItem(
          panel: DrawerPanel.leads,
          logicalView: LogicalView.appraisal,
          icon: Icons.price_check,
          position: 3),
      DrawerItem(
          panel: DrawerPanel.inspections,
          logicalView: LogicalView.dispatched,
          icon: Icons.schedule_sharp,
          position: 4),
      DrawerItem(
          panel: DrawerPanel.inspections,
          logicalView: LogicalView.active,
          icon: Icons.play_arrow,
          position: 5),
      DrawerItem(
          panel: DrawerPanel.inspections,
          logicalView: LogicalView.completed,
          icon: Icons.done_outline,
          position: 6),
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.inventory,
          icon: Icons.inventory,
          position: 7),
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.receivedOffer,
          icon: MdiIcons.storeOutline,
          position: 8),
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.sentOffer,
          icon: MdiIcons.storeOutline,
          position: 9),
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.marketplace,
          icon: Icons.shopping_bag,
          position: 10),
      DrawerItem(
          panel: DrawerPanel.transport,
          logicalView: LogicalView.transferPlaced,
          icon: Icons.emoji_transportation,
          position: 11),
      DrawerItem(
          panel: DrawerPanel.transport,
          logicalView: LogicalView.transferRequest,
          icon: Icons.ev_station,
          position: 12),
      DrawerItem(
          panel: DrawerPanel.transport,
          logicalView: LogicalView.transferActive,
          icon: Icons.car_rental,
          position: 13),
      DrawerItem(
          panel: DrawerPanel.transport,
          logicalView: LogicalView.transferCompleted,
          icon: Icons.car_repair,
          position: 14),
    ];
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();
    dev.log("fcm token: $fcmToken");
    CommonInterface().updateToken(fcmToken ?? "");

    // 3. On iOS, this helps to take the user permissions
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        dev.log('User granted permission');

        // For handling the received notifications
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          dev.log("Receive Notification");
          // Parse the message received
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
          );

          setState(() {
            _notificationInfo = notification;
            _totalNotifications++;
          });
        });
      } else {
        dev.log('User declined or has not accepted permission');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (logicalView == LogicalView.marketplace ||
        logicalView == LogicalView.inventory ||
        logicalView == LogicalView.receivedOffer ||
        logicalView == LogicalView.sentOffer) {
      return DashboardView();
    }
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: FxText.sh1(
            logicalView.getName(),
            fontWeight: 600,
            color: theme.backgroundColor,
          ),
          iconTheme: IconThemeData(color: theme.backgroundColor),
        ),
        drawer: _buildDrawer(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: lightColor.primaryVariant,
            child: const Icon(Icons.refresh),
            onPressed: _getLeads),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              // child: Row(
              //   children: <Widget>[
              //     Expanded(
              //       flex: 1,
              //       child: Container(
              //         color: Colors.grey[100],
              //         child: TextField(
              //             onSubmitted: (text) {
              //               _searchLeadSession(context, text);
              //             },
              //             decoration: InputDecoration(
              //               hintText: "VIN or Last Six",
              //               border: theme.inputDecorationTheme.border,
              //               enabledBorder: theme.inputDecorationTheme.border,
              //               focusedBorder:
              //                   theme.inputDecorationTheme.focusedBorder,
              //               prefixIcon: const Icon(MdiIcons.numeric, size: 24),
              //             )),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
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
        ));
  }

  ExpansionPanel _buildExpansionPanel(DrawerPanel panel) {
    return ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: FxText.b1(panel.getName(),
                color: isExpanded
                    ? lightColor.primary
                    : theme.colorScheme.onBackground,
                fontWeight: isExpanded ? 700 : 600),
          );
        },
        body: Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
              children: drawerItems
                  .where((element) => element.panel == panel)
                  .map((e) => singleDrawerItem(e))
                  .toList()),
        ),
        isExpanded: _panelsExpansionStatus[DrawerPanel.values.indexOf(panel)]);
  }

  Widget _buildDrawer() {
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
            child: Container(
              color: lightColor.primaryVariant,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, bottom: 8, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FxText.h6(currentUser!.username,
                            color: theme.colorScheme.onPrimary,
                            fontWeight: 600),
                        FxText.b2("manager1@mycarauction.com",
                            color: theme.colorScheme.onPrimary, fontWeight: 400)
                      ],
                    ),
                  ],
                ),
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
                          _panelsExpansionStatus[index] = !isExpanded;
                        });
                      },
                      animationDuration: const Duration(milliseconds: 500),
                      children: DrawerPanel.values
                          .map((e) => _buildExpansionPanel(e))
                          .toList()),
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
          if (logicalView == LogicalView.marketplace) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      logicalView.getRouteName(),
                      arguments: LeadViewArguments(
                          _leadList[index].id,
                          _leadList[index].vehicleId,
                          _leadList[index].vin,
                          _leadList[index].title,
                          _leadList[index].viewTag,
                          logicalView),
                    );
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: Image.asset("assets/car_pic.png"),
                        flex: 1,
                      ),
                      Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _leadList[index].getCompactTitle(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  height: 7,
                                  color: Colors.transparent,
                                ),
                                Text(
                                  "\$123,000",
                                  style: TextStyle(color: Color(0xFF4287f5)),
                                ),
                                Divider(
                                  height: 4,
                                  color: Colors.transparent,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.speed),
                                          Text("40k mi"),
                                        ],
                                      ),
                                      VerticalDivider(),
                                      Row(
                                        children: [
                                          Icon(Icons.local_gas_station),
                                          Text("Gas"),
                                        ],
                                      ),
                                      VerticalDivider(),
                                      Row(
                                        children: [
                                          Icon(Icons.title),
                                          Text("Automatic"),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          }
          return Ink(
            color: theme.backgroundColor,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _leadList[index].viewTag.getBackgroundColor(),
                child: FxText.b1(_leadList[index].viewTag.getAbbrv(),
                    fontWeight: 600,
                    color: _leadList[index].viewTag.getForegroundColor()),
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
                  fontWeight: 700, color: theme.colorScheme.onBackground),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  logicalView.getRouteName(),
                  arguments: LeadViewArguments(
                      _leadList[index].id,
                      _leadList[index].vehicleId,
                      _leadList[index].vin,
                      _leadList[index].title,
                      _leadList[index].viewTag,
                      logicalView),
                );
              },
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(
              height: 25,
              color: Colors.transparent,
            ));
  }

  void _searchLeadSession(context, keyword) async {
    try {
      LeadSummary sessionSummary = await SessionInterface().search(keyword);
      _leadList.clear();
      _leadList.add(sessionSummary);
      setState(() {});
      return;
    } catch (e) {
      try {
        LeadSummary leadSummary = await LeadInterface().search(keyword);
        _leadList.clear();
        _leadList.add(leadSummary);
        setState(() {});
      } catch (e) {
        showSnackBar(
            context: context,
            text: 'Lead was not found',
            backgroundColor: lightColor.defaultError.primaryVariant);
      }
    }
  }

  Widget singleDrawerItem(DrawerItem drawerItem) {
    return _singleDrawerItem(
        drawerItem.icon, drawerItem.logicalView, drawerItem.position);
  }

  Widget _singleDrawerItem(
      IconData iconData, LogicalView logicalView, int position) {
    return ListTile(
        dense: true,
        contentPadding:
            const EdgeInsets.only(top: 0.0, left: 16, right: 16, bottom: 0),
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
        });
  }

  Widget _showNotification(BuildContext context) {
    if (_totalNotifications != 0) {
      showSnackBar(
          context: context,
          text: _notificationInfo.body!,
          backgroundColor: lightColor.primaryVariant);
      _totalNotifications--;
    }
    return Container();
  }
}
