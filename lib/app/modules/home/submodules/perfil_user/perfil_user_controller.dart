import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/submodules/adocao/adocao_controller.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';

import '../../home_controller.dart';

part 'perfil_user_controller.g.dart';

@Injectable()
class PerfilUserController = _PerfilUserControllerBase
    with _$PerfilUserController;

abstract class _PerfilUserControllerBase with Store {
  HomeController _homeController;
  AdocaoRemoteRepository _adocaoRemoteRepository;
  final AdocaoController _adocaoController;
  _PerfilUserControllerBase(this._homeController, this._adocaoRemoteRepository,
      this._adocaoController);

  HomeController get home => this._homeController;

  UsuarioModel get usuario => this.home.auth.usuario;

  AnimationDrawerController get animationDrawer => this.home.animationDrawer;

  Future<List<PostAdocaoModel>> recuperarPets(int id) async {
    return await this._adocaoRemoteRepository.listAdocoes(
          id,
          especie: "",
          raca: "",
        );
  }

  void changePageConversa() {
    this._adocaoController.tabController.animateTo(1);
  }
}
