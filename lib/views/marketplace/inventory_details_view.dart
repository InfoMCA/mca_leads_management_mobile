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
import 'package:mca_leads_management_mobile/views/marketplace/listing_request_view.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';
import 'package:mca_leads_management_mobile/widgets/text/text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/date_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/select_text.dart';
import 'package:mca_leads_management_mobile/widgets/textfield/time_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:us_states/us_states.dart';

class InventoryDetailView extends StatefulWidget {
  final LeadViewArguments args;
  static String routeName = '/home/inventory';

  const InventoryDetailView({Key? key, required this.args}) : super(key: key);

  @override
  _InventoryDetailViewState createState() => _InventoryDetailViewState();
}

class _InventoryDetailViewState extends State<InventoryDetailView> {
  late CustomTheme customTheme;
  late ThemeData theme;
  late Session? session;
  late Future<Session?> sessionFuture;

  Future<void> _getSession(String sessionId) async {
    sessionFuture = BackendInterface().getSession(sessionId);
    sessionFuture.whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _getSession(widget.args.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sessionFuture,
        builder: (context, AsyncSnapshot<Session?> snapshot) {
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
          session = snapshot.data;
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
                session!.title,
                fontWeight: 600,
                color: theme.backgroundColor,
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                child: Icon(
                  MdiIcons.menu,
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
                      child: FxText.sh1("Vehicle Information", fontWeight: 600),
                    ),
                    TextFormField(
                      initialValue: session!.vin,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "VIN",
                        border: theme.inputDecorationTheme.border,
                        enabledBorder: theme.inputDecorationTheme.border,
                        focusedBorder: theme.inputDecorationTheme.focusedBorder,
                        prefixIcon: const Icon(
                            Icons.confirmation_number_outlined,
                            size: 24),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: session!.title,
                        decoration: InputDecoration(
                          labelText: "Title",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                              Icons.confirmation_number_outlined,
                              size: 24),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: session!.color,
                        decoration: InputDecoration(
                          labelText: "Color",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon:
                              const Icon(Icons.color_lens_outlined, size: 24),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: session!.mileage.toString(),
                        decoration: InputDecoration(
                          labelText: "Mileage",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                            Icons.speed,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: session!.estimatedCr.toString(),
                        decoration: InputDecoration(
                          labelText: "Estimated CR",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder:
                              theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                            Icons.high_quality,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: FxText.sh1("Purchase Details", fontWeight: 600),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: ((session!.purchasedPrice ?? 0) - (session!.deductionsAmount ?? 0)).toString(),
                        decoration: InputDecoration(
                          labelText: "Purchased Price",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder: theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                            Icons.price_change,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: (session!.purchasedDate?? "").toString(),
                        decoration: InputDecoration(
                          labelText: "Purchased Date",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder: theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                            Icons.date_range_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: (session!.lenderAmount ?? 0).toString(),
                        decoration: InputDecoration(
                          labelText: "Lender Amount",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder: theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                            Icons.price_change,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: (session!.withholdingAmount ?? 0).toString(),
                        decoration: InputDecoration(
                          labelText: "Withholding Amount",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder: theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                            Icons.price_change,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: (session!.customerAmount ?? 0).toString(),
                        decoration: InputDecoration(
                          labelText: "Customer Check",
                          border: theme.inputDecorationTheme.border,
                          enabledBorder: theme.inputDecorationTheme.border,
                          focusedBorder: theme.inputDecorationTheme.focusedBorder,
                          prefixIcon: const Icon(
                            Icons.price_change,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: 80,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton.icon(
                      label: FxText.sh1('MarketPlace', fontSize: 14,),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          ListingRequestView.routeName,
                          arguments: session!,
                        );
                      },
                      icon: Icon(Icons.storefront,
                          size: 20,
                          color: theme.colorScheme.primaryVariant
                              .withAlpha(220)),
                    ),
                    TextButton.icon(
                      label: FxText.sh1('Transfer', fontSize: 14,),
                      onPressed: () {
                      },
                      icon: Icon(Icons.emoji_transportation,
                          size: 20,
                          color: theme.colorScheme.primaryVariant
                              .withAlpha(220)),
                    ),
                    TextButton.icon(
                      label: FxText.sh1('Sold', fontSize: 14,),
                      onPressed: () {},
                      icon: Icon(Icons.sell,
                          size: 20,
                          color: theme.colorScheme.primaryVariant
                              .withAlpha(220)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}
