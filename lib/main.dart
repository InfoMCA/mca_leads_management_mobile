import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/app/app_module.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/utils/local_storage.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_theme.dart';
import 'package:mca_leads_management_mobile/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  try {
    String object = await LocalStorage.getObject(ObjectType.driver);
    if (object.isEmpty) {
      log("No user found, proceeding to login page");
    } else {
      currentStaff = AuthUserModel.fromJson(json.decode(object));
    }
  } catch (e) {
    log(e.toString());
  }
  runApp(ModularApp(
    child: MaterialApp(
      title: 'MCA Management UI',
      theme: AppTheme.theme,
      initialRoute: currentStaff != null ? "/home" : "/security/login",
    ).modular(),
    module: AppModule(),
  ));
}
