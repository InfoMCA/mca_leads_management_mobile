/*
* File : Selectable List
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class LeadsList extends StatefulWidget {
  const LeadsList({Key? key, String? leadType}) : super(key: key);

  @override
  _LeadsListState createState() => _LeadsListState();
}

class _LeadsListState extends State<LeadsList> {
  final List<int> _list = List.generate(20, (i) => i);

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
    return ListView.separated(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return Ink(
            color: theme.backgroundColor,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.secondary.withAlpha(240),
                child: FxText.b1(_list[index].toString(),
                    fontWeight: 600, color: theme.colorScheme.onSecondary),
              ),
              subtitle: FxText.b2('Sub Item',
                  fontWeight: 500, color: theme.colorScheme.onBackground),
              title: FxText.b1('Item - ' + _list[index].toString(),
                  fontWeight: 600, color: theme.colorScheme.onBackground),
              onTap: () => {Modular.to.pushNamed('/home/lead')},
            ),
          );
        },
        separatorBuilder: (_, __) => Divider(
              height: 0.5,
              color: theme.dividerColor,
            ));
  }
}
