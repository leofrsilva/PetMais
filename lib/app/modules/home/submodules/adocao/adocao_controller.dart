import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import '../../controllers/animation_drawer_controller.dart';
import '../../home_controller.dart';

import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';

part 'adocao_controller.g.dart';

@Injectable()
class AdocaoController = _AdocaoControllerBase with _$AdocaoController;

abstract class _AdocaoControllerBase extends Disposable with Store {
  HomeController _homeController;
  _AdocaoControllerBase(this._homeController);

  TabController tabController;
  setTaController(TabController controller) => this.tabController = controller;

  AuthStore get auth => this._homeController.auth;

  AnimationDrawerController get animationDrawer =>
      this._homeController.animationDrawer;

  HomeController get home => this._homeController;

  // -----------------------------------------------
  Future removerUsuarioLocalmente() async {
    await this._homeController.exit();
    this.auth.setUser(UsuarioModel());
  }

  Future<List<PostAdocaoModel>> listAllAdocoes(String esp, String rac) async {
    final adocaoRepository = AdocaoRemoteRepository();
    return await adocaoRepository
        .listAdocoes(0, especie: esp, raca: rac);
  }

  @override
  void dispose() {
    tabController.dispose();
  }
}
