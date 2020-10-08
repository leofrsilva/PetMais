import 'package:petmais/app/modules/home/home_controller.dart';

import 'pet_shop_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pet_shop_page.dart';

class PetShopModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PetShopController(i.get<HomeController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => PetShopPage()),
      ];

  static Inject get to => Inject<PetShopModule>.of();
}
