import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/models/entities/api/lead/lead_req.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/text_style.dart';
import 'package:mca_leads_management_mobile/widgets/button/button.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class LeadUnAnsweredDialog extends StatefulWidget {
  final ValueChanged<LeadUnAnsweredInfo> onSubmit;

  const LeadUnAnsweredDialog({Key? key, required this.onSubmit}) : super(key: key);
  @override
  _LeadUnAnsweredDialogState createState() => _LeadUnAnsweredDialogState();
}

class _LeadUnAnsweredDialogState extends State<LeadUnAnsweredDialog> {

  late CustomTheme customTheme;
  late ThemeData theme;
  LeadUnAnsweredInfo unAnsweredInfo = LeadUnAnsweredInfo(currentUser!.username, false, false);

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
            Row(
              children: <Widget>[
                Checkbox(
                  activeColor: theme.colorScheme.primary,
                  value: unAnsweredInfo.sendSms,
                  onChanged: (bool? value) {
                    setState(() {
                      unAnsweredInfo.sendSms = value!;
                    });
                  },
                ),
                FxText.sh2("Send SMS", fontWeight: 600)
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: unAnsweredInfo.leftMessage,
                  activeColor: theme.colorScheme.primary,
                  onChanged: (bool? value) {
                    setState(() {
                      unAnsweredInfo.leftMessage = value!;
                    });
                  },
                ),
                FxText.sh2("Left Voice Message",
                    fontWeight: 600)
              ],
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
                            Navigator.popUntil(
                                context, ModalRoute.withName('/home'));
                            widget.onSubmit(unAnsweredInfo);
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
