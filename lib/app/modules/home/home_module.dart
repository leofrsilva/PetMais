import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:petmais/app/modules/home/submodules/perfil/perfil_module.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';
import 'submodules/adocao_upd/adocao_upd_module.dart';
import 'submodules/perfil_pet/perfil_pet_module.dart';
import 'submodules/perfil_user/perfil_user_module.dart';
import 'submodules/add_adocao/add_adocao_module.dart';
import 'submodules/chat/chat_module.dart';
import 'repository/hasura_chat/firestore_chat_repository.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(
              i.get<AuthStore>(),
              i.get<AnimationDrawerController>(),
              i.get<FirestoreChatRepository>(),
            )),

        Bind((i) => AnimationDrawerController()),
        Bind((i) => FirestoreChatRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter("/perfil", module: PerfilModule()),
        ModularRouter("/perfilUser", module: PerfilUserModule(), transition: TransitionType.downToUp),
        ModularRouter("/perfilPet", module: PerfilPetModule(), transition: TransitionType.downToUp),
        ModularRouter("/addAdocao", module: AddAdocaoModule(), transition: TransitionType.downToUp),
        ModularRouter("/adocaoUpd", module: AdocaoUpdModule(), transition: TransitionType.downToUp),
        ModularRouter("/chat", module: ChatModule(), transition: TransitionType.downToUp),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
