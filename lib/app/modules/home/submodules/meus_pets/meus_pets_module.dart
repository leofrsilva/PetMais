import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/modules/home/submodules/meus_pets/pages/add_pet/add_pet_controller.dart';
import 'package:petmais/app/modules/home/submodules/meus_pets/pages/add_pet/add_pet_page.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';

import 'meus_pets_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'meus_pets_page.dart';

class MeusPetsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => MeusPetsController(i.get<HomeController>(), i.get<PetRemoteRepository>(), i.get<AdocaoRemoteRepository>(),)),
        Bind((i) => AddPetController(i.get<MeusPetsController>())),

        Bind((i) => PetRemoteRepository()),
        Bind((i) => AdocaoRemoteRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => MeusPetsPage()),
        ModularRouter("/addPet", child: (_, args) => AddPetPage(), transition: TransitionType.leftToRight),
      ];

  static Inject get to => Inject<MeusPetsModule>.of();
}
