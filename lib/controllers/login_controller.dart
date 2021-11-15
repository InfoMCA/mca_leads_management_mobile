import 'dart:developer';
import 'dart:io';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/interfaces/admin_interface.dart';
import 'package:mca_leads_management_mobile/utils/local_storage.dart';

class LoginController {
  Future<AppResp> loginWithUsernameAndPassword(String email, String password) async {
    AppResp response = AppResp();
    try {
      response = await AdminInterface().checkLoginCredentials(email, password);
      if (response.statusCode == HttpStatus.ok) {
        currentStaff = AuthUserModel(
          username: email,
        );
        LocalStorage.saveObject(type: ObjectType.driver, object: currentStaff);
        Modular.to.popAndPushNamed('/home');
      } else {
        currentStaff = null;
      }
      return response;
    } catch (e) {
      log(e.toString());
      return response;
    }
  }

  logoff() async {
    try {
      currentStaff = null;
      await LocalStorage.deleteAll();
      log("User logged out successfully");
    } catch(e) {
      log(e.toString());
    }
  }
}

