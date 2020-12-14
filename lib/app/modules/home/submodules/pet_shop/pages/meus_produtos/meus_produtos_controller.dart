import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/submodules/produto/produto_module.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

import '../../pet_shop_controller.dart';

part 'meus_produtos_controller.g.dart';

@Injectable()
class MeusProdutosController = _MeusProdutosControllerBase
    with _$MeusProdutosController;

abstract class _MeusProdutosControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext value) => this.context = value;

  // Função para atualizar a lista de produtos
  Function _updateListProdutos;
  set updateListProdutos(Function value) => this._updateListProdutos = value;
  Function get updateListProdutos => this._updateListProdutos;

  // Função para limpar imagens
  Function _clearImage;
  set clearImage(Function value) => this._clearImage = value;
  Function get clearImage => this._clearImage;

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

  Future showPostProduto(ProdutoModel produtoModel, double height) async {
    // bool isPetshop = this.usuario.isPetShop;
    Modular.to.showDialog(builder: (_) {
      String strProd = json.encode(produtoModel.toMap());
      strProd = strProd.replaceAll("/", "@2@");
      return RouterOutlet(
        initialRoute: "/$strProd/1",
        module: ProdutoModule(),
      );
    }).then((dynamic value) {
      if (value is int) {
        int update = value;
        if (update == 2) {
          this.clearImage.call();
        } else if (update == 1) {
          this.updateListProdutos.call();
        } else if (update == 3) {
          UsuarioInfoJuridicoModel userInfo = UsuarioInfoJuridicoModel(
            identifier: produtoModel.idPetShop,
            nome: produtoModel.nomeEmpresa,
            tel1: produtoModel.telefone,
            tel2: produtoModel.telefone2,
            desc: produtoModel.descricaoPetShop,
            endStr: produtoModel.endereco,
            type: TypeJuridico.petshop,
            urlFoto: produtoModel.imgShop,
          );
          Modular.to.pushNamed("/home/perfilPetshop", arguments: userInfo);
        }
      }
    });
    // Modular.to.showDialog(builder: (_) {
    //   String strProd = json.encode(produtoModel.toMap());
    //   strProd = strProd.replaceAll("/", "@2@");
    //   return Material(
    //     color: Colors.transparent,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(20),
    //       topRight: Radius.circular(20),
    //     ),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(20),
    //           topRight: Radius.circular(20),
    //         ),
    //       ),
    //       height: height * 0.955,
    //       child: Column(
    //         children: [
    //           Container(
    //             height: height * 0.065,
    //             margin: EdgeInsets.only(bottom: height * 0.005),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Container(
    //                   padding: const EdgeInsets.symmetric(horizontal: 3),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(20),
    //                       topRight: Radius.circular(20),
    //                     ),
    //                   ),
    //                   child: IconButton(
    //                     icon: Icon(Icons.close,
    //                         color: DefaultColors.tertiary, size: 28),
    //                     onPressed: () {
    //                       this.hideProduto();
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: RouterOutlet(
    //               initialRoute: "/$strProd",
    //               module: ProdutoModule(),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // },);
    // Modular.to
    //     .showModalBottomSheet(
    //   elevation: 6.0,
    //   clipBehavior: Clip.antiAlias,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(15),
    //       topRight: Radius.circular(15),
    //     ),
    //   ),
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) {

    //   },
    // )
    //     .then((_) {
    //   this.updateListProdutos.call();
    // });
    // bool isPetshop = this.usuario.isPetShop;
    // await showModalBottomSheet(
    //   elevation: 6.0,
    //   clipBehavior: Clip.antiAlias,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(15),
    //       topRight: Radius.circular(15),
    //     ),
    //   ),
    //   isScrollControlled: true,
    //   context: context,
    //   builder: (context) {
    //     String strProd = json.encode(produtoModel.toMap());
    //     strProd = strProd.replaceAll("/", "@2@");
    //     return Container(
    //       height: height * 0.955,
    //       child: Column(
    //         children: [
    //           Container(
    //             height: height * 0.065,
    //             margin: EdgeInsets.only(bottom: height * 0.005),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Container(
    //                   padding: const EdgeInsets.symmetric(horizontal: 3),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(20),
    //                       topRight: Radius.circular(20),
    //                     ),
    //                   ),
    //                   child: IconButton(
    //                     icon: Icon(Icons.close,
    //                         color: DefaultColors.tertiary, size: 28),
    //                     onPressed: () {
    //                       this.hideProduto();
    //                     },
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: RouterOutlet(
    //               initialRoute: "/$strProd",
    //               module: ProdutoModule(),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // )
    // .then((_) {
    //   this.updateListProdutos.call();
    // });
  }

  //* Hide Produto
  void hideProduto() {
    this._petShopController.removeShowProduto(context);
  }

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
