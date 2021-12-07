
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/select_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/time_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:us_states/us_states.dart';

class LeadScheduleView extends StatefulWidget {
  final Lead lead;
  static String routeName = '/home/lead-schedule';
  const LeadScheduleView({Key? key, required this.lead}) : super(key: key);

  @override
  _LeadScheduleViewState createState() => _LeadScheduleViewState();
}

class _LeadScheduleViewState extends State<LeadScheduleView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  final regionController = TextEditingController();
  final FocusNode _focus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late List<String> inspectors = [];
  late String inspector;
  late int inspectionTime;
  late DateTime scheduleDate;
  late TimeOfDay scheduleTime;
  late String state;


  Future<void> _getInspector() async {
    try {
      inspectors.clear();
      regionController.text = '';
      inspector = '';
      BackendResp backendResp = await BackendInterface().getInspectors(
          widget.lead.zipCode!);
      setState(() {
        inspectors.addAll(backendResp.inspectors!
            .where((element) => element.isNotEmpty).toList());
        regionController.text = backendResp.region!;
      });
    } catch (e, s) {
      showSnackBar(context: context,
          text: 'There is no inspector working in the selected area');
    }
  }

  _validate(value,) {
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

  void _onFocusChange() async {
    if (!_focus.hasFocus) {
      _getInspector();
    }
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _focus.addListener(_onFocusChange);
    scheduleTime = TimeOfDay.now();
    scheduleDate = DateTime.now();
    regionController.text = widget.lead.region!;
    state = widget.lead.state!;
    _getInspector();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
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
                  onTap: () => _makePhoneCall(widget.lead.mobileNumber),
                  child: Icon(
                    Icons.phone,
                    color: theme.backgroundColor,
                  ),
                ),
              ),
            ],
            title:
            FxText.sh1(widget.lead.name, fontWeight: 600,
                color: theme.backgroundColor),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  showSnackBar(
                      context: context, text: 'Information is not completed!');
                } else {
                  scheduleDate = DateTime(
                      scheduleDate.year, scheduleDate.month, scheduleDate.day,
                      scheduleTime.hour, scheduleTime.minute);
                  BackendInterface().dispatchLead(
                      widget.lead, inspector, inspectionTime, scheduleDate);
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
                    padding: const EdgeInsets.only(top: 20),
                    child: FxText.sh1("Customer Information", fontWeight: 600),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      initialValue: widget.lead.customerName,
                      onChanged: (text) => widget.lead.customerName = text,
                      validator: (value) => _validate(value),
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
                      initialValue: widget.lead.address1 ?? "",
                      onChanged: (text) => widget.lead.address1 = text,
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: "Address1",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.map, size: 24),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      initialValue: widget.lead.address2 ?? "",
                      onChanged: (text) => widget.lead.address2 = text,
                      decoration: InputDecoration(
                        labelText: "Address2",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.mapMarker, size: 24),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      initialValue: widget.lead.city,
                      onChanged: (text) => widget.lead.city = text,
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: "City",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.city, size: 24),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: FxListText(label: 'State',
                          initialValue: state,
                          values: USStates.getAllAbbreviations(),
                          onListChanged: (newState) {
                            widget.lead.state = newState;
                          },
                          validator: (value) => _validate(value))
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      focusNode: _focus,
                      initialValue: widget.lead.zipCode,
                      onChanged: (text) => widget.lead.zipCode = text,
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: "Zipcode",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.codeArray, size: 24),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      readOnly: true,
                      controller: regionController,
                      onChanged: (text) => widget.lead.region = text,
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: "Region",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.qrcodeRemove, size: 24),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: FxText.sh1("Service Information", fontWeight: 600),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: FxListText(label: 'Inspector',
                      initialValue: inspector,
                      values: inspectors,
                      onListChanged: (newState) {
                        inspector = newState;
                      },
                      validator: (value) => _validate(value))
                  ),
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
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.gamepadCircleOutline, size: 24),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: FxDateText(label: 'Schedule Date',
                          initValue: DateTime.now(),
                          onDateChanged: (newDate) => scheduleDate = newDate,
                          validator: (value) => _validate(value))
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: FxTimeText(label: 'Schedule Time',
                          initValue: TimeOfDay.now(),
                          onTimeChanged: (newTime) => scheduleTime = newTime,
                          validator: (value) => _validate(value))
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
