import 'dart:developer';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';
import 'package:mca_leads_management_mobile/models/entities/globals.dart';
import 'package:mca_leads_management_mobile/models/interfaces/backend_interface.dart';
import 'package:mca_leads_management_mobile/utils/local_storage.dart';

class LoginController {
  Future<String> loginWithUsernameAndPassword(String email, String password) async {
    AuthUserModel response ;
    try {
      response = await BackendInterface().checkLoginCredentials(email, password);
      currentUser = AuthUserModel(
        username: email,
        dealerId: response.dealerId
      );
      LocalStorage.saveObject(type: ObjectType.driver, object: currentUser);
      Modular.to.popAndPushNamed('/home');
      return "";
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  logoff() async {
    try {
      currentUser = null;
      await LocalStorage.deleteAll();
      log("User logged out successfully");
    } catch(e) {
      log(e.toString());
    }
  }
}

