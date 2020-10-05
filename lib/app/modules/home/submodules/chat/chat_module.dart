import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import 'chat_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chat_page.dart';

class ChatModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) =>
            ChatController(i.get<AuthStore>(), i.get<FirestoreChatRepository>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          "/:viewed",
          child: (_, args) => ChatPage(
            usuarioContact: args.data,
            viewed: bool.fromEnvironment( args.params["viewed"]),
          ),
        ),
      ];

  static Inject get to => Inject<ChatModule>.of();
}
