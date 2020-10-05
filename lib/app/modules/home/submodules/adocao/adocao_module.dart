import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:petmais/app/modules/home/submodules/perfil/perfil_module.dart';

import 'adocao_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'adocao_page.dart';
import 'pages/aba_adocao/aba_adocao_controller.dart';
import 'pages/aba_conversa/aba_conversa_controller.dart';

class AdocaoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AdocaoController(i.get<HomeController>())),

        Bind((i) => AbaAdocaoController(i.get<AdocaoController>())),
        Bind((i) => AbaConversaController(i.get<AdocaoController>(), i.get<FirestoreChatRepository>())),
      ];

  @override
  
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => AdocaoPage()),
        ModularRouter("/perfil", module: PerfilModule()),
        // ModularRouter("/perfil", child: (_, args) => AbaAdocaoPage()),
      ];

  static Inject get to => Inject<AdocaoModule>.of();
}
