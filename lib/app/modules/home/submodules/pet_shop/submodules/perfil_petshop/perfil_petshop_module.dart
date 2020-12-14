import 'package:petmais/app/modules/home/submodules/drawer/drawer_menu_controller.dart';

import '../../../../home_controller.dart';
import 'perfil_petshop_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pages/update_user_petshop/update_user_petshop_page.dart';
import 'pages/update_user_petshop/update_user_petshop_controller.dart';

import 'perfil_petshop_page.dart';

class PerfilPetshopModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilPetshopController(i.get<HomeController>(), i.get<DrawerMenuController>())),
        Bind((i) => UpdateUserPetshopController(i.get<PerfilPetshopController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => PerfilPetshopPage()),
        ModularRouter("/updatePetshop", child: (_, args) => UpadateUserPetshopPage(), transition: TransitionType.downToUp),

      ];

  static Inject get to => Inject<PerfilPetshopModule>.of();
}
