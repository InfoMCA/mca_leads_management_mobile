import 'package:flutter_modular/flutter_modular.dart';
import 'package:mca_leads_management_mobile/views/security/login_page.dart';


class AppModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/security/login', child: (_, args) => const LoginPage())
  ];
}
