/*
* File : Personal Information Form
* Version : 1.0.0
* */

import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_schedule_view.dart';
import 'package:mca_leads_management_mobile/widgets/button/button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:collection/collection.dart';

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
                  lead!.name,
                  fontWeight: 600,
                  color: theme.backgroundColor,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  child: Icon(
                    MdiIcons.cloudQuestion,
                    size: 26,
                    color: theme.colorScheme.onPrimary,
                  ),
                  elevation: 2,
                  backgroundColor:
                      theme.floatingActionButtonTheme.backgroundColor),
              body: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Container(
                      padding: FxSpacing.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 0, right: 20, top: 0, bottom: 12),
                            child: FxText.sh1("Vehicle Information",
                                fontWeight: 600),
                          ),
                          TextFormField(
                            initialValue: lead!.name,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Title",
                              border: theme.inputDecorationTheme.border,
                              enabledBorder: theme.inputDecorationTheme.border,
                              focusedBorder:
                                  theme.inputDecorationTheme.focusedBorder,
                              prefixIcon:
                                  const Icon(Icons.perm_identity, size: 24),
                            ),
                          ),
                          TextFormField(
                            initialValue: lead!.vin,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "VIN",
                              border: theme.inputDecorationTheme.border,
                              enabledBorder: theme.inputDecorationTheme.border,
                              focusedBorder:
                                  theme.inputDecorationTheme.focusedBorder,
                              prefixIcon: const Icon(
                                  Icons.confirmation_number_outlined,
                                  size: 24),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              initialValue: lead!.color,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Color",
                                border: theme.inputDecorationTheme.border,
                                enabledBorder:
                                    theme.inputDecorationTheme.border,
                                focusedBorder:
                                    theme.inputDecorationTheme.focusedBorder,
                                prefixIcon: const Icon(
                                    Icons.color_lens_outlined,
                                    size: 24),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: lead!.mileage.toString(),
                              decoration: InputDecoration(
                                labelText: "Mileage",
                                border: theme.inputDecorationTheme.border,
                                enabledBorder:
                                    theme.inputDecorationTheme.border,
                                focusedBorder:
                                    theme.inputDecorationTheme.focusedBorder,
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
                              initialValue: lead!.estimatedCr.toString(),
                              decoration: InputDecoration(
                                labelText: "Estimated CR",
                                border: theme.inputDecorationTheme.border,
                                enabledBorder:
                                    theme.inputDecorationTheme.border,
                                focusedBorder:
                                    theme.inputDecorationTheme.focusedBorder,
                                prefixIcon: const Icon(
                                  Icons.high_quality,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: FxText.sh1("Price Details", fontWeight: 600),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: lead!.askingPrice.toString(),
                              decoration: InputDecoration(
                                labelText: "Listing Price",
                                border: theme.inputDecorationTheme.border,
                                enabledBorder:
                                    theme.inputDecorationTheme.border,
                                focusedBorder:
                                    theme.inputDecorationTheme.focusedBorder,
                                prefixIcon: const Icon(
                                  Icons.list,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              readOnly: true,
                              initialValue: lead!.mmr.toString(),
                              decoration: InputDecoration(
                                labelText: "MMR",
                                border: theme.inputDecorationTheme.border,
                                enabledBorder:
                                    theme.inputDecorationTheme.border,
                                focusedBorder:
                                    theme.inputDecorationTheme.focusedBorder,
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
                              initialValue:
                                  (lead!.offeredPrice ?? 0).toString(),
                              decoration: InputDecoration(
                                labelText: "Offered Price",
                                border: theme.inputDecorationTheme.border,
                                enabledBorder:
                                    theme.inputDecorationTheme.border,
                                focusedBorder:
                                    theme.inputDecorationTheme.focusedBorder,
                                prefixIcon: const Icon(
                                  Icons.price_change_outlined,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              initialValue:
                                  (lead!.requestedPrice ?? 0).toString(),
                              decoration: InputDecoration(
                                labelText: "Requested Price",
                                border: theme.inputDecorationTheme.border,
                                enabledBorder:
                                    theme.inputDecorationTheme.border,
                                focusedBorder:
                                    theme.inputDecorationTheme.focusedBorder,
                                prefixIcon: const Icon(
                                  Icons.price_change,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: FxText.sh1("Customer Information",
                                fontWeight: 600),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              initialValue: lead!.customerName ?? "",
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
                              initialValue: lead!.payoffStatus ?? "",
                              decoration: InputDecoration(
                                labelText: "Payoff Status",
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
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Comment",
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
                    ),
                  )));
        });
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
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, LeadScheduleView.routeName,
                              arguments: lead);
                        },
                        child: Icon(MdiIcons.calendar,
                            size: 32,
                            color: theme.colorScheme.primaryVariant
                                .withAlpha(220))),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _showFollowUpDialog(context);
                        },
                        child: Icon(MdiIcons.phoneCheck,
                            size: 32,
                            color: theme.colorScheme.primaryVariant
                                .withAlpha(220))),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _showUnansweredDialog(context);
                        },
                        child: Icon(MdiIcons.phoneMissed,
                            size: 32,
                            color: theme.colorScheme.primaryVariant
                                .withAlpha(220))),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _showLostDialog(context);
                        },
                        child: Icon(MdiIcons.delete,
                            size: 32,
                            color: theme.colorScheme.primaryVariant
                                .withAlpha(220))),
                    InkWell(
                      child: Icon(MdiIcons.accountQuestion,
                          size: 32,
                          color:
                              theme.colorScheme.primaryVariant.withAlpha(220)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/home'));
                      },
                      child: Icon(MdiIcons.contentSave,
                          size: 32,
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

  _pickDate(BuildContext context) async {
    showDatePicker(
            context: context,
            initialDate: selectedDate!,
            firstDate: DateTime(2015, 8),
            lastDate: DateTime(2101))
        .then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
          followupDateController.text = DateFormat('yyyy-MM-dd').format(value);
        });
      }
    });
  }

  void _showFollowUpDialog(context) {
    String comment = '';
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        onChanged: (text) => comment = text,
                        decoration: InputDecoration(
                          labelText: "Comment",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(MdiIcons.gamepadCircleOutline,
                              size: 24),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: TextFormField(
                          controller: followupDateController,
                          readOnly: true,
                          onTap: () => _pickDate(context),
                          decoration: InputDecoration(
                            labelText: "FollowUp Date",
                            border: theme.inputDecorationTheme.border,
                            enabledBorder: theme.inputDecorationTheme.border,
                            focusedBorder:
                                theme.inputDecorationTheme.focusedBorder,
                            prefixIcon: const Icon(MdiIcons.calendar, size: 24),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FxButton.rounded(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                BackendInterface().putLeadAsFollowUp(
                                    lead!.id,
                                    selectedDate!,
                                    comment);
                              },
                              child: FxText.button(
                                "Confirm",
                                color: theme.colorScheme.onPrimary,
                              )),
                          FxButton.rounded(
                              onPressed: () => Navigator.pop(context),
                              child: FxText.button("Cancel"),
                              backgroundColor: theme.colorScheme.onSecondary),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showUnansweredDialog(context) {
    bool? _sms = false, _voice = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) => Container(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  activeColor: theme.colorScheme.primary,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _sms = value;
                                    });
                                  },
                                  value: _sms,
                                ),
                                FxText.sh2("Send SMS", fontWeight: 600)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _voice,
                                  activeColor: theme.colorScheme.primary,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _voice = value;
                                    });
                                  },
                                ),
                                FxText.sh2("Left Voice Message",
                                    fontWeight: 600)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FxButton.rounded(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        BackendInterface().putLeadAsUnAnswered(
                                            lead!.id, _sms!, _voice!);
                                      },
                                      child: FxText.button(
                                        "Confirm",
                                        color: theme.colorScheme.onPrimary,
                                      )),
                                  FxButton.rounded(
                                      onPressed: () => Navigator.pop(context),
                                      child: FxText.button("Cancel"),
                                      backgroundColor:
                                          theme.colorScheme.onSecondary),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        });
  }

  void _showLostDialog(context) {
    List<String> lostReasons = [
      "Asking price too high",
      "Bad carfax/Title Issue",
      "Already Sold",
      "High Mileage",
      "Others"
    ];
    int? _selectedIndex = 0;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) => Container(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                                children: lostReasons
                                    .mapIndexed((index, element) => ListTile(
                                          title: FxText.sh2(element,
                                              fontWeight: 600),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                          leading: Radio(
                                            value: index,
                                            activeColor:
                                                theme.colorScheme.primary,
                                            groupValue: _selectedIndex,
                                            onChanged: (int? value) {
                                              setState(() {
                                                _selectedIndex = value;
                                              });
                                            },
                                          ),
                                        ))
                                    .toList()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FxButton.rounded(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        BackendInterface().putLeadAsLost(
                                            lead!.id,
                                            lostReasons[_selectedIndex!]);
                                      },
                                      child: FxText.button(
                                        "Confirm",
                                        color: theme.colorScheme.onPrimary,
                                      )),
                                  FxButton.rounded(
                                      onPressed: () => Navigator.pop(context),
                                      child: FxText.button("Cancel"),
                                      backgroundColor:
                                          theme.colorScheme.onSecondary),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        });
  }
}
