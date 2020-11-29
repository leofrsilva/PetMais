import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/modules/home/submodules/drawer/drawer_menu_controller.dart';
import 'package:petmais/app/modules/home/submodules/perfil/pages/update_user_juridico/update_user_juridico_controller.dart';
import 'package:petmais/app/modules/home/submodules/perfil/pages/update_user_juridico/update_user_juridico_page.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';

import 'pages/update_user/update_user_controller.dart';
import 'pages/update_user/update_user_page.dart';
import 'perfil_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'perfil_page.dart';

class PerfilModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilController(
              i.get<HomeController>(),
              i.get<DrawerMenuController>(),
              i.get<AdocaoRemoteRepository>(),
              i.get<PetRemoteRepository>(),
            )),
        Bind((i) => UpdateUserController(i.get<PerfilController>())),
        Bind((i) => UpdateUserJuridicoController(i.get<PerfilController>())),
        Bind((i) => AdocaoRemoteRepository()),
        Bind((i) => PetRemoteRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => PerfilPage()),
        ModularRouter("/updateUser", child: (_, args) => UpdateUserPage(), transition: TransitionType.downToUp),
        ModularRouter("/updateUserJuridico", child: (_, args) => UpadateUserJuridicoPage(), transition: TransitionType.downToUp),
      ];

  static Inject get to => Inject<PerfilModule>.of();
}
