// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// There are mainly 13 types of Text widgets.
/// h1,h2,h3,h4,h5,h6,sh1,sh2,b1,b2,button,caption,overline - This is the order of its size.

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';

class FxListText extends StatefulWidget {
  final String label;
  final String initialValue;
  final List<String> values;
  final ValueChanged<String> onListChanged;
  final FormFieldValidator<String>? validator;
  const FxListText(
      {Key? key,
      required this.label,
      required this.initialValue,
      required this.values,
      required this.onListChanged,
      this.validator})
      : super(key: key);

  @override
  _FxListTextState createState() => _FxListTextState();
}

class _FxListTextState extends State<FxListText> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late DateTime dateTime;
  final _controller = TextEditingController();

  Future<void> _selectValue() async {
    final result = await Picker(
      headerDecoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      adapter: PickerDataAdapter<String>(pickerdata: widget.values),
      selecteds: [widget.values.indexOf(_controller.text)],
      changeToFirst: true,
      hideHeader: false,
    ).showModal(this.context); //_sca
    if (result != null) {
      setState(() {
        _controller.text = widget.values[result[0]];
        widget.onListChanged(_controller.text);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: _controller,
        readOnly: true,
        onTap: () => _selectValue(),
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
