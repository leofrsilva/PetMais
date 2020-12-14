import 'package:petmais/app/modules/home/submodules/pet_shop/pet_shop_controller.dart';

import 'perfil_petshop_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'perfil_petshop_page.dart';

class PerfilPetshopModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilPetshopController(i.get<PetShopController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => PerfilPetshopPage(usuarioInfo: args.data)),
      ];

  static Inject get to => Inject<PerfilPetshopModule>.of();
}
