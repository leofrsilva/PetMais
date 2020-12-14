import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/pet_shop_controller.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/submodules/produto/produto_module.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/pet_shop/pet_shop_repository.dart';

part 'perfil_petshop_controller.g.dart';

@Injectable()
class PerfilPetshopController = _PerfilPetshopControllerBase
    with _$PerfilPetshopController;

abstract class _PerfilPetshopControllerBase with Store {
  PetShopController _petshopController;
  _PerfilPetshopControllerBase(this._petshopController);

  UsuarioModel get usuario => this._petshopController.usuario;

  AnimationDrawerController get animationDrawer =>
      this._petshopController.animationDrawer;

  Future showPostProduto(ProdutoModel produtoModel) async {
    // bool isPetshop = this.usuario.isPetShop;
    Modular.to.showDialog(builder: (_) {
      String strProd = json.encode(produtoModel.toMap());
      strProd = strProd.replaceAll("/", "@2@");
      return RouterOutlet(
        initialRoute: "/$strProd/0",
        module: ProdutoModule(),
      );
    });
  }

  Future<List<ProdutoModel>> recuperarProdPetShop(int idPetShop) async {
    // String categoria;
    // String nomeProd;
    // String nomePetShop;

    // if (this.categoriaSelect != null) {
    //   if (this.categoriaSelect != "Todos") categoria = this.categoriaSelect;
    // }
    // if (this.nomeProdController.text.isNotEmpty) {
    //   nomeProd = this.nomeProdController.text.trim();
    // }
    // if (this.nomeShopController.text.isNotEmpty) {
    //   nomePetShop = this.nomeShopController.text.trim();
    // }
    final adocaoRepository = PetShopRepository();
    return await adocaoRepository.listProdPetShop(idPetShop: idPetShop);
  }
}
