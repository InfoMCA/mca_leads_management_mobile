import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context, required String text, Color backgroundColor = Colors.red}) {
  SnackBar snackbar =
  SnackBar(backgroundColor: backgroundColor, content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}