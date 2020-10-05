import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import 'splash_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SplashController(i.get<AuthStore>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashPage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
