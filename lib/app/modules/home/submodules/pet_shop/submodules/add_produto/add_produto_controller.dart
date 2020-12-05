import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

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
      {double preco, double desconto, int estoque, int delivery}) {
    this.produto.price = preco;
    this.produto.desconto = desconto;
    this.produto.estoque = estoque;
    this.produto.delivery = delivery;
    this.produto.dataRegistro = DateTime.now().toString();
  }

  //* Gerencimaento das Paginas
  PageController pageController;

  void nextPage() {
    this.pageController.animateTo(
          1,
          duration: Duration(milliseconds: 250),
          curve: Curves.linear,
        );
  }

  void prevPage() {
    this.pageController.animateTo(
          0,
          duration: Duration(milliseconds: 250),
          curve: Curves.linear,
        );
  }

  //* Cadastro de Produto
  Future registrerProd() {}

  @override
  void dispose() {
    pageController.dispose();
  }
}
