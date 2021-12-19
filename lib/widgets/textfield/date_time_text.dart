// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// There are mainly 13 types of Text widgets.
/// h1,h2,h3,h4,h5,h6,sh1,sh2,b1,b2,button,caption,overline - This is the order of its size.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class FxDateTimeText extends StatefulWidget {
  final String label;
  final DateTime? maxValue;
  final ValueChanged<DateTime> onDateChanged;
  final FormFieldValidator<String>? validator;

  const FxDateTimeText(
      {Key? key,
      required this.label,
      required this.maxValue,
      required this.onDateChanged,
      this.validator})
      : super(key: key);

  @override
  _FxDateTimeTextState createState() => _FxDateTimeTextState();
}

class _FxDateTimeTextState extends State<FxDateTimeText> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late DateTime dateTime;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _controller.text = DateFormat('yyyy-MM-dd hh:mm aaa')
        .format(DateTime.now().add(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _controller,
        readOnly: true,
        onTap: () {
          DatePicker.showDateTimePicker(context,
              showTitleActions: true,
              minTime: DateTime.now().add(const Duration(days: 1)),
              maxTime: widget.maxValue, onConfirm: (date) {
            _controller.text = DateFormat('yyyy-MM-dd hh:mm aaa').format(date);
            widget.onDateChanged(date);
          });
        },
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          border: theme.inputDecorationTheme.border,
          enabledBorder: theme.inputDecorationTheme.border,
          focusedBorder: theme.inputDecorationTheme.focusedBorder,
          prefixIcon: const Icon(MdiIcons.calendar, size: 24),
        ));
  }
}
