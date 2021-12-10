import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/text_style.dart';
import 'package:mca_leads_management_mobile/widgets/button/button.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';

class LeadFollowUpDialog extends StatefulWidget {
  final ValueChanged<LeadFollowUpInfo> onSubmit;

  const LeadFollowUpDialog({Key? key, required this.onSubmit}) : super(key: key);
  @override
  _LeadFollowUpDialogState createState() => _LeadFollowUpDialogState();
}

class _LeadFollowUpDialogState extends State<LeadFollowUpDialog> {

  late CustomTheme customTheme;
  late ThemeData theme;
  LeadFollowUpInfo followUpInfo = LeadFollowUpInfo("", DateTime.now());

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
                          TextSpan(text: "Please update lead information"),
                        ]),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextFormField(
                onChanged: (text) => followUpInfo.comment = text,
                decoration: InputDecoration(
                  labelText: "Comment",
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
              child: FxDateText(label: 'Followup Date',
                initValue: DateTime.now(),
                onDateChanged: (date) {
                  followUpInfo.date = date;
                },),
            ),
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
                          if (followUpInfo.comment.isEmpty) {
                            showSnackBar(
                                context: context, text: "Comment is Empty!");
                          } else {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/home'));
                            widget.onSubmit(followUpInfo);
                          }
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
