/*
* File : Personal Information Form
* Version : 1.0.0
* */

import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_lost_dialog.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_schedule_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

import 'lead_followup_dialog.dart';
import 'lead_unanswered_dialog.dart';

class LeadDetailsView extends StatefulWidget {
  final LeadViewArguments args;

  const LeadDetailsView({Key? key, required this.args}) : super(key: key);

  static const routeName = '/home/lead';

  @override
  _LeadDetailsViewState createState() => _LeadDetailsViewState();
}

class _LeadDetailsViewState extends State<LeadDetailsView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Lead? lead;
  late Future<Lead?> leadFuture;
  late DateTime? selectedDate;
  final followupDateController = TextEditingController();
  late ScrollController _controller;
  int _currentIndex = 0;

  final _panelsExpansionStatus = [false, false, false];

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getLead(widget.args.id);
    selectedDate = DateTime.now();
    followupDateController.text =
        DateFormat('yyyy-MM-dd').format(selectedDate!);
  }

  Future<void> _getLead(String leadId) async {
    leadFuture = BackendInterface().getLead(leadId);
    leadFuture.whenComplete(() => setState(() {}));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    dev.log(widget.args.id);

    return FutureBuilder(
        future: leadFuture,
        builder: (context, AsyncSnapshot<Lead?> snapshot) {
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
          lead = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                backgroundColor: lightColor.primary,
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
                    child: InkWell(
                      onTap: () => _makePhoneCall(lead!.mobileNumber),
                      child: Icon(
                        Icons.phone,
                        color: theme.backgroundColor,
                      ),
                    ),
                  ),
                ],
                title: FxText.sh1(
                  "Lead Details",
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
                      Navigator.pushNamed(
                          context, LeadScheduleView.routeName,
                          arguments: lead);
                      break;
                    case 1:
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              LeadFollowUpDialog(
                                  onSubmit: (followUpInfo) {
                                    BackendInterface().putLeadAsFollowUp(
                                        lead!.id, followUpInfo);
                                  }
                              ));
                      break;
                    case 2:
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              LeadUnAnsweredDialog(
                                  onSubmit: (unansweredInfo) {
                                    BackendInterface().putLeadAsUnAnswered(
                                        lead!.id, unansweredInfo);
                                  }
                              ));
                      break;
                    case 3:
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              LeadLostDialog(
                                  onSubmit: (lostReason) {
                                    BackendInterface().putLeadAsLost(
                                        lead!.id, lostReason);
                                  }
                              ));
                      break;
                  }

                  setState(() =>
                  _currentIndex = value); // Respond to item press.
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
                ],
              ),
              body: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16, bottom: 16),
                              child: FxText.sh1(lead!.name, fontWeight: 700)
                          ),
                          ExpansionPanelList(
                            expandedHeaderPadding: const EdgeInsets.all(0),
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                _panelsExpansionStatus[index] = !isExpanded;
                              });
                            },
                            animationDuration: const Duration(
                                milliseconds: 500),
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
                                    child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 8, right: 8),
                                            child: TextFormField(
                                              readOnly: true,
                                              initialValue: lead!.vin,
                                              decoration: InputDecoration(
                                                labelText: "VIN",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
                                                prefixIcon: const Icon(
                                                    Icons
                                                        .confirmation_number_outlined,
                                                    size: 24),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 8, right: 8),
                                            child: TextFormField(
                                              initialValue: lead!.color,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                labelText: "Color",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
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
                                              initialValue: lead!.mileage
                                                  .toString(),
                                              decoration: InputDecoration(
                                                labelText: "Mileage",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
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
                                              initialValue: lead!.estimatedCr
                                                  .toString(),
                                              decoration: InputDecoration(
                                                labelText: "Estimated CR",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
                                                prefixIcon: const Icon(
                                                  Icons.high_quality,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),

                                        ]
                                    ),
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
                                    child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 8, right: 8),
                                            child: TextFormField(
                                              readOnly: true,
                                              initialValue: lead!.askingPrice
                                                  .toString(),
                                              decoration: InputDecoration(
                                                labelText: "Listing Price",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
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
                                              initialValue: lead!.mmr
                                                  .toString(),
                                              decoration: InputDecoration(
                                                labelText: "MMR",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
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
                                              initialValue:
                                              (lead!.offeredPrice ?? 0)
                                                  .toString(),
                                              decoration: InputDecoration(
                                                labelText: "Offered Price",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
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
                                              initialValue:
                                              (lead!.requestedPrice ?? 0)
                                                  .toString(),
                                              decoration: InputDecoration(
                                                labelText: "Requested Price",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
                                                prefixIcon: const Icon(
                                                  Icons.price_change,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                  isExpanded: _panelsExpansionStatus[1]),
                              ExpansionPanel(
                                  backgroundColor: Colors.grey[100],
                                  canTapOnHeader: true,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      title: FxText.b1("Customer Information",
                                          color: isExpanded
                                              ? lightColor.primary
                                              : theme.colorScheme.onBackground,
                                          fontWeight: isExpanded ? 700 : 600),
                                    );
                                  },
                                  body: Container(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 8, right: 8),
                                            child: TextFormField(
                                              initialValue: lead!
                                                  .customerName ?? "",
                                              decoration: InputDecoration(
                                                labelText: "Customer Name",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
                                                prefixIcon: const Icon(
                                                    MdiIcons
                                                        .accountChildOutline,
                                                    size: 24),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 8, right: 8),
                                            child: TextFormField(
                                              initialValue: lead!
                                                  .payoffStatus ?? "",
                                              decoration: InputDecoration(
                                                labelText: "Payoff Status",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
                                                prefixIcon: const Icon(
                                                    MdiIcons
                                                        .gamepadCircleOutline,
                                                    size: 24),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 8, right: 8),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: "Comment",
                                                border: theme
                                                    .inputDecorationTheme
                                                    .border,
                                                enabledBorder:
                                                theme.inputDecorationTheme
                                                    .border,
                                                focusedBorder:
                                                theme.inputDecorationTheme
                                                    .focusedBorder,
                                                prefixIcon: const Icon(
                                                    MdiIcons
                                                        .gamepadCircleOutline,
                                                    size: 24),
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                  isExpanded: _panelsExpansionStatus[2]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }
}
