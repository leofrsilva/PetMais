import 'pages/dados_matematicos/dados_matematicos_controller.dart';
import 'pages/dados_principais/dados_principais_controller.dart';
import '../../../../home_controller.dart';
import 'add_produto_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'add_produto_page.dart';

class AddProdutoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AddProdutoController(i.get<HomeController>())),
        Bind((i) => DadosPrincipaisController(i.get<AddProdutoController>())),
        Bind((i) => DadosMatematicosController(i.get<AddProdutoController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => AddProdutoPage()),
      ];

  static Inject get to => Inject<AddProdutoModule>.of();
}
