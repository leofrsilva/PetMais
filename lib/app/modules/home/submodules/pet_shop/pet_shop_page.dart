import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'pages/aba_conversas_petshop/aba_conversas_petshop_page.dart';
import 'pages/meus_produtos/meus_produtos_page.dart';
import 'pages/pedidos/pedidos_page.dart';
import 'pet_shop_controller.dart';

class PetShopPage extends StatefulWidget {
  final String title;
  const PetShopPage({Key key, this.title = "PetShop"}) : super(key: key);

  @override
  _PetShopPageState createState() => _PetShopPageState();
}

class _PetShopPageState extends ModularState<PetShopPage, PetShopController>
    with SingleTickerProviderStateMixin {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.setTaController(TabController(
      length: controller.usuario.isPetShop == false ? 3 : 2,
      vsync: this,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DefaultColors.secondary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.168),
        child: Observer(
          builder: (BuildContext context) {
            return AppBar(
              backgroundColor: DefaultColors.tertiary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    controller.animationDrawer.isShowDrawer ? 40 : 0),
              )),
              leading: controller.auth.isLogged
                  ? IconButton(
                      icon: Icon(
                        controller.animationDrawer.isShowDrawer
                            ? Icons.arrow_back
                            : Icons.menu,
                        color: Colors.black26,
                        size: 26,
                      ),
                      onPressed: () {
                        if (controller.animationDrawer.isShowDrawer) {
                          controller.animationDrawer.closeDrawer();
                        } else {
                          FocusScope.of(context).unfocus();
                          controller.animationDrawer.openDrawer();
                        }
                      })
                  : Container(),
              centerTitle: true,
              title: Container(
                width: 70,
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              // actionsIconTheme: DefaultIconTheme.iconTheme,
              bottom: TabBar(
                controller: controller.tabController,
                indicatorColor: DefaultColors.others.withOpacity(0.5),
                indicatorWeight: 4,
                labelStyle: kLabelTabStyle,
                labelColor: DefaultColors.background,
                isScrollable: true,
                onTap: (index) {
                  // setState(() {
                  //   tab = index;
                  // });
                },
                tabs: [
                  Container(
                    width: controller.usuario.isPetShop == false ?  size.width * 0.265 : size.width * 0.4,
                    child: Tab(
                        text: controller.usuario.isPetShop
                            ? "Meus Produtos"
                            : "Produtos"),
                  ),
                  Container(
                    width: controller.usuario.isPetShop == false ? size.width * 0.375 : size.width * 0.4,
                    child: Tab(
                        text: controller.usuario.isPetShop
                            ? "Pedidos"
                            : "Meus Pedidos"),
                  ),
                  if (controller.usuario.isPetShop == false)
                    Container(
                      width: size.width * 0.12,
                      child: Tab(icon: Icon(Icons.message_outlined)),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: <Widget>[
          MeusProdutosPage(),
          PedidosPage(),
          if (controller.usuario.isPetShop == false)
          AbaConversasPetshopPage(),
        ],
      ),
    );
  }
}
