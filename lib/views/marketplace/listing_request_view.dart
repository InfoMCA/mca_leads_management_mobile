import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mca_leads_management_mobile/models/entities/api/backend_resp.dart';
import 'package:mca_leads_management_mobile/models/entities/session/session.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/spacing.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/custom_theme.dart';
import 'package:mca_leads_management_mobile/views/lead/lead_view_arg.dart';
import 'package:mca_leads_management_mobile/widgets/checkbox/checkbox_input.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/select_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/time_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:us_states/us_states.dart';

class ListingRequestView extends StatefulWidget {
  final Session args;
  static String routeName = '/home/listing-new';

  const ListingRequestView({Key? key, required this.args}) : super(key: key);

  @override
  _ListingRequestViewState createState() => _ListingRequestViewState();
}

class _ListingRequestViewState extends State<ListingRequestView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late List<String>? marketPlaces;
  late Future<List<String>> marketPlacesFuture;
  late Session session;
  late DateTime expirationDate;
  late int listingPrice;
  List<String> selectedMarketPlaces = [];

  Future<void> _getMarketPlaces(String sessionId) async {
    marketPlacesFuture = BackendInterface().getMarketPlaces(sessionId);
    marketPlacesFuture.whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    session = widget.args;
    _getMarketPlaces(session.id);
    listingPrice = ((session.purchasedPrice ?? 0) - (session.deductionsAmount ?? 0)).toInt();
    expirationDate = DateTime.now().add(const Duration(days:2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: marketPlacesFuture,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
          marketPlaces = snapshot.data;
          return Scaffold(
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
                session.title,
                fontWeight: 600,
                color: theme.backgroundColor,
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  BackendInterface().createNewListing(session.id, listingPrice, expirationDate, selectedMarketPlaces);
                },
                child: Icon(
                  Icons.check,
                  size: 26,
                  color: theme.colorScheme.onPrimary,
                ),
                elevation: 2,
                backgroundColor:
                theme.floatingActionButtonTheme.backgroundColor),
            body: SingleChildScrollView(
              child: Container(
                padding: FxSpacing.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                          left: 0, right: 20, top: 0, bottom: 12),
                      child: FxText.sh1("Listing Information", fontWeight: 600),
                    ),
                    TextFormField(
                      initialValue: listingPrice.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => listingPrice = int.parse(value),
                      decoration: InputDecoration(
                        labelText: "Listing Price",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(
                            Icons.confirmation_number_outlined,
                            size: 24),
                      ),
                    ),
                    FxDateText(label: 'Expiration Date',
                        initValue:
                        DateTime.now().add(const Duration(days: 2)),
                        onDateChanged: (expirationDate) {
                          this.expirationDate = expirationDate;
                        }),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8, right: 20, top: 20, bottom: 12),
                      child: FxText.sh1(
                        "Market Places", fontWeight: 600, fontSize: 16,),
                    ),
                    CheckboxWidget(values: marketPlaces!,
                        onValueChanged: (marketPlacesStatus) {
                          selectedMarketPlaces.clear();
                          /// ToDo improve coding.
                          for (int i = 0; i < marketPlaces!.length; i++) {
                            if (marketPlacesStatus[i]) {
                              selectedMarketPlaces.add(marketPlaces![i]);
                            }
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
