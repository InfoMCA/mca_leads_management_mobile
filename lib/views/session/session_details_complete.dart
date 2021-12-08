/*
* File : Personal Information Form
* Version : 1.0.0
* */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/report/report.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_colors.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class SessionDetailsComplete extends StatefulWidget {
  static String routeName = '/home/sessionComplete';
  final LeadViewArguments args;

  const SessionDetailsComplete({Key? key, required this.args})
      : super(key: key);

  @override
  _SessionDetailsCompleteState createState() => _SessionDetailsCompleteState();
}

class _SessionDetailsCompleteState extends State<SessionDetailsComplete> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Session? session;
  late Future<Session?> sessionFuture;
  final List<bool> _isExpanded = [false, false, false, false];

  Future<void> _getSession(String sessionId) async {
    sessionFuture = BackendInterface().getSession(sessionId);
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
    final args =
        ModalRoute.of(context)!.settings.arguments as LeadViewArguments;

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
                session!.title,
                fontWeight: 600,
                color: theme.backgroundColor,
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                child: Icon(
                  MdiIcons.menu,
                  size: 26,
                  color: theme.colorScheme.onPrimary,
                ),
                elevation: 2,
                backgroundColor:
                    theme.floatingActionButtonTheme.backgroundColor),
            body: SingleChildScrollView(
              child: Container(
                padding: FxSpacing.all(20),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _isExpanded[index] = !isExpanded;
                    });
                  },
                  children: [
                    buildExpansionPanel(
                        header:
                            FxText.sh1("Vehicle Information", fontWeight: 600),
                        child: Column(
                          children: _buildVehicleInfo(),
                        ),
                        isExpanded: _isExpanded[0]),
                    buildExpansionPanel(
                        header: FxText.sh1("Price", fontWeight: 600),
                        child: Column(
                          children: _buildPriceInfo(),
                        ),
                        isExpanded: _isExpanded[1]),
                    buildExpansionPanel(
                        header:
                            FxText.sh1("Inspection report", fontWeight: 600),
                        child: _getInspectionReport(),
                        isExpanded: _isExpanded[2]),
                    buildExpansionPanel(
                        header: FxText.sh1("Purchase report", fontWeight: 600),
                        child: Text("tes"),
                        isExpanded: _isExpanded[2]),
                    buildExpansionPanel(
                        header:
                            FxText.sh1("Customer Information", fontWeight: 600),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: TextFormField(
                                initialValue: session!.customerName,
                                decoration: InputDecoration(
                                  labelText: "Customer Name",
                                  border: theme.inputDecorationTheme.border,
                                  enabledBorder:
                                      theme.inputDecorationTheme.border,
                                  focusedBorder:
                                      theme.inputDecorationTheme.focusedBorder,
                                  prefixIcon: const Icon(
                                      MdiIcons.accountChildOutline,
                                      size: 24),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: TextFormField(
                                initialValue: session!.phone,
                                decoration: InputDecoration(
                                  labelText: "Customer Contact",
                                  border: theme.inputDecorationTheme.border,
                                  enabledBorder:
                                      theme.inputDecorationTheme.border,
                                  focusedBorder:
                                      theme.inputDecorationTheme.focusedBorder,
                                  prefixIcon: const Icon(
                                      MdiIcons.gamepadCircleOutline,
                                      size: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                        isExpanded: _isExpanded[3])
                  ],
                ),
              ),
            ),
          );
        });
  }

  ExpansionPanel buildExpansionPanel(
      {required Widget header,
      required Widget child,
      required bool isExpanded}) {
    return ExpansionPanel(
        backgroundColor: isExpanded ? AppColors.gallery : Colors.white,
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: header,
          );
        },
        body: child,
        isExpanded: isExpanded);
  }

  List<Widget> _buildVehicleInfo() {
    return [
      TextFormField(
        initialValue: session!.vin,
        readOnly: true,
        decoration: InputDecoration(
          labelText: "VIN",
          border: theme.inputDecorationTheme.border,
          enabledBorder: theme.inputDecorationTheme.border,
          focusedBorder: theme.inputDecorationTheme.focusedBorder,
          prefixIcon: const Icon(Icons.confirmation_number_outlined, size: 24),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: session!.mileage.toString(),
          decoration: InputDecoration(
            labelText: "Mileage",
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(
              Icons.speed,
              size: 24,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: session!.color,
          decoration: InputDecoration(
            labelText: "Color",
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(Icons.color_lens_outlined, size: 24),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: "Estimated CR",
          decoration: InputDecoration(
            labelText: session!.estimatedCr.toString(),
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(
              Icons.high_quality,
              size: 24,
            ),
          ),
        ),
      )
    ];
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: 80,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton.icon(
                      label: FxText.sh1('Inventory'),
                      onPressed: () {
                        BackendInterface().sendSessionToInventory(session!.id);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.inventory,
                          size: 26,
                          color:
                              theme.colorScheme.primaryVariant.withAlpha(220)),
                    ),
                    TextButton.icon(
                      label: FxText.sh1('Transfer'),
                      onPressed: () {},
                      icon: Icon(Icons.emoji_transportation,
                          size: 26,
                          color:
                              theme.colorScheme.primaryVariant.withAlpha(220)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  List<Widget> _buildPriceInfo() {
    return [
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: session!.mmr.toString(),
          decoration: InputDecoration(
            labelText: "MMR",
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(
              Icons.price_change,
              size: 24,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: ((session!.purchasedPrice ?? 0) -
                  (session!.deductionsAmount ?? 0))
              .toString(),
          decoration: InputDecoration(
            labelText: "Purchased Price",
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(
              Icons.price_change,
              size: 24,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: (session!.lenderAmount ?? 0).toString(),
          decoration: InputDecoration(
            labelText: "Lender",
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(
              Icons.price_change,
              size: 24,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: (session!.withholdingAmount ?? 0).toString(),
          decoration: InputDecoration(
            labelText: "Withholding",
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(
              Icons.price_change,
              size: 24,
            ),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: TextFormField(
          readOnly: true,
          initialValue: (session!.customerAmount ?? 0).toString(),
          decoration: InputDecoration(
            labelText: "Customer Check",
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.border,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            prefixIcon: const Icon(
              Icons.price_change,
              size: 24,
            ),
          ),
        ),
      ),
    ];
  }

  Widget _getInspectionReport() {
    return FutureBuilder(
        future: BackendInterface().getSessionObject(),
        builder: (context, snapshot) {
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
          Report report =
              Report.fromJson(json.decode(snapshot.data.toString()));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: report.reportItems.map((e) {
              if (e.responseFormat != ResponseFormat.Text || e.value.isEmpty) {
                return Container();
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      e.value,
                      style: const TextStyle(color: AppColors.alizarinCrimson),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}
