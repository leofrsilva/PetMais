import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

import '../../pet_shop_controller.dart';

part 'meus_produtos_controller.g.dart';

@Injectable()
class MeusProdutosController = _MeusProdutosControllerBase
    with _$MeusProdutosController;

abstract class _MeusProdutosControllerBase extends Disposable with Store {
  // Função para atualizar a lista de produtos
  Function _updateListProdutos;
  set updateListProdutos(Function value) => this._updateListProdutos = value;
  Function get updateListProdutos => this._updateListProdutos;

  PetShopController _petShopController;
  _MeusProdutosControllerBase(this._petShopController) {
    this.listCategoria = ProdutoModel.listCategorias();
    this.nomeProdController = TextEditingController();
    this.nomeShopController = TextEditingController();
    this.focusNomeProd = FocusNode();
    this.focusShop = FocusNode();
    this.categoriaSelect = "Todos";
  }

  AnimationDrawerController get animationDrawer =>
      this._petShopController.animationDrawer;
  PetShopController get petshop => this._petShopController;
  UsuarioModel get usuario => this._petShopController.auth.usuario;

  //* Nome Produto
  TextEditingController nomeProdController;
  TextEditingController nomeShopController;
  FocusNode focusNomeProd;
  FocusNode focusShop;

  //* Categoria
  @observable
  String categoriaSelect;
  @action
  setCategoriaSelect(String value) {
    this.categoriaSelect = value;
    this.updateListProdutos.call();
  }

  List<DropdownMenuItem<String>> listCategoria;

  @observable
  bool isSearch = false;

  @action
  setShowSearch() => this.isSearch = true;
  @action
  setCloseSearch() => this.isSearch = false;

  @action
  Future<List<ProdutoModel>> recuperarProdPetShop() async {
    int id;
    String categoria;
    String nomeProd;
    String nomePetShop;

    if (this.usuario.isPetShop) {
      id = (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).id;
    }
    if (this.categoriaSelect != null) {
      if (this.categoriaSelect != "Todos") categoria = this.categoriaSelect;
    }
    if (this.nomeProdController.text.isNotEmpty) {
      nomeProd = this.nomeProdController.text.trim();
    }
    if (this.nomeShopController.text.isNotEmpty) {
      nomePetShop = this.nomeShopController.text.trim();
    }

    return await this._petShopController.listProdPetShop(
          idShop: id,
          cat: categoria,
          nPetShop: nomePetShop,
          nProd: nomeProd,
        );
  }

  @override
  void dispose() {
    this.nomeProdController.dispose();
    this.nomeShopController.dispose();
    this.focusNomeProd.dispose();
    this.focusShop.dispose();
  }
}
