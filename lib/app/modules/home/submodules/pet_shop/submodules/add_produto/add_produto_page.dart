import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pages/dados_matematicos/dados_matematicos_page.dart';
import 'pages/dados_principais/dados_principais_page.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'add_produto_controller.dart';

class AddProdutoPage extends StatefulWidget {

  @override
  _AddProdutoPageState createState() => _AddProdutoPageState();
}

class _AddProdutoPageState
    extends ModularState<AddProdutoPage, AddProdutoController> {
  //use 'controller' variable to access controller

  List<Widget> _listPages = [
    DadosPrincipaisPage(),
    DadosMatematicosPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: DefaultColors.tertiary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black26,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        title: Text(
          "Adicionar Produto",
          style: kLabelTitleAppBarStylePetShop,
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _listPages.length,
        itemBuilder: (context, index) {
          return _listPages[index];
        },
      ),
    );
  }
}
