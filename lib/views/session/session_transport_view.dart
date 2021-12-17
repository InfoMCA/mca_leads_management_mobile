import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/api/session/session_req.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/transport_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/select_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:us_states/us_states.dart';

class SessionTransportView extends StatefulWidget {
  final Session session;
  static String routeName = '/home/session-transport';
  const SessionTransportView({Key? key, required this.session})
      : super(key: key);

  @override
  _SessionTransportViewState createState() => _SessionTransportViewState();
}

class _SessionTransportViewState extends State<SessionTransportView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  final _formKey = GlobalKey<FormState>();
  final _panelsExpansionStatus = [true, false, false];
  late PutNewOrderRequest putNewOrderRequest;

  DateTime scheduleDate = DateTime.now();

  _validate(
    value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid information';
    }
    return null;
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    await launch(Uri(
      scheme: 'tel',
      path: phoneNumber,
    ).toString());
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;

    putNewOrderRequest = PutNewOrderRequest(
        'MCA',
        'GA',
        widget.session.vin,
        widget.session.title,
        '',
        TransportInfo(
            widget.session.customerName ?? '',
            '',
            widget.session.address1 ?? '',
            widget.session.address2 ?? '',
            widget.session.city,
            widget.session.state,
            widget.session.zipCode,
            widget.session.phone,
            ''),
        TransportInfo('', '', '', '', '', '', '', '', ''),
        DateTime.now().toUtc());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                FeatherIcons.chevronLeft,
                color: theme.backgroundColor,
                size: 20,
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                  onTap: () => _makePhoneCall(widget.session.phone),
                  child: Icon(
                    Icons.phone,
                    color: theme.backgroundColor,
                  ),
                ),
              ),
            ],
            title: FxText.sh1("Schedule Transport",
                fontWeight: 600, color: theme.backgroundColor),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  showSnackBar(
                      context: context,
                      text: 'Information is not completed!',
                      backgroundColor: lightColor.defaultError.primaryVariant);
                } else {
                  putNewOrderRequest.scheduledDate = scheduleDate.toUtc();
                  TransportInterface()
                      .transfer(widget.session.id, putNewOrderRequest);
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                }
              },
              child: Icon(
                MdiIcons.calendar,
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
                      margin: const EdgeInsets.only(
                          top: 16, left: 16, right: 16, bottom: 16),
                      child: FxText.sh1(widget.session.title, fontWeight: 700)),
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
                              title: FxText.b1("Vehicle Info",
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
                                  initialValue: widget.session.vin,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: "VIN",
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
                                  initialValue: widget.session.title,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: "Title",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon:
                                        const Icon(MdiIcons.map, size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue: putNewOrderRequest.notes,
                                  onChanged: (text) =>
                                      putNewOrderRequest.notes = text,
                                  decoration: InputDecoration(
                                    labelText: "Note",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon: const Icon(MdiIcons.mapMarker,
                                        size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: FxDateText(
                                      label: 'Schedule Date',
                                      initValue: DateTime.now(),
                                      onDateChanged: (newDate) =>
                                          scheduleDate = newDate,
                                      validator: (value) => _validate(value)))
                            ]),
                          ),
                          isExpanded: _panelsExpansionStatus[0]),
                      ExpansionPanel(
                          backgroundColor: Colors.grey[100],
                          canTapOnHeader: true,
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: FxText.b1("PickUp Address",
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
                                      putNewOrderRequest.source.firstName,
                                  onChanged: (text) => putNewOrderRequest
                                      .source.firstName = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Name",
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
                                  initialValue:
                                      putNewOrderRequest.source.address1,
                                  onChanged: (text) =>
                                      putNewOrderRequest.source.address2 = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Address1",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon:
                                        const Icon(MdiIcons.map, size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue:
                                      putNewOrderRequest.source.address2,
                                  onChanged: (text) =>
                                      putNewOrderRequest.source.address2 = text,
                                  decoration: InputDecoration(
                                    labelText: "Address2",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon: const Icon(MdiIcons.mapMarker,
                                        size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue: putNewOrderRequest.source.city,
                                  onChanged: (text) =>
                                      putNewOrderRequest.source.city = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "City",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon:
                                        const Icon(MdiIcons.city, size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: FxListText(
                                      label: 'State',
                                      initialValue:
                                          putNewOrderRequest.source.state,
                                      values: USStates.getAllAbbreviations(),
                                      onListChanged: (newState) {
                                        putNewOrderRequest.source.state =
                                            newState;
                                      },
                                      validator: (value) => _validate(value))),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue:
                                      putNewOrderRequest.source.zipCode,
                                  onChanged: (text) =>
                                      putNewOrderRequest.source.zipCode = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Zipcode",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon: const Icon(MdiIcons.codeArray,
                                        size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue: putNewOrderRequest.source.phone,
                                  onChanged: (text) =>
                                      putNewOrderRequest.source.phone = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Phone",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon: const Icon(
                                        MdiIcons.qrcodeRemove,
                                        size: 24),
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
                              title: FxText.b1("DropOff Address",
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
                                      putNewOrderRequest.destination.firstName,
                                  onChanged: (text) => putNewOrderRequest
                                      .destination.firstName = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Name",
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
                                  initialValue:
                                      putNewOrderRequest.destination.address1,
                                  onChanged: (text) => putNewOrderRequest
                                      .destination.address2 = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Address1",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon:
                                        const Icon(MdiIcons.map, size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue:
                                      putNewOrderRequest.destination.address2,
                                  onChanged: (text) => putNewOrderRequest
                                      .destination.address2 = text,
                                  decoration: InputDecoration(
                                    labelText: "Address2",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon: const Icon(MdiIcons.mapMarker,
                                        size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue:
                                      putNewOrderRequest.destination.city,
                                  onChanged: (text) => putNewOrderRequest
                                      .destination.city = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "City",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon:
                                        const Icon(MdiIcons.city, size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  child: FxListText(
                                      label: 'State',
                                      initialValue:
                                          putNewOrderRequest.destination.state,
                                      values: USStates.getAllAbbreviations(),
                                      onListChanged: (newState) {
                                        putNewOrderRequest.destination.state =
                                            newState;
                                      },
                                      validator: (value) => _validate(value))),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue:
                                      putNewOrderRequest.destination.zipCode,
                                  onChanged: (text) => putNewOrderRequest
                                      .destination.zipCode = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Zipcode",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon: const Icon(MdiIcons.codeArray,
                                        size: 24),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: TextFormField(
                                  initialValue:
                                      putNewOrderRequest.destination.phone,
                                  onChanged: (text) => putNewOrderRequest
                                      .destination.phone = text,
                                  validator: (value) => _validate(value),
                                  decoration: InputDecoration(
                                    labelText: "Phone",
                                    border: theme.inputDecorationTheme.border,
                                    enabledBorder:
                                        theme.inputDecorationTheme.border,
                                    focusedBorder: theme
                                        .inputDecorationTheme.focusedBorder,
                                    prefixIcon: const Icon(
                                        MdiIcons.qrcodeRemove,
                                        size: 24),
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
          )),
    );
  }
}
