import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';

void showSnackBar(
    {required BuildContext context,
    required String text,
    required Color backgroundColor}) {
  SnackBar snackbar =
      SnackBar(backgroundColor: backgroundColor, content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
