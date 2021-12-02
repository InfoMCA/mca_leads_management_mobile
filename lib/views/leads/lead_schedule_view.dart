
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/models/entities/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
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
  final scheduleDateController = TextEditingController();
  final scheduleTimeController = TextEditingController();
  final stateController = TextEditingController();
  final inspectorController = TextEditingController();
  final regionController = TextEditingController();
  final FocusNode _focus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late List<String> inspectors = [];
  late String inspector;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)));
    if (pickedDate != null) {
      setState(() {
        scheduleDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        scheduleTimeController.text = result.format(context);
      });
    }
  }

  Future<void> _getInspector() async {
    try {
      inspectors.clear();
      regionController.text = '';
      inspectorController.text = '';

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

  Future<void> _selectInspector() async {
    final result = await Picker(
      headerDecoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16))),
      adapter: PickerDataAdapter<String>(pickerdata: inspectors),
      selecteds: [inspectors.indexOf(inspectorController.text)],
      changeToFirst: true,
      hideHeader: false,
    ).showModal(this.context); //_sca
    if (result != null) {
      setState(() {
        inspectorController.text = inspectors[result[0]];
      });
    }
  }

  Future<void> _selectState() async {
    List<String> states = USStates.getAllAbbreviations();
    final result = await Picker(
      headerDecoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16))),
      adapter: PickerDataAdapter<String>(pickerdata: states),
      selecteds: [states.indexOf(stateController.text)],
      changeToFirst: true,
      hideHeader: false,
    ).showModal(this.context); //_sca
    if (result != null) {
      setState(() {
        stateController.text = states[result[0]];
      });
    }
  }

  _validate(value,) {
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

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _focus.addListener(_onFocusChange);

    scheduleTimeController.text = TimeOfDay
        .now()
        .hour
        .toString() + ":" + TimeOfDay
        .now()
        .minute
        .toString();
    scheduleDateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    regionController.text = widget.lead.region!;
    stateController.text = widget.lead.state!;
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
                  Navigator.popUntil(context, ModalRoute.withName(
                      '/home'));
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
                    child: TextFormField(
                      readOnly: true,
                      controller: stateController,
                      onTap: () => _selectState(),
                      onChanged: (text) => widget.lead.state = text,
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: "State",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon:
                        const Icon(MdiIcons.signRealEstate, size: 24),
                      ),
                    ),
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
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => _selectInspector(),
                      controller: inspectorController,
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: "Inspectors",
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
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '30',
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
                    child: TextFormField(
                      controller: scheduleDateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: 'Schedule Date',
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder:
                        theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(MdiIcons.calendar,
                            size: 24),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                      controller: scheduleTimeController,
                      readOnly: true,
                      onTap: _selectTime,
                      validator: (value) => _validate(value),
                      decoration: InputDecoration(
                        labelText: 'Schedule time',
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder:
                        theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(MdiIcons.timelineCheckOutline,
                            size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
