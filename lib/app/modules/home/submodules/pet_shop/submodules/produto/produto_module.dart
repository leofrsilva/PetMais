import 'pages/update_produto/update_produto_controller.dart';
import 'dart:convert';

import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';

import 'produto_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'produto_page.dart';

class ProdutoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProdutoController(i.get<HomeController>()),
            singleton: false),
        Bind((i) => UpdateProdutoController(i.get<ProdutoController>()),
            singleton: false),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          "/:jsonprod/:showPerfil",
          child: (_, args) => ProdutoPage(
            produto: ProdutoModel.fromMap(
              json.decode(
                  args.params["jsonprod"].toString().replaceAll("@2@", "/")),
            ),
            showPerfil: int.tryParse(args.params["showPerfil"].toString()),
          ),
        ),
      ];

  static Inject get to => Inject<ProdutoModule>.of();
}
