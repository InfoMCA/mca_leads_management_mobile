import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/api/session/session_req.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/marketplace_interface.dart';
import 'package:mca_leads_management_mobile/models/interfaces/session_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class SessionActiveDetailsView extends StatefulWidget {
  final LeadViewArguments args;
  static String routeName = '/home/session-active';
  const SessionActiveDetailsView({Key? key, required this.args})
      : super(key: key);

  @override
  _SessionActiveDetailsViewState createState() =>
      _SessionActiveDetailsViewState();
}

class _SessionActiveDetailsViewState extends State<SessionActiveDetailsView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Session? session;
  late Future<Session?> sessionFuture;
  late SessionApproveRequest sessionApproveRequest;

  final _panelsExpansionStatus = [false, true, true];

  var _currentIndex = 2;

  final _controller = TextEditingController();

  Future<void> _getSession(String sessionId) async {
    sessionFuture = SessionInterface().get(sessionId);
    sessionFuture.whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getSession(widget.args.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sessionFuture,
        builder: (context, AsyncSnapshot<Session?> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
          session = snapshot.data;
          sessionApproveRequest = SessionApproveRequest(
              currentUser!.username,
              session!.customerName ?? "",
              (session!.offeredPrice ?? 0).toDouble(),
              0.0,
              0.0,
              0.0,
              0.0);
          updatePrices();
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  FeatherIcons.chevronLeft,
                  size: 20,
                  color: theme.backgroundColor,
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.phone,
                    color: theme.backgroundColor,
                  ),
                ),
              ],
              title: FxText.sh1(
                "Active Session Details",
                fontWeight: 600,
                color: theme.backgroundColor,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: lightColor.primary,
              selectedItemColor: Colors.white.withOpacity(.80),
              unselectedItemColor: Colors.white.withOpacity(.80),
              onTap: (value) {
                dev.log(value.toString());
                switch (value) {
                  case 0:
                    SessionInterface()
                        .approve(session!.id, sessionApproveRequest);
                    showSnackBar(
                        context: context,
                        text: 'The Inspection is Approved!',
                        backgroundColor:
                            lightColor.defaultError.secondaryVariant);
                    //MarketplaceInterface().sendSessionToInventory(session!.id);
                    break;
                  case 1:
                    SessionInterface().reject(session!.id);
                    showSnackBar(
                        context: context,
                        text: 'The Inspection is Rejected!',
                        backgroundColor:
                            lightColor.defaultError.secondaryVariant);
                    break;
                }
                Navigator.pop(context);

                setState(() => _currentIndex = value); // Respond to item press.
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Approve',
                  icon: Icon(Icons.thumb_up_alt_rounded),
                ),
                BottomNavigationBarItem(
                  label: 'Reject',
                  icon: Icon(Icons.thumb_down_alt_rounded),
                ),
                BottomNavigationBarItem(
                  label: 'Close',
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: FxSpacing.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 16),
                        child: FxText.sh1(session!.title, fontWeight: 700)),
                    ExpansionPanelList(
                      expandedHeaderPadding: const EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _panelsExpansionStatus[index] = !isExpanded;
                        });
                      },
                      animationDuration: const Duration(milliseconds: 500),
                      children: [
                        ExpansionPanel(
                            backgroundColor: Colors.grey[100],
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: FxText.b1("Vehicle Information",
                                    color: isExpanded
                                        ? lightColor.primary
                                        : theme.colorScheme.onBackground,
                                    fontWeight: isExpanded ? 700 : 600),
                              );
                            },
                            body: Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: session!.vin,
                                    decoration: InputDecoration(
                                      labelText: "VIN",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                          Icons.confirmation_number_outlined,
                                          size: 24),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: session!.color,
                                    decoration: InputDecoration(
                                      labelText: "Color",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                          Icons.color_lens_outlined,
                                          size: 24),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: session!.mileage.toString(),
                                    decoration: InputDecoration(
                                      labelText: "Mileage",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.speed,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        session!.estimatedCr.toString(),
                                    decoration: InputDecoration(
                                      labelText: "Estimated CR",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.high_quality,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            isExpanded: _panelsExpansionStatus[0]),
                        ExpansionPanel(
                            backgroundColor: Colors.grey[100],
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: FxText.b1("Price Information",
                                    color: isExpanded
                                        ? lightColor.primary
                                        : theme.colorScheme.onBackground,
                                    fontWeight: isExpanded ? 700 : 600),
                              );
                            },
                            body: Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        session!.askingPrice.toString(),
                                    decoration: InputDecoration(
                                      labelText: "Listing Price",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.list,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: session!.mmr.toString(),
                                    decoration: InputDecoration(
                                      labelText: "MMR",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        (session!.offeredPrice ?? 0).toString(),
                                    decoration: InputDecoration(
                                      labelText: "Offered Price",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change_outlined,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue: (session!.requestedPrice ?? 0)
                                        .toString(),
                                    decoration: InputDecoration(
                                      labelText: "Requested Price",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            isExpanded: _panelsExpansionStatus[1]),
                        ExpansionPanel(
                            backgroundColor: Colors.grey[100],
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: FxText.b1("Purchase Detail",
                                    color: isExpanded
                                        ? lightColor.primary
                                        : theme.colorScheme.onBackground,
                                    fontWeight: isExpanded ? 700 : 600),
                              );
                            },
                            body: Container(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    initialValue:
                                        sessionApproveRequest.customerName,
                                    onChanged: (text) => sessionApproveRequest
                                        .customerName = text,
                                    decoration: InputDecoration(
                                      labelText: "Customer Name",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                          MdiIcons.accountChildOutline,
                                          size: 24),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: false,
                                    initialValue: sessionApproveRequest
                                        .purchasedPrice
                                        .toString(),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        sessionApproveRequest.purchasedPrice =
                                            double.parse(text);
                                        updatePrices();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Purchased Price",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: false,
                                    initialValue: sessionApproveRequest
                                        .deductionsAmount
                                        .toString(),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        sessionApproveRequest.deductionsAmount =
                                            double.parse(text);
                                        updatePrices();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Deductions",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: false,
                                    initialValue: sessionApproveRequest
                                        .lenderAmount
                                        .toString(),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        sessionApproveRequest.lenderAmount =
                                            double.parse(text);
                                        updatePrices();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Lender",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: false,
                                    initialValue: sessionApproveRequest
                                        .withholdingAmount
                                        .toString(),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        sessionApproveRequest
                                                .withholdingAmount =
                                            double.parse(text);
                                        updatePrices();
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Withholding",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      labelText: "Customer Check",
                                      border: theme.inputDecorationTheme.border,
                                      enabledBorder:
                                          theme.inputDecorationTheme.border,
                                      focusedBorder: theme
                                          .inputDecorationTheme.focusedBorder,
                                      prefixIcon: const Icon(
                                        Icons.price_change,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            isExpanded: _panelsExpansionStatus[2]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void updatePrices() {
    sessionApproveRequest.customerAmount =
        sessionApproveRequest.purchasedPrice -
            sessionApproveRequest.deductionsAmount -
            sessionApproveRequest.lenderAmount -
            sessionApproveRequest.withholdingAmount;
    _controller.text = sessionApproveRequest.customerAmount.toString();
  }
}
