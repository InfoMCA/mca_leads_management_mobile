import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';

class QuestionListDialog extends StatefulWidget {
  const QuestionListDialog({Key? key}) : super(key: key);

  @override
  _QuestionListDialogState createState() => _QuestionListDialogState();
}

class _QuestionListDialogState extends State<QuestionListDialog> {
  List<int> _list = List.generate(20, (i) => i);
  List<bool> _selected = List.generate(20, (i) => false);
  bool _isSelectable = false;

  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              FeatherIcons.chevronLeft,
              size: 20,
            ),
          ),
          title: FxText.sh1("Questions", fontWeight: 600),
        ),
        body: Container(
          child: ListView.separated(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return Ink(
                  color: _selected[index]
                      ? theme.colorScheme.primary
                      : theme.backgroundColor,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _selected[index]
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.secondary.withAlpha(240),
                      child: _selected[index]
                          ? Icon(
                              Icons.done,
                              color: theme.colorScheme.onSecondary,
                            )
                          : FxText.b1(_list[index].toString(),
                              fontWeight: 600,
                              color: _selected[index]
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSecondary),
                    ),
                    subtitle: FxText.b2('Sub Item',
                        fontWeight: 500,
                        color: _selected[index]
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                    title: FxText.b1('Item - ' + _list[index].toString(),
                        fontWeight: 600,
                        color: _selected[index]
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onBackground),
                    onTap: () => {
                      if (_isSelectable)
                        {
                          setState(() {
                            _selected[index] = !_selected[index];
                          })
                        },
                      if (_selected.indexOf(true) == -1)
                        {
                          setState(() {
                            _isSelectable = false;
                          })
                        }
                    },
                    onLongPress: (() => setState(() => {
                          if (_isSelectable)
                            {_selected[index] = true}
                          else
                            {_isSelectable = true, _selected[index] = true}
                        })),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(
                    height: 0.5,
                    color: theme.dividerColor,
                  )),
        ));
  }
}
