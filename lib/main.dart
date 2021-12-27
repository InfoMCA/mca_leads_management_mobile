import 'dart:convert';
import 'dart:developer';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/app/app_module.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/utils/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  try {
    String object = await LocalStorage.getObject(ObjectType.driver);
    if (true) {//object.isEmpty) {
      log("No user found, proceeding to login page");
    } else {
      currentUser = AuthUserModel.fromJson(json.decode(object));
    }
  } catch (e) {
    log(e.toString());
  }
  runApp(ModularApp(
    child: MaterialApp(
      title: 'MCA Management UI',
      theme: FlexThemeData.light(scheme: FlexScheme.deepPurple),
      //theme: AppTheme.theme,
      initialRoute: currentUser != null ? "/home" : "/security/login",
    ).modular(),
    module: AppModule(),
  ));
}
