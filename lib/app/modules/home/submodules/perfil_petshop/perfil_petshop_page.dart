import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'perfil_petshop_controller.dart';

class PerfilPetshopPage extends StatefulWidget {
  final UsuarioInfoJuridicoModel usuarioInfo;
  const PerfilPetshopPage({this.usuarioInfo});

  @override
  _PerfilPetshopPageState createState() => _PerfilPetshopPageState();
}

class _PerfilPetshopPageState
    extends ModularState<PerfilPetshopPage, PerfilPetshopController> {
  //use 'controller' variable to access controller

  UsuarioInfoJuridicoModel userInfo;

  Future<void> onRefreshProd() async {
    setState(() {
      controller.recuperarProdPetShop(userInfo.id);
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    userInfo = widget.usuarioInfo;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //? -------------------------------
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _headerPerfil(size),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      controller.animationDrawer.isShowDrawer ? 40 : 0)),
              child: Container(
                height: size.height * 0.575,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          controller.animationDrawer.isShowDrawer ? 40 : 0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //?-------------------------------------------
                    userInfo != null
                        ? Expanded(child: _listProdutos(userInfo.id, size))
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerPerfil(Size size) {
    String tels = this.userInfo.telefone1;
    if (this.userInfo.telefone2 != null) {
      tels = tels + " | " + this.userInfo.telefone2;
    }
    return Observer(builder: (_) {
      return Container(
        height: size.height * 0.44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
                controller.animationDrawer.isShowDrawer ? 40 : 0),
          ),
        ),
        // Moldura
        child: Container(
          height: size.height * 0.4,
          width: size.width,
          decoration: BoxDecoration(
            color: DefaultColors.tertiary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * 0.0425),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black26,
                          size: 26,
                        ),
                        onPressed: () {
                          Modular.to.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.325,
                width: size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.width * 0.4,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(this.userInfo.urlFoto),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.3,
                      width: size.width * 0.6,
                      padding: EdgeInsets.only(
                          left: size.width * 0.05, right: size.width * 0.0085),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  this.userInfo.nomeOrg,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    height: size.height * 0.0015,
                                    fontSize: size.height * 0.025,
                                    fontFamily: "Changa",
                                    color: DefaultColors.background,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  tels,
                                  maxLines: 2,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    height: size.height * 0.0015,
                                    fontSize: size.height * 0.0225,
                                    fontFamily: "Changa",
                                    color: Colors.black12,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  this.userInfo.enderecoStr,
                                  maxLines: 3,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    height: size.height * 0.0015,
                                    fontSize: size.height * 0.0245,
                                    fontFamily: "Changa",
                                    color: Colors.black45,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(color: Colors.black12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  this.userInfo.descricao,
                                  maxLines: 4,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    height: size.height * 0.0015,
                                    fontSize: size.height * 0.0245,
                                    fontFamily: "Changa",
                                    color: DefaultColors.background,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _listProdutos(int id, Size size) {
    return Container(
      width: size.width,
      alignment: Alignment.center,
      child: FutureBuilder(
          future: controller.recuperarProdPetShop(this.userInfo.id),
          builder: (context, snapshot) {
            Widget defaultWidget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              defaultWidget = Container(
                height: size.height * 0.7,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(DefaultColors.background),
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                List<ProdutoModel> prods = snapshot.data;
                if (prods.length > 0) {
                  // int listLast = prods.length - 1;
                  defaultWidget = defaultWidget = ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        controller.animationDrawer.isShowDrawer ? 40 : 0,
                      ),
                    ),
                    child: Container(
                      height: size.height * 0.6,
                      width: size.width,
                      padding: EdgeInsets.only(top: size.height * 0.0193),
                      child: RefreshIndicator(
                        color: DefaultColors.primary,
                        onRefresh: this.onRefreshProd,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: prods.map((prod) {
                            // int indexNow = prods
                            //     .indexWhere((produto) => produto.id == prod.id);
                            // if (indexNow == listLast) {
                            //   return Column(
                            //     children: [
                            //       postProdutos(
                            //         prod,
                            //         size,
                            //       ),
                            //       SizedBox(height: size.height * 0.12),
                            //     ],
                            //   );
                            // }
                            return postProdutos(
                              prod,
                              size,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                } else {
                  defaultWidget = Container(
                    height: size.height * 0.7,
                    child: Center(
                      child: Text(
                        "Nenhum produto adicionado :(",
                        style: TextStyle(
                          color: DefaultColors.background,
                          fontSize: 16,
                          fontFamily: "Changa",
                        ),
                      ),
                    ),
                  );
                }
              } else {
                defaultWidget = Container(
                  height: size.height * 0.7,
                  child: Center(
                    child: Text(
                      "Erro na Conexão",
                      style: TextStyle(
                        color: DefaultColors.error,
                        fontSize: 16,
                        fontFamily: "Changa",
                      ),
                    ),
                  ),
                );
              }
            }
            return defaultWidget;
          }),
    );
  }

  Widget postProdutos(ProdutoModel produto, Size size) {
    return InkWell(
      onTap: (){
        controller.showPostProduto(produto);
      },
          child: Container(
        height: size.width * 0.45,
        margin: EdgeInsets.only(
            left: size.width * 0.025,
            right: size.width * 0.025,
            top: size.width * 0.045,
            bottom: size.width * 0.15),
        // padding: EdgeInsets.all(size.width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: size.width * 0.35,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(produto.imgProd),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: size.width * 0.37,
              width: size.width * 0.3,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.0075),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.nameProd,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      height: size.height * 0.0015,
                      color: DefaultColors.background,
                      fontFamily: "Changa",
                      fontSize: size.width * 0.04,
                    ),

                  ),
                  Text(
                    produto.descricao + "asf asdf asdf asdf asef ",
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      height: size.height * 0.0015,
                      color: DefaultColors.backgroundSmooth,
                      fontFamily: "Changa",
                      fontSize: size.width * 0.035
                    ),

                  ),
                  if(produto.delivery == 1)
                  Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/delivery.png",
                width: size.width * 0.05,
                height: size.width  * 0.05,
              )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
