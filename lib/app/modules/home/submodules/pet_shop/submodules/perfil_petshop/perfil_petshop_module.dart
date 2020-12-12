import 'package:petmais/app/modules/home/submodules/drawer/drawer_menu_controller.dart';

import '../../../../home_controller.dart';
import 'perfil_petshop_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'perfil_petshop_page.dart';

class PerfilPetshopModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilPetshopController(i.get<HomeController>(), i.get<DrawerMenuController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => PerfilPetshopPage()),
      ];

  static Inject get to => Inject<PerfilPetshopModule>.of();
}
