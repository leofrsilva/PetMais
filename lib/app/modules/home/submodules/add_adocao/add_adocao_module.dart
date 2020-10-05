import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';

import 'add_adocao_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'add_adocao_page.dart';

class AddAdocaoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AddAdocaoController(
              i.get<HomeController>(),
              i.get<PetRemoteRepository>(),
              i.get<AdocaoRemoteRepository>(),
            )),
            
        Bind((i) => PetRemoteRepository()),
        Bind((i) => AdocaoRemoteRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => AddAdocaoPage(petModel: args.data)),
      ];

  static Inject get to => Inject<AddAdocaoModule>.of();
}
