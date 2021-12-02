import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';

class ScheduleListView extends StatefulWidget {
  const ScheduleListView({Key? key}) : super(key: key);

  @override
  _ScheduleListViewState createState() => _ScheduleListViewState();
}

class _ScheduleListViewState extends State<ScheduleListView> {
  DateTime selectedDate = DateTime.now();
  String? _selectedTime;
  late CustomTheme customTheme;
  late ThemeData theme;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

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
          title: FxText.sh1("Schedule", fontWeight: 600),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: FxSpacing.nTop(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Pre-inspection Price",
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
                      labelText: "Address1",
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
                      labelText: "Address2",
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
                      labelText: "City",
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
                      labelText: "State",
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
                      labelText: "Zipcode",
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
                      labelText: "Region",
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
                      labelText: "Service",
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
                    decoration: InputDecoration(
                      labelText: "Inspection",
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
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Note",
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
                    decoration: InputDecoration(
                      labelText: "Duration",
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "${selectedDate.toLocal()}".split(' ')[0],
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(MdiIcons.timelineCheckOutline,
                              size: 24),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Schedule Date'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: _selectedTime != null
                              ? _selectedTime!
                              : 'Schedule time',
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(MdiIcons.timelineCheckOutline,
                              size: 24),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _selectTime,
                        child: const Text('Schedule time'),
                      ),
                    ],
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
