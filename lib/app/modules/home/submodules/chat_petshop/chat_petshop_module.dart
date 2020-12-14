import '../../home_controller.dart';
import 'chat_petshop_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';

import 'chat_petshop_page.dart';

class ChatPetshopModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatPetshopController(i.get<HomeController>(), i.get<FirestoreChatRepository>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => ChatPetshopPage()),
      ];

  static Inject get to => Inject<ChatPetshopModule>.of();
}
