import 'package:collection/src/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/text_style.dart';
import 'package:mca_leads_management_mobile/widgets/button/button.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';

class LeadLostDialog extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  const LeadLostDialog({Key? key, required this.onSubmit}) : super(key: key);
  @override
  _LeadLostDialogState createState() => _LeadLostDialogState();
}

class _LeadLostDialogState extends State<LeadLostDialog> {
  late CustomTheme customTheme;
  late ThemeData theme;
  String lostReason = "Asking price too high";
  List<String> lostReasons = [
    "Asking price too high",
    "Bad carfax/Title Issue",
    "Already Sold",
    "High Mileage",
    "Others"
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        style:
                            FxTextStyle.b1(fontWeight: 500, letterSpacing: 0.2),
                        children: const <TextSpan>[
                          TextSpan(text: "Please update call status"),
                        ]),
                  ),
                )
              ],
            ),
            Column(
                children: lostReasons
                    .mapIndexed((index, element) => ListTile(
                          title: FxText.sh2(element, fontWeight: 600),
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          leading: Radio(
                            value: index,
                            activeColor: theme.colorScheme.primary,
                            groupValue: _selectedIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedIndex = value!;
                              });
                            },
                          ),
                        ))
                    .toList()),
            Container(
                margin: const EdgeInsets.only(top: 8),
                alignment: AlignmentDirectional.centerEnd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FxButton.text(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: FxText.b2("Cancel",
                            fontWeight: 600,
                            color: theme.colorScheme.primary,
                            letterSpacing: 0.4)),
                    FxButton(
                        elevation: 2,
                        borderRadiusAll: 4,
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onSubmit(lostReasons[_selectedIndex]);
                        },
                        child: FxText.b2("Submit",
                            fontWeight: 600,
                            letterSpacing: 0.4,
                            color: theme.colorScheme.onPrimary)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
