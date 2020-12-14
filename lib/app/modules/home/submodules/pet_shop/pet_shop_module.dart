import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';

import 'pages/aba_conversas_petshop/aba_conversas_petshop_controller.dart';

import '../../home_controller.dart';
import 'pages/meus_produtos/meus_produtos_controller.dart';
import 'pages/pedidos/pedidos_controller.dart';
import 'pet_shop_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pet_shop_page.dart';

class PetShopModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PetShopController(i.get<HomeController>())),
        Bind((i) => MeusProdutosController(i.get<PetShopController>())),
        Bind((i) => PedidosController(i.get<PetShopController>())),
        Bind((i) => AbaConversasPetshopController(i.get<PetShopController>(), i.get<FirestoreChatRepository>())),

      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => PetShopPage()),
      ];

  static Inject get to => Inject<PetShopModule>.of();
}
