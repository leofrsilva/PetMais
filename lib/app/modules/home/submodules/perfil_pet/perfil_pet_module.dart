import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';

import '../../home_controller.dart';
import 'pages/upadate_pet_images.dart/update_pet_images_controller.dart';
import 'pages/upadate_pet_images.dart/update_pet_images_page.dart';
import 'pages/update_pet/update_pet_controller.dart';
import 'pages/update_pet/update_pet_page.dart';
import 'perfil_pet_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'perfil_pet_page.dart';

class PerfilPetModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => PerfilPetController(
              i.get<HomeController>(),
              i.get<PetRemoteRepository>(),
            )),
        Bind((i) => UpdatePetController(i.get<PerfilPetController>())),
        Bind((i) => UpdatePetImagesController(i.get<PerfilPetController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => PerfilPetPage(petModel: args.data),
        ),
        ModularRouter(
          "/updatePet",
          child: (_, args) => UpdatePetPage(
            petModel: args.data,
          ),
        ),
        ModularRouter(
          "/updatePetImages",
          child: (_, args) => UpdatePetImagesPage(
            petModel: args.data,
          ),
        ),
      ];

  static Inject get to => Inject<PerfilPetModule>.of();
}
