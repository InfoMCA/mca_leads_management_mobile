import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/leads/lead_view_arg.dart';
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
                backgroundColor:
                    theme.floatingActionButtonTheme.backgroundColor),
            body: SingleChildScrollView(
              child: Container(
                padding: FxSpacing.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 0, right: 20, top: 0, bottom: 12),
                      child: FxText.sh1("Vehicle Information", fontWeight: 600),
                    ),
                    TextFormField(
                      initialValue: session!.vin,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "VIN",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(
                            Icons.confirmation_number_outlined,
                            size: 24),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: session!.title,
                        decoration: InputDecoration(
                          labelText: "Title",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                              Icons.confirmation_number_outlined,
                              size: 24),
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
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon:
                              const Icon(Icons.color_lens_outlined, size: 24),
                        ),
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
                        initialValue: session!.estimatedCr.toString(),
                        decoration: InputDecoration(
                          labelText: "Estimated CR",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
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
                        initialValue: session!.askingPrice.toString(),
                        decoration: InputDecoration(
                          labelText: "Listing Price",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
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
                        initialValue: session!.mmr.toString(),
                        decoration: InputDecoration(
                          labelText: "MMR",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
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
                        readOnly: true,
                        initialValue: (session!.offeredPrice ?? 0).toString(),
                        decoration: InputDecoration(
                          labelText: "Offered Price",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
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
                        readOnly: true,
                        initialValue: (session!.requestedPrice ?? 0).toString(),
                        decoration: InputDecoration(
                          labelText: "Requested Price",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
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
                      child:
                          FxText.sh1("Customer Information", fontWeight: 600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        initialValue: session!.customerName,
                        decoration: InputDecoration(
                          labelText: "Customer Name",
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
                      margin: const EdgeInsets.only(top: 8),
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
                      margin: const EdgeInsets.only(top: 8),
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
                      margin: const EdgeInsets.only(top: 8),
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
                        margin: const EdgeInsets.only(top: 8),
                        child: FxListText(
                            label: 'State',
                            initialValue: session!.state,
                            values: USStates.getAllAbbreviations(),
                            onListChanged: (newState) {
                              session!.state = newState;
                            },
                            validator: (value) => _validate(value))),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
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
                      margin: const EdgeInsets.only(top: 8),
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
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: FxText.sh1("Service Information", fontWeight: 600),
                    ),
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
                  ],
                ),
              ),
            ),
          );
        });
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
                      leading: Icon(MdiIcons.delete,
                          color: theme.colorScheme.onBackground.withAlpha(220)),
                      title: FxText.b1("Lost",
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
