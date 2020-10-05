import '../../home_controller.dart';
import 'drawer_menu_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'drawer_menu_page.dart';

class DrawerMenuModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DrawerMenuController(i.get<HomeController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => DrawerMenuPage()),
      ];

  static Inject get to => Inject<DrawerMenuModule>.of();
}
