import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/models/entities/marketplace/listing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/text_style.dart';
import 'package:mca_leads_management_mobile/widgets/button/button.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';

class ListingNewDialog extends StatefulWidget {
  final int initOfferPrice;
  final ValueChanged<ListingNewReq> onSubmit;

  const ListingNewDialog(
      {Key? key, required this.onSubmit, required this.initOfferPrice})
      : super(key: key);
  @override
  _ListingNewDialogState createState() => _ListingNewDialogState();
}

class _ListingNewDialogState extends State<ListingNewDialog> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late ListingNewReq listingNewReq;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    listingNewReq =
        listingNewReq = ListingNewReq(widget.initOfferPrice, DateTime.now());
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
                          TextSpan(text: "Please complete up listing detail"),
                        ]),
                  ),
                )
              ],
            ),
            const Divider(height: 8),
            TextFormField(
              initialValue: listingNewReq.offerPrice.toString(),
              keyboardType: TextInputType.number,
              onChanged: (value) => listingNewReq.offerPrice = int.parse(value),
              decoration: InputDecoration(
                labelText: "Listing Price",
                border: theme.inputDecorationTheme.border,
                enabledBorder: theme.inputDecorationTheme.border,
                focusedBorder: theme.inputDecorationTheme.focusedBorder,
                prefixIcon:
                    const Icon(Icons.confirmation_number_outlined, size: 24),
              ),
            ),
            FxDateText(
                label: 'Expiration Date',
                initValue: DateTime.now().add(const Duration(days: 2)),
                onDateChanged: (expirationDate) {
                  listingNewReq.expirationDate = expirationDate;
                }),
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
                          widget.onSubmit(listingNewReq);
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
