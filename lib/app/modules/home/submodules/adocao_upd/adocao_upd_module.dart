import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';

import 'adocao_upd_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'adocao_upd_page.dart';

class AdocaoUpdModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AdocaoUpdController(i.get<AdocaoRemoteRepository>())),
        Bind((i) => AdocaoRemoteRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => AdocaoUpdPage(postModel: args.data),
        ),
      ];

  static Inject get to => Inject<AdocaoUpdModule>.of();
}
