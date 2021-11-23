/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */


import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/extensions/theme_extension.dart';
import 'package:mca_leads_management_mobile/utils/theme/theme_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class AppNotifier extends ChangeNotifier {


  AppNotifier() {
    init();
  }

  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ThemeType themeType =  sharedPreferences.getString("theme_mode").toString().toThemeType;
    _changeTheme(themeType);
    notifyListeners();
  }


  updateTheme(ThemeType themeType) {
    _changeTheme(themeType);


    notifyListeners();


    updateInStorage(themeType);

  }

  static void changeFxTheme(ThemeType themeType) {
    if (themeType == ThemeType.light) {
      FxAppTheme.changeThemeType(FxAppThemeType.light);
    } else if (themeType == ThemeType.dark) {
      FxAppTheme.changeThemeType(FxAppThemeType.dark);
    }
  }

  Future<void>  updateInStorage(ThemeType themeType) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("theme_mode", themeType.toText);
  }

  void _changeTheme(ThemeType themeType) {
    AppTheme.themeType = themeType;
    AppTheme.customTheme = AppTheme.getCustomTheme(themeType);
    AppTheme.theme = AppTheme.getTheme(themeType);

    AppTheme.changeFxTheme(themeType);
  }



}