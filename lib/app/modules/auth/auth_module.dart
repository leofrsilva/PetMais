
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import 'auth_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth_page.dart';
import 'pages/login/login_controller.dart';
import 'pages/login/login_page.dart';
import 'submodules/cadastro/cadastro_module.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [
        // Bind((i) => AuthController(i.get<AuthStore>())),
        Bind((i) => AuthController(i.get<AuthStore>())),

        Bind((i) => LoginController(i.get<AuthController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => AuthPage()),
        ModularRouter("/login", child: (_, args) => LoginPage(), transition: TransitionType.leftToRight),        
        ModularRouter("/cadastro", module: CadastroModule(), transition: TransitionType.leftToRight),
      ];

  static Inject get to => Inject<AuthModule>.of();
}
