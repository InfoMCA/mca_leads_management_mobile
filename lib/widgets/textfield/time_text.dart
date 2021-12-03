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

class FxTimeText extends StatefulWidget {
    final String label;
    final TimeOfDay initValue;
    final ValueChanged<TimeOfDay> onTimeChanged;
    final FormFieldValidator<String>? validator;

    const FxTimeText(
        {Key? key, required this.label, required this.initValue, required this.onTimeChanged, this.validator})
        : super(key: key);

    @override
    _FxTimeTextState createState() => _FxTimeTextState();
}

class _FxTimeTextState extends State<FxTimeText> {
    late CustomTheme customTheme;
    late ThemeData theme;
    late TimeOfDay timeOfDay;
    final _controller = TextEditingController();

    String _getTimeString(TimeOfDay time) {
        DateTime now = DateTime.now();
        DateTime dateTime = DateTime(
            now.year, now.month, now.day, time.hour, time.minute);
        return DateFormat("HH:mm").format(dateTime);
    }

    Future<void> _selectTime() async {
        final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: widget.initValue);
        if (result != null) {
            setState(() {
                timeOfDay = result;
                _controller.text = _getTimeString(result);
                widget.onTimeChanged(result);
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
            onTap: () => _selectTime(),
            validator: widget.validator,
            decoration: InputDecoration(
                labelText: widget.label,
                border: theme.inputDecorationTheme.border,
                enabledBorder: theme.inputDecorationTheme.border,
                focusedBorder:
                theme.inputDecorationTheme.focusedBorder,
                prefixIcon: const Icon(MdiIcons.clock,
                    size: 24),
            ));
    }
}
