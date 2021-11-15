import 'package:mca_leads_management_mobile/models/entities/auth_user.dart';

String? inspectionConfigStr;
AuthUserModel? _staff;

AuthUserModel? get currentStaff {
  return _staff;
}

set currentStaff(AuthUserModel? newStaff) {
  _staff = newStaff;
}

