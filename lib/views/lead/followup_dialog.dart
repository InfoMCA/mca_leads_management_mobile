import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class UnansweredDialog extends StatefulWidget {
  const UnansweredDialog({Key? key}) : super(key: key);

  @override
  _UnansweredDialogState createState() => _UnansweredDialogState();
}


class _UnansweredDialogState extends State<UnansweredDialog> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    isSelected = [true, false];
  }

  late List<bool> isSelected;
  bool _switch1 = true, _switch2 = true, _switch3 = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: const EdgeInsets.all(16),
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
            MergeSemantics(
              child: ListTile(
                title: FxText.b1('Send SMS', fontWeight: 600),
                trailing: CupertinoSwitch(
                  activeColor: theme.colorScheme.primary,
                  value: _switch2,
                  onChanged: (bool value) {
                    setState(() {
                      _switch2 = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    _switch2 = !_switch2;
                  });
                },
              ),
            ),
            MergeSemantics(
              child: ListTile(
                title: FxText.b1('Left Voice Message', fontWeight: 600),
                trailing: CupertinoSwitch(
                  activeColor: theme.colorScheme.primary,
                  value: _switch3,
                  onChanged: (bool value) {
                    setState(() {
                      _switch3 = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    _switch3 = !_switch3;
                  });
                },
              ),
            ),
            Container(
                height: 64,
                alignment: AlignmentDirectional.centerEnd,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Modular.to.pushNamed('/home');
                        },
                        child: FxText.b2("Confirm",
                            letterSpacing: 0.3,
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary)),
                    ElevatedButton(
                        onPressed: () {
                          Modular.to.pop();
                        },
                        child: FxText.b2("Cancel",
                            letterSpacing: 0.3,
                            fontWeight: 600,
                            color: theme.colorScheme.onSecondary)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
