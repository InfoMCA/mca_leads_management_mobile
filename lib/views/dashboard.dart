/*
* File : Top Navigation widget
* Version : 1.0.0
* Description :
* */

import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/text_style.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/bar/rating_bar.dart';
import 'package:mca_leads_management_mobile/widgets/card/custom_reshape_paint.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/container/container.dart';
import 'package:mca_leads_management_mobile/widgets/rating/rating_starts.dart';
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

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
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

  final double _borderRadius = 24;

  var items = [
    PlaceInfo('Dubai Mall Food Court', const Color(0xff6DC8F3), const Color(0xff73A1F9),
        4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
    PlaceInfo('Hamriyah Food Court', const Color(0xffFFB157), const Color(0xffFFA057), 3.7,
        'Sharjah', 'All you can eat · Casual · Groups'),
    PlaceInfo('Gate of Food Court', const Color(0xffFF5B95), const Color(0xffF8556D), 4.5,
        'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
    PlaceInfo('Express Food Court', const Color(0xffD76EF5), const Color(0xff8F7AFE), 4.1,
        'Dubai', 'Casual · Good for kids · Delivery'),
    PlaceInfo('BurJuman Food Court', const Color(0xff42E695), const Color(0xff3BB2B8), 4.2,
        'Dubai · In BurJuman', '...'),
  ];

  var _currentIndex = 0;

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
    logicalView = LogicalView.inventory;
    _getLeads();
    for (var element in DrawerPanel.values) {
      _panelsExpansionStatus.add(false);
    }
    drawerItems = [
      /*
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
          position: 6),*/
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.inventory,
          icon: Icons.inventory,
          position: 1),
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.receivedOffer,
          icon: MdiIcons.storeOutline,
          position: 2),
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.sentOffer,
          icon: MdiIcons.storeOutline,
          position: 3),
      DrawerItem(
          panel: DrawerPanel.marketPlace,
          logicalView: LogicalView.marketplace,
          icon: Icons.shopping_bag,
          position: 4),
      /*
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
          position: 14),*/
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

  _buildActionBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightColor.secondary,
      selectedItemColor: Colors.white.withOpacity(.80),
      unselectedItemColor: Colors.white.withOpacity(.80),
      onTap: (value) {

        setState(() => _currentIndex = value); // Respond to item press.
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Dispatch',
          icon: Icon(Icons.calendar_today),
        ),
        BottomNavigationBarItem(
          label: 'FollowUp',
          icon: Icon(Icons.call),
        ),
        BottomNavigationBarItem(
          label: 'UnAnswered',
          icon: Icon(Icons.call_missed),
        ),
        BottomNavigationBarItem(
          label: 'Lost',
          icon: Icon(Icons.delete),
        ),
        BottomNavigationBarItem(
          label: 'Save',
          icon: Icon(Icons.save),
        ),
        BottomNavigationBarItem(
          label: 'Questions',
          icon: Icon(Icons.question_answer),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _buildActionBar(),
        body: Container(
          color: lightColor.primary,
          child: Column(
            children: <Widget>[
              _SearchWidget(),
              FxSpacing.height(20),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  padding: FxSpacing.zero,
                  children: _leadList.map((e) => Container(
                    margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: _SingleVehicleItem(
                        image: 'assets/bmw.png',
                        name: e.getCompactTitle(),
                        price: 400,
                        address: e.vin,
                        rating: 4.4,
                        buildContext: context,
                      ))).toList(),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _build1(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradient Cards'),
      ),
      body: ListView.builder(
        itemCount: _leadList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                      gradient: LinearGradient(colors: [
                        items[0].startColor,
                        items[0].endColor
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: items[0].endColor,
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: CustomPaint(
                      size: const Size(100, 150),
                      painter: CustomCardShapePainter(_borderRadius,
                          items[0].startColor, items[0].endColor),
                    ),
                  ),
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            'assets/icon.png',
                            height: 64,
                            width: 64,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FxText(
                                _leadList[index].title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              FxText(
                                _leadList[index].vin,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      _leadList[index].updateDate.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "3.5",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              RatingBar(rating: 3.5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _build(BuildContext context) {
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
              padding:
                  const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey[100],
                      child: TextField(
                          onSubmitted: (text) {
                            _searchLeadSession(context, text);
                          },
                          decoration: InputDecoration(
                            hintText: "VIN or Last Six",
                            border: theme.inputDecorationTheme.border,
                            enabledBorder: theme.inputDecorationTheme.border,
                            focusedBorder:
                                theme.inputDecorationTheme.focusedBorder,
                            prefixIcon: const Icon(MdiIcons.numeric, size: 24),
                          )),
                    ),
                  ),
                ],
              ),
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
        separatorBuilder: (_, __) => Divider(
              height: 0.5,
              color: theme.dividerColor,
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

class _SearchWidget extends StatelessWidget {
  _pickDate(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FxContainer.bordered(
      marginAll: 0,
      color: Colors.transparent,
      paddingAll: 0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextFormField(
                  style: FxTextStyle.sh2(
                    fontWeight: 500,
                  ),
                  decoration: InputDecoration(
                    hintStyle: FxTextStyle.sh2(fontWeight: 500),
                    hintText: "Hotels near me",
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: Icon(
                      MdiIcons.magnify,
                      size: 22,
                      color: theme.colorScheme.onBackground,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 14),
                  ),
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.sentences,
                  controller: TextEditingController(text: ""),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SingleVehicleItem extends StatefulWidget {
  final String name, address, image;
  final int price;
  final double rating;
  final BuildContext buildContext;

  const _SingleVehicleItem(
      {Key? key,
        required this.name,
        required this.address,
        required this.image,
        required this.price,
        required this.rating,
        required this.buildContext})
      : super(key: key);

  @override
  _SingleVehicleItemState createState() => _SingleVehicleItemState();
}

class _SingleVehicleItemState extends State<_SingleVehicleItem> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            widget.buildContext,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                transitionsBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child,
                    ) =>
                    FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                pageBuilder: (_, __, ___) => VehicleScreen()));
      },
      child: Card(
        elevation: 8,
        child: FxContainer(
          paddingAll: 0,
          borderRadiusAll: 4,
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                  child: SizedBox(
                    width:300,
                    height: 200,
                    child: Image(image: AssetImage(widget.image)),
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FxText.sh1(widget.name, fontWeight: 600),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  MdiIcons.shopping,
                                  color: theme.colorScheme.onBackground,
                                  size: 14,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: FxText.caption("\$" + widget.price.toString(),
                                        fontSize: 14,
                                        fontWeight: 500)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  MdiIcons.mapMarker,
                                  color: theme.colorScheme.onBackground,
                                  size: 14,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: FxText.caption(widget.address,
                                        fontSize: 14,
                                        fontWeight: 500)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  MdiIcons.star,
                                  color: theme.colorScheme.onBackground,
                                  size: 14,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  child: FxText.caption(
                                      widget.rating.toString() + " CR",
                                      fontSize: 14,
                                      fontWeight: 500),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: [
                                Icon(
                                  MdiIcons.shopping,
                                  color: theme.colorScheme.onBackground,
                                  size: 14,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: FxText.caption("\$" + widget.price.toString(),
                                        fontSize: 14,
                                        fontWeight: 500)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  MdiIcons.mapMarker,
                                  color: theme.colorScheme.onBackground,
                                  size: 14,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: FxText.caption(widget.address,
                                        fontSize: 14,
                                        fontWeight: 500)),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                Icon(
                                  MdiIcons.star,
                                  color: theme.colorScheme.onBackground,
                                  size: 14,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  child: FxText.caption(
                                      widget.rating.toString() + " CR",
                                      fontSize: 14,
                                      fontWeight: 500),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VehicleScreen extends StatefulWidget {
  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen>
    with TickerProviderStateMixin {
  int _currentPage = 0, _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);

  late Timer timerAnimation;
  late CustomTheme customTheme;
  late ThemeData theme;

  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    timerAnimation = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    timerAnimation.cancel();
    _pageController.dispose();
  }

  final String _aboutText =
      "Lorem ipsum is a pseudo-Latin text used in web design, typography, layout, and printing in place of English to emphasise design elements over content. It's also called placeholder (or filler) text. It's a convenient tool for mock-ups.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: PageView(
                    pageSnapping: true,
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Image(
                        image: const AssetImage(
                            'assets/room-1.jpg'),
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        child: Image(
                          image: const AssetImage(
                              'assets/room-2.jpg'),
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        child: Image(
                          image: const AssetImage(
                              'assets/room-3.jpg'),
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 24,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      MdiIcons.chevronLeft,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FxText.sh1("Mandarin Oriental",
                            fontWeight: 600, letterSpacing: 0),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                MdiIcons.mapMarker,
                                color: theme.colorScheme.onBackground,
                                size: 16,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  child: FxText.caption("London bridge",
                                      fontWeight: 500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: Material(
                          color: theme.colorScheme.primary.withAlpha(24),
                          child: InkWell(
                            splashColor:
                            theme.colorScheme.primary.withAlpha(100),
                            highlightColor:
                            theme.primaryColor.withAlpha(20),
                            child: SizedBox(
                                width: 44,
                                height: 44,
                                child: Icon(
                                  MdiIcons.shareOutline,
                                  size: 22,
                                  color: theme.colorScheme.primary
                                      .withAlpha(240),
                                )),
                            onTap: () {},
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: ClipOval(
                          child: Material(
                            color: theme.colorScheme.primary.withAlpha(24),
                            child: InkWell(
                              highlightColor:
                              theme.primaryColor.withAlpha(20),
                              splashColor:
                              theme.primaryColor.withAlpha(100),
                              child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Icon(
                                    MdiIcons.heartOutline,
                                    size: 20,
                                    color: theme.colorScheme.primary,
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FxText.b2("Price", fontWeight: 500),
                      FxText.b2("350 \$", fontWeight: 700)
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FxText.b2("Rating", fontWeight: 500),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FxText.b2("4.6", fontWeight: 700),
                            Container(
                                margin: const EdgeInsets.only(left: 4),
                                child:
                                const FxStarRating(rating: 4.1))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, left: 8, right: 8),
              child: Column(
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Expanded(
                          child: _FacilityWidget(
                            iconData: MdiIcons.currencyUsd,
                            text: "Low Cost",
                          )),
                      Expanded(
                          child: _FacilityWidget(
                            iconData: MdiIcons.car,
                            text: "Parking",
                          )),
                      Expanded(
                          child: _FacilityWidget(
                            iconData: MdiIcons.partyPopper,
                            text: "Party",
                          )),
                      Expanded(
                          child: _FacilityWidget(
                            iconData: MdiIcons.theater,
                            text: "Theater",
                          )),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: const <Widget>[
                        Expanded(
                            child: _FacilityWidget(
                              iconData: MdiIcons.glassWine,
                              text: "Bar",
                            )),
                        Expanded(
                            child: _FacilityWidget(
                              iconData: MdiIcons.pool,
                              text: "Pool",
                            )),
                        Expanded(
                            child: _FacilityWidget(
                              iconData: MdiIcons.spa,
                              text: "Spa",
                            )),
                        Expanded(
                            child: _FacilityWidget(
                              iconData: MdiIcons.gamepad,
                              text: "Games",
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.sh1("About", fontWeight: 600),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: FxText.b2(_aboutText, fontWeight: 500))
                ],
              ),
            ),
          ],
        ));
  }
}

class _FacilityWidget extends StatelessWidget {
  final IconData iconData;
  final String text;

  const _FacilityWidget({Key? key, required this.iconData, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FxContainer.bordered(
      margin: EdgeInsets.only(left: 8, right: 8),
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              color: theme.colorScheme.primary,
              size: 28,
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: FxText.caption(text,
                  letterSpacing: 0,
                  fontWeight: 600,
                  color: theme.colorScheme.onBackground),
            )
          ],
        ),
      ),
    );
  }
}
