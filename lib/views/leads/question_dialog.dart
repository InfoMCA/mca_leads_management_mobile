import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mca_leads_management_mobile/models/entities/lead.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class QuestionListDialog extends StatefulWidget {
  final Lead? lead;
  const QuestionListDialog(this.lead, {Key? key}) : super(key: key);

  @override
  _QuestionListDialogState createState() => _QuestionListDialogState();
}

class _QuestionListDialogState extends State<QuestionListDialog> {
  late CustomTheme customTheme;
  late ThemeData theme;
  Map<String, dynamic>? conditionQuestion;
  List<String>? questionList = [];
  List<String>? answerList = [];

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;

    conditionQuestion = json.decode(widget.lead?.conditionQuestions ?? "");

    conditionQuestion?.forEach((k, v) => questionList?.add('${k}'));
    conditionQuestion?.forEach((k, v) => answerList?.add('${v}'));

    print(questionList);
    print(answerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            FeatherIcons.chevronLeft,
            size: 20,
            color: theme.backgroundColor,
          ),
        ),
        title: FxText.sh1(
          "Questions",
          fontWeight: 600,
          color: theme.backgroundColor,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  setState(() {});
                }
                return true;
              },
              child: ListView.separated(
                  itemCount: questionList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Material(
                      child: Ink(
                        color: theme.backgroundColor,
                        child: ListTile(
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.b2(answerList?[index] ?? "",
                                  fontSize: 13,
                                  fontWeight: 500,
                                  color: theme.colorScheme.onBackground),
                            ],
                          ),
                          title: FxText.b1(questionList?[index] ?? "",
                              fontWeight: 700,
                              color: theme.colorScheme.onBackground),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => Divider(
                        height: 0.5,
                        color: theme.dividerColor,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
