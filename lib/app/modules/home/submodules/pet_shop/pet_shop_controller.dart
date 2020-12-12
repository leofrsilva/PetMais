import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/pet_shop/pet_shop_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import '../../home_controller.dart';

part 'pet_shop_controller.g.dart';

class PetShopController = _PetShopControllerBase with _$PetShopController;

abstract class _PetShopControllerBase with Store {
  HomeController _homeController;
  _PetShopControllerBase(this._homeController);

  TabController tabController;
  setTaController(TabController controller) => this.tabController = controller;

  AuthStore get auth => this._homeController.auth;

  AnimationDrawerController get animationDrawer =>
      this._homeController.animationDrawer;

  HomeController get home => this._homeController;
  UsuarioModel get usuario => this.home.auth.usuario;

  Future<List<ProdutoModel>> listProdPetShop(
      {int idShop, String cat, String nProd, String nPetShop}) async {
    final adocaoRepository = PetShopRepository();
    return await adocaoRepository.listProdPetShop(
        idPetShop: idShop,
        categoria: cat,
        nameProd: nProd,
        namePetShop: nPetShop);
  }

  void removeShowProduto(BuildContext contex){
    Modular.to.pop(contex);
  }
}
