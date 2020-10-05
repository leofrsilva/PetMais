import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/modules/home/submodules/adocao/adocao_controller.dart';

import '../../home_controller.dart';
import 'perfil_user_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'perfil_user_page.dart';

class PerfilUserModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilUserController(
              i.get<HomeController>(),
              i.get<AdocaoRemoteRepository>(),
              i.get<AdocaoController>(),
            )),
        Bind((i) => AdocaoRemoteRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => PerfilUserPage(usuarioModel: args.data ?? null),
        ),
      ];

  static Inject get to => Inject<PerfilUserModule>.of();
}
