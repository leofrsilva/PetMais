import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';

import 'adocao_del_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'adocao_del_page.dart';

class AdocaoDelModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AdocaoDelController(i.get<AdocaoRemoteRepository>())),
        Bind((i) => AdocaoRemoteRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter("/:id",
            child: (_, args) =>
                AdocaoDelPage(id: int.tryParse(args.params["id"]))),
      ];

  static Inject get to => Inject<AdocaoDelModule>.of();
}
