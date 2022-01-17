import 'package:flutter/material.dart';

ThemeData get getMarketplaceThemeData {
  return ThemeData(
      primaryColor: Colors.white,
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF014F8B),
        unselectedItemColor: Color(0xFFF3F3F3),
      ));
}
