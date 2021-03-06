import 'dart:convert';
import 'dart:developer' as dev;
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/entities/lead/lead.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadQuestionView extends StatefulWidget {
  final Lead lead;
  static String routeName = '/home/lead-question';

  const LeadQuestionView({Key? key, required this.lead}) : super(key: key);

  @override
  _LeadQuestionViewState createState() => _LeadQuestionViewState();
}

class _LeadQuestionViewState extends State<LeadQuestionView> {
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

    conditionQuestion = json.decode(widget.lead.conditionQuestions ?? "");
    conditionQuestion?.forEach((k, v) => questionList?.add(k));
    conditionQuestion?.forEach((k, v) => answerList?.add(v));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    await launch(Uri(
      scheme: 'tel',
      path: phoneNumber,
    ).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkColor.primaryVariant,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            FeatherIcons.chevronLeft,
            size: 20,
            color: theme.backgroundColor,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () => _makePhoneCall(widget.lead.mobileNumber),
              child: Icon(
                Icons.phone,
                color: theme.backgroundColor,
              ),
            ),
          ),
        ],
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
                          leading: CircleAvatar(
                            backgroundColor: lightColor.secondaryVariant,
                            child: FxText.b1(
                                (questionList?[index] ?? "Q")[0].toUpperCase(),
                                fontWeight: 600,
                                color: Colors.white),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.b1(
                                  StringUtils.camelCaseToUpperUnderscore(
                                          questionList?[index] ?? "")
                                      .replaceAll("_", " "),
                                  fontWeight: 700,
                                  color: theme.colorScheme.onBackground),
                              FxText.b2(answerList?[index] ?? "",
                                  fontWeight: 600,
                                  color: theme.colorScheme.onBackground),
                            ],
                          ),
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
