import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/text_style.dart';
import 'package:mca_leads_management_mobile/widgets/button/button.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';

class OfferPriceDialog extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  const OfferPriceDialog({Key? key, required this.onSubmit}) : super(key: key);
  @override
  _OfferPriceDialogState createState() => _OfferPriceDialogState();
}

class _OfferPriceDialogState extends State<OfferPriceDialog> {

  late CustomTheme customTheme;
  late ThemeData theme;
  late String offerPrice;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    offerPrice = "";
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
                          TextSpan(text: "Please let the buyer know how much you are willing to pay?"),
                        ]),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (text) => offerPrice = text,
                decoration: InputDecoration(
                  border: theme.inputDecorationTheme.border,
                  enabledBorder:
                  theme.inputDecorationTheme.border,
                  focusedBorder:
                  theme.inputDecorationTheme.focusedBorder,
                  prefixIcon: const Icon(
                      Icons.price_check,
                      size: 24),
                ),
              ),
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
                          if (offerPrice.isEmpty) {
                            showSnackBar(context: context, text: "Offer Price is Empty!");
                          } else {
                            widget.onSubmit(offerPrice);
                            Navigator.pop(context);
                            //Navigator.popUntil(context, ModalRoute.withName('/home'));
                          }
                        },
                        child: FxText.b2("Offer",
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
