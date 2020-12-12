
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/pet_shop/pet_shop_repository.dart';

part 'add_produto_controller.g.dart';

@Injectable()
class AddProdutoController = _AddProdutoControllerBase
    with _$AddProdutoController;

abstract class _AddProdutoControllerBase extends Disposable with Store {
  HomeController _homeController;
  _AddProdutoControllerBase(this._homeController) {
    pageController = PageController(initialPage: 0);
  }

  UsuarioModel get usuario => this._homeController.auth.usuario;

  ProdutoModel produto = ProdutoModel();

  void setDadosPrincipais({String nome, String desc, String cat, String url}) {
    this.produto.idPetShop = this.usuario.usuarioInfo.id;
    this.produto.nameProd = nome;
    this.produto.categoria = cat;
    this.produto.descricao = desc;
    this.produto.imgProd = url;
  }

  void setDadosMatematicos(
      {double preco, double desconto, int estoque, double valKm, int delivery}) {
    this.produto.price = preco;
    this.produto.desconto = desconto;
    this.produto.estoque = estoque;
    this.produto.valorKm = valKm;
    this.produto.delivery = delivery;
    this.produto.dataRegistro = DateTime.now().toString();
  }

  File image;
  setImage(File value) => this.image = value;
  
  //* Gerencimaento das Paginas
  PageController pageController;
  double get maxExtentPages => this.pageController.position.maxScrollExtent;

  void nextPage() {
    // double page = ((maxExtentPages / 2) * (1 + 0.3));
    this.pageController.animateToPage(
          1,
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
        );
  }

  void prevPage() {
    this.pageController.animateToPage(
          0,
          duration: Duration(milliseconds: 250),
          curve: Curves.linear,
        );
  }

  //* Cadastro de Produto
  Future<String> registrerProd(ProdutoModel produto, bool isLoading) async {
    final petShopRepository = PetShopRepository();
    // return await petShopRepository.registerProduto(produto);
    if (this.image != null) {
      await petShopRepository
          .uploadImageProduto(this.image, isLoading)
          .then((Map<String, dynamic> result) {
        if (result["Result"] == "Falha no Envio" ||
            result["Result"] == "Not Send") {
          return result["Result"];
        } else {
          isLoading = false;
        }
      });
    }
    Map<String, dynamic> result;
    result =
        await petShopRepository.registerProduto(produto, loading: isLoading);
    return result["Result"];
  }

  @override
  void dispose() {
    pageController.dispose();
  }
}
