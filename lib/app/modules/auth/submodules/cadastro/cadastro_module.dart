import 'package:petmais/app/modules/auth/auth_controller.dart';

import 'cadastro_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cadastro_page.dart';
import 'pages/dados_principais/dados_principais_controller.dart';
import 'pages/pessoa_fisica/pessoa_fisica_controller.dart';
import 'pages/pessoa_juridica/pessoa_juridica_controller.dart';

class CadastroModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DadosPrincipaisController(i.get<CadastroController>())),
        Bind((i) => PessoaFisicaController(i.get<CadastroController>())),
        Bind((i) => PessoaJuridicaController(i.get<CadastroController>())),
        // $CadastroController,
        Bind((i) => CadastroController(i.get<AuthController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => CadastroPage()),
      ];

  static Inject get to => Inject<CadastroModule>.of();
}
