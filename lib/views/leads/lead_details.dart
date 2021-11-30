/*
* File : Personal Information Form
* Version : 1.0.0
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/leads/followup_dialog.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class LeadDetails extends StatefulWidget {
  const LeadDetails({Key? key}) : super(key: key);

  @override
  _LeadDetailsState createState() => _LeadDetailsState();
}

class _LeadDetailsState extends State<LeadDetails> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  bool _switch2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              FeatherIcons.chevronLeft,
              size: 20,
            ),
          ),
          actions: const <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.phone,
              ),
            ),
          ],
          title: FxText.sh1("2018 TOYOTA RAV4 XLE", fontWeight: 600),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            child: Icon(
              MdiIcons.flashOutline,
              size: 26,
              color: theme.colorScheme.onPrimary,
            ),
            elevation: 2,
            backgroundColor: theme.floatingActionButtonTheme.backgroundColor),
        body: SingleChildScrollView(
          child: Container(
            padding: FxSpacing.nTop(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 0, right: 20, top: 0, bottom: 12),
                  child: FxText.sh1("Vehicle Information", fontWeight: 600),
                ),
                TextFormField(
                  initialValue: '12345678',
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "VIN",
                    border: theme.inputDecorationTheme.border,
                    enabledBorder: theme.inputDecorationTheme.border,
                    focusedBorder: theme.inputDecorationTheme.focusedBorder,
                    prefixIcon: const Icon(Icons.confirmation_number_outlined,
                        size: 24),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Color",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
                      prefixIcon:
                          const Icon(Icons.color_lens_outlined, size: 24),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    readOnly: true,
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
                    decoration: InputDecoration(
                      labelText: "Estimated CR",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
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
                    decoration: InputDecoration(
                      labelText: "Listing Price",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
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
                    decoration: InputDecoration(
                      labelText: "Offered Price",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
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
                    decoration: InputDecoration(
                      labelText: "Requested Price",
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
                  padding: const EdgeInsets.only(top: 20),
                  child: FxText.sh1("Customer Information", fontWeight: 600),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Customer Name",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
                      prefixIcon:
                          const Icon(MdiIcons.accountChildOutline, size: 24),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Customer Phone",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
                      prefixIcon:
                          const Icon(MdiIcons.accountChildOutline, size: 24),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Payoff Status",
                      border: theme.inputDecorationTheme.border,
                      enabledBorder: theme.inputDecorationTheme.border,
                      focusedBorder: theme.inputDecorationTheme.focusedBorder,
                      prefixIcon:
                          const Icon(MdiIcons.gamepadCircleOutline, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _showBottomSheet(context) {
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 12, bottom: 8),
                      child: FxText.caption("Actions",
                          color: theme.colorScheme.onBackground.withAlpha(200),
                          letterSpacing: 0.3,
                          fontWeight: 700),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(MdiIcons.calendar,
                          color: theme.colorScheme.onBackground.withAlpha(220)),
                      title: FxText.b1("Schedule",
                          color: theme.colorScheme.onBackground,
                          letterSpacing: 0.3,
                          fontWeight: 500),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(MdiIcons.phone,
                          color: theme.colorScheme.onBackground.withAlpha(220)),
                      title: FxText.b1("FollowUp",
                          color: theme.colorScheme.onBackground,
                          letterSpacing: 0.3,
                          fontWeight: 500),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const UnansweredDialog();
                            });
                      },
                      child: ListTile(
                        dense: true,
                        leading: Icon(MdiIcons.phoneMissed,
                            color:
                                theme.colorScheme.onBackground.withAlpha(220)),
                        title: FxText.b1("Unanswered",
                            color: theme.colorScheme.onBackground,
                            letterSpacing: 0.3,
                            fontWeight: 500),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(MdiIcons.delete,
                          color: theme.colorScheme.onBackground.withAlpha(220)),
                      title: FxText.b1("Lost",
                          color: theme.colorScheme.onBackground,
                          letterSpacing: 0.3,
                          fontWeight: 500),
                    ),
                    Divider(
                      color: theme.dividerColor,
                    ),
                    ListTile(
                      dense: true,
                      leading: Icon(MdiIcons.accountQuestion,
                          color: theme.colorScheme.onBackground.withAlpha(220)),
                      title: FxText.b1("Questions",
                          color: theme.colorScheme.onBackground,
                          letterSpacing: 0.3,
                          fontWeight: 500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/home'));
                      },
                      child: ListTile(
                        dense: true,
                        leading: Icon(MdiIcons.contentSave,
                            color:
                                theme.colorScheme.onBackground.withAlpha(220)),
                        title: FxText.b1("Save",
                            color: theme.colorScheme.onBackground,
                            letterSpacing: 0.3,
                            fontWeight: 500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showUnansweredDialog() {}
  _dismissDialog() {
    Navigator.pop(context);
  }
}
