/*
* File : Checkbox
* Version : 1.0.0
* */
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class CheckboxWidget extends StatefulWidget {
  final List<String> values;
  final ValueChanged<List<bool>> onValueChanged;

  const CheckboxWidget({Key? key, required this.values, required this.onValueChanged}) : super(key: key);
  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  List<bool> _checks = [];

  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    widget.values.forEach((element) {
      _checks.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
          children: widget.values.mapIndexed((index, element) =>
              Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: theme.colorScheme.primary,
                    onChanged: (bool? value) {
                      setState(() {
                        _checks[index] = value!;
                        widget.onValueChanged(_checks);
                      });
                    },
                    value: _checks[index],
                  ),
                  FxText.sh2(element, fontWeight: 600)
                ],
              )).toList()
      ),
    );
  }
}
