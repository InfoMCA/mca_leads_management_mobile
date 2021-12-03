// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// There are mainly 13 types of Text widgets.
/// h1,h2,h3,h4,h5,h6,sh1,sh2,b1,b2,button,caption,overline - This is the order of its size.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/text_style.dart';

class FxDateText extends StatefulWidget {
    final String label;
    final DateTime initValue;
    final ValueChanged<DateTime> onDateChanged;
    final FormFieldValidator<String>? validator;
    const FxDateText({Key? key, required this.label, required this.initValue, required this.onDateChanged, this.validator}) : super(key: key);

    @override
    _FxDateTextState createState() => _FxDateTextState();
}

class _FxDateTextState extends State<FxDateText> {
    late CustomTheme customTheme;
    late ThemeData theme;
    late DateTime dateTime;
    final _controller = TextEditingController();

    Future<void> _selectDate(BuildContext context) async {
        final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: widget.initValue,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 60)));
        if (pickedDate != null) {
            setState(() {
                dateTime = pickedDate;
                _controller.text =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                widget.onDateChanged(dateTime);
            });
        }
    }


    @override
    void initState() {
        super.initState();
        customTheme = AppTheme.customTheme;
        theme = AppTheme.theme;
    }

    @override
    Widget build(BuildContext context) {
        return TextFormField(
            controller: _controller,
            readOnly: true,
            onTap: () => _selectDate(context),
            validator: widget.validator,
            decoration: InputDecoration(
                labelText: widget.label,
                border: theme.inputDecorationTheme.border,
                enabledBorder: theme.inputDecorationTheme.border,
                focusedBorder:
                theme.inputDecorationTheme.focusedBorder,
                prefixIcon: const Icon(MdiIcons.calendar,
                    size: 24),
            ));
    }
}
