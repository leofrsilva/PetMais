import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import 'search_user_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../home_controller.dart';

import 'search_user_page.dart';

class SearchUserModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) =>
            SearchUserController(i.get<AuthStore>(), i.get<HomeController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => SearchUserPage()),        
      ];

  static Inject get to => Inject<SearchUserModule>.of();
}
