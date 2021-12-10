import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/select_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/time_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:us_states/us_states.dart';

class SessionDetails extends StatefulWidget {
  final LeadViewArguments args;
  static String routeName = '/home/session';

  const SessionDetails({Key? key, required this.args}) : super(key: key);

  @override
  _SessionDetailsState createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Session? session;
  late Future<Session?> sessionFuture;
  final regionController = TextEditingController();
  final FocusNode _focus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late List<String> inspectors = [];
  late String inspector;
  late int inspectionTime;
  late DateTime scheduleDate;
  late TimeOfDay scheduleTime;

  var _currentIndex = 0;

  var _panelsExpansionStatus = [false, false, false, false];

  Future<void> _getInspector() async {
    try {
      inspectors.clear();
      regionController.text = '';
      inspector = '';

      BackendResp backendResp =
          await BackendInterface().getInspectors(session!.zipCode);
      setState(() {
        inspectors.addAll(backendResp.inspectors!
            .where((element) => element.isNotEmpty)
            .toList());
        regionController.text = backendResp.region!;
      });
    } catch (e, s) {
      showSnackBar(
          context: context,
          text: 'There is no inspector working in the selected area');
    }
  }

  _validate(
    value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid information';
    }
    return null;
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  void _onFocusChange() async {
    if (!_focus.hasFocus) {
      _getInspector();
    }
  }

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
                InkWell(
                  onTap: () => _makePhoneCall(session!.phone),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.phone,
                      color: theme.backgroundColor,
                    ),
                  ),
                ),
              ],
              title: FxText.sh1(
                session!.title,
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
                    Navigator.popUntil(
                        context, ModalRoute.withName('/home'));
                    break;
                  case 1:
                    Navigator.popUntil(
                        context, ModalRoute.withName('/home'));
                    break;
                  case 2:
                    Navigator.popUntil(
                        context, ModalRoute.withName('/home'));
                    break;
                }

                setState(() =>
                _currentIndex = value); // Respond to item press.
              },
              items: const [
                BottomNavigationBarItem(
                  label: 'Schedule',
                  icon: Icon(Icons.calendar_today),
                ),
                BottomNavigationBarItem(
                  label: 'Delete',
                  icon: Icon(Icons.delete),
                ),
                BottomNavigationBarItem(
                  label: 'Save',
                  icon: Icon(Icons.save),
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
                        child: FxText.sh1(session!.title, fontWeight: 700)
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
                                        initialValue: session!.vin,
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
                                        readOnly: true,
                                        initialValue: session!.color,
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
                                        initialValue: session!.mileage.toString(),
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
                                        initialValue: session!.estimatedCr.toString(),
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
                                        initialValue: session!.askingPrice.toString(),
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
                                        initialValue: session!.mmr.toString(),
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
                                        readOnly: true,
                                        initialValue: (session!.offeredPrice ?? 0).toString(),
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
                                        readOnly: true,
                                        initialValue: (session!.requestedPrice ?? 0).toString(),
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
                                title: FxText.b1("Inspection Address",
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
                                        initialValue: session!.address1,
                                        decoration: InputDecoration(
                                          labelText: "Address1",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(MdiIcons.accountChildOutline,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        initialValue: session!.address2,
                                        decoration: InputDecoration(
                                          labelText: "Address2",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(MdiIcons.accountChildOutline,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        initialValue: session!.city,
                                        decoration: InputDecoration(
                                          labelText: "City",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(MdiIcons.accountChildOutline,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 8, left: 8, right: 8),
                                        child: FxListText(
                                            label: 'State',
                                            initialValue: session!.state,
                                            values: USStates.getAllAbbreviations(),
                                            onListChanged: (newState) {
                                              session!.state = newState;
                                            },
                                            validator: (value) => _validate(value))),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        initialValue: session!.zipCode,
                                        decoration: InputDecoration(
                                          labelText: "Zipcode",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(MdiIcons.accountChildOutline,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 8, right: 8),
                                      child: TextFormField(
                                        readOnly: true,
                                        initialValue: session!.region,
                                        decoration: InputDecoration(
                                          labelText: "Region",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(MdiIcons.accountChildOutline,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                            isExpanded: _panelsExpansionStatus[2]),
                        ExpansionPanel(
                            backgroundColor: Colors.grey[100],
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: FxText.b1("Inspection Information",
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
                                        margin: const EdgeInsets.only(top: 8),
                                        child: FxListText(
                                            label: 'Inspector',
                                            initialValue: session!.staff,
                                            values: inspectors,
                                            onListChanged: (newState) {
                                              session!.staff = newState;
                                            },
                                            validator: (value) => _validate(value))),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        initialValue: '30',
                                        onChanged: (value) => inspectionTime = int.parse(value),
                                        validator: (value) => _validate(value),
                                        decoration: InputDecoration(
                                          labelText: "Duration (min)",
                                          border: theme.inputDecorationTheme.border,
                                          enabledBorder: theme.inputDecorationTheme.border,
                                          focusedBorder:
                                          theme.inputDecorationTheme.focusedBorder,
                                          prefixIcon: const Icon(MdiIcons.gamepadCircleOutline,
                                              size: 24),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: FxDateText(
                                            label: 'Schedule Date',
                                            initValue:
                                            session?.scheduledDateTime ?? DateTime.now(),
                                            onDateChanged: (newDate) => session?.scheduledDate = newDate,
                                            validator: (value) => _validate(value))),
                                    Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: FxTimeText(
                                            label: 'Schedule Time',
                                            initValue: TimeOfDay.fromDateTime(
                                                session?.scheduledDateTime ?? DateTime.now()),
                                            onTimeChanged: (newTime) =>
                                            session?.scheduledTime = newTime,
                                            validator: (value) => _validate(value))),
                                  ]
                              ),
                            ),
                            isExpanded: _panelsExpansionStatus[3]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
