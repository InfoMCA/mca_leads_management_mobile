import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get appTheme {
  const primaryIconColor = Color(0xFFFFFFFF);
  const iconColor = Color(0xFF7099b2);
  const secondaryColor = Color(0xFF84939d);
  const backgroundColor = Color(0xFF112A39);
  const primaryColor = Color(0xFF315FD6);
  const accentColor = Color(0xFFF5A623);

  return ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      const TextTheme(
        bodyText1: TextStyle(
          color: primaryIconColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyText2: TextStyle(
          color: secondaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: TextStyle(
          color: primaryIconColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        subtitle2: TextStyle(
          color: secondaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        button: TextStyle(
          color: primaryIconColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: iconColor,
    ),
    primaryIconTheme: const IconThemeData(
      color: primaryIconColor,
    ),
    backgroundColor: backgroundColor,
    primaryColor: primaryColor,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: accentColor),
  );
}
