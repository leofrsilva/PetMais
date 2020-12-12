import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/widgets/PostProduto.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/widgets/PostProdutoPetShop.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomDropdownButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'meus_produtos_controller.dart';

class MeusProdutosPage extends StatefulWidget {
  final String title;
  const MeusProdutosPage({Key key, this.title = "MeusProdutos"})
      : super(key: key);

  @override
  _MeusProdutosPageState createState() => _MeusProdutosPageState();
}

class _MeusProdutosPageState
    extends ModularState<MeusProdutosPage, MeusProdutosController> {
  //use 'controller' variable to access controller
  Widget floatButton = Container();
  Widget produtos;

  void updateImage() {
    setState(() {
      imageCache.clear();
      imageCache.clearLiveImages();
    });
  }

  Future<void> onRefreshProd() async {
    setState(() {
      controller.recuperarProdPetShop();
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    controller.focusNomeProd.addListener(() {
      this.onRefreshProd();
    });
    controller.focusShop.addListener(() {
      this.onRefreshProd();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.updateListProdutos = this.onRefreshProd;
    controller.clearImage = this.updateImage;
    controller.setContext(context);

    if (controller.usuario.isPetShop) {
      floatButton = controller.focusNomeProd.hasFocus
          ? FloatingActionButton(
              backgroundColor: DefaultColors.background,
              child: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
              ),
              onPressed: () {
                this.onRefreshProd();
              },
            )
          : FloatingActionButton(
              backgroundColor: DefaultColors.background,
              child: Icon(
                FontAwesomeIcons.plusSquare,
                color: Colors.white,
              ),
              onPressed: () {
                Modular.to.pushNamed("/home/addProduto");
              },
            );
    }

    if (controller.usuario.isPetShop) {
      produtos = this.listProdPetshop(size);
    } else {
      produtos = this.listProd(size);
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: DefaultColors.secondary,
      body: Observer(builder: (_) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
                controller.animationDrawer.isShowDrawer ? 40 : 0),
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      controller.animationDrawer.isShowDrawer ? 40 : 0),
                ),
              ),
              child: produtos,
            ),
          ),
        );
      }),
      floatingActionButton: floatButton,
    );
  }

  Widget listProdPetshop(Size size) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: size.height / size.width,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.185, //160,
                width: size.width - 10,
                child: Material(
                  elevation: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.04),
                              child: Text(
                                "Categoria: ",
                                style: TextStyle(
                                  height: 0,
                                  color: Colors.grey,
                                  fontFamily: "Changa",
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.height * 0.030,
                                ),
                              ),
                            ),
                            SizedBox(width: size.height * 0.025),
                            Observer(builder: (_) {
                              return Theme(
                                data: ThemeData(
                                  canvasColor: Colors.white,
                                ),
                                child: CustomDropdownButton<String>(
                                  isTitle: false,
                                  height: size.height * 0.08,
                                  width: size.width * 0.575,
                                  label: "Categorias",
                                  // hint: "Categorias",
                                  items: controller.listCategoria,
                                  value: controller.categoriaSelect,
                                  onChanged: controller.setCategoriaSelect,
                                  isDense: true,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: size.width * 0.05,
                            right: size.width * 0.07,
                          ),
                          child: CustomTextField(
                            height: size.height * 0.06,
                            isDense: true,
                            controller: controller.nomeProdController,
                            focusNode: controller.focusNomeProd,
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              controller.focusNomeProd.unfocus();
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                ProdutoModel.toNumCaracteres()["nameProd"],
                              ),
                            ],
                            isTitle: false,
                            label: "Produto",
                            hint: "Produto",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(height: size.height * 0.185),
              FutureBuilder(
                future: controller.recuperarProdPetShop(),
                builder: (context, snapshot) {
                  Widget defaultWidget;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    defaultWidget = Container(
                      height: size.height * 0.793,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              DefaultColors.background),
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      List<ProdutoModel> prods = snapshot.data;
                      if (prods.length > 0) {
                        int listLast = prods.length - 1;

                        defaultWidget = defaultWidget = ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              controller.animationDrawer.isShowDrawer ? 40 : 0,
                            ),
                          ),
                          child: Container(
                            height: size.height * 0.79 - size.height * 0.185,
                            padding: EdgeInsets.only(top: size.height * 0.0193),
                            child: RefreshIndicator(
                              color: DefaultColors.primary,
                              onRefresh: this.onRefreshProd,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: prods.map((prod) {
                                    int indexNow = prods.indexWhere(
                                        (produto) => produto.id == prod.id);
                                    if (indexNow == listLast) {
                                      return Column(
                                        children: [
                                          PostProdutoPetShop(
                                            height: size.height,
                                            width: size.width,
                                            produtoModel: prod,
                                            onTap: () {
                                              if (controller.animationDrawer
                                                  .isShowDrawer) {
                                                return;
                                              }
                                              // Modular.to.pushNamed("/home/produto", arguments: prod);
                                              controller.showPostAdocao(
                                                  prod, size.height);
                                            },
                                          ),
                                          SizedBox(height: size.height * 0.12),
                                        ],
                                      );
                                    }
                                    return PostProdutoPetShop(
                                      height: size.height,
                                      width: size.width,
                                      produtoModel: prod,
                                      onTap: () {
                                        if (controller
                                            .animationDrawer.isShowDrawer) {
                                          return;
                                        }
                                        // Modular.to.pushNamed("/home/produto", arguments: prod);
                                        controller.showPostAdocao(
                                            prod, size.height);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        defaultWidget = Container(
                          height: size.height * 0.793,
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
                        height: size.height * 0.78,
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
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listProd(Size size) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Stack(
        children: <Widget>[
          Observer(builder: (_) {
            return Container(
              height: controller.isSearch
                  ? size.height * 0.185
                  : size.height * 0.185,
              width: size.width,
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (controller.isSearch)
                      Container(
                        height: size.height * 0.185, //160,
                        width: size.width * 0.86,
                        child: Material(
                          elevation: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.035),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.04),
                                      child: Text(
                                        "Categoria: ",
                                        style: TextStyle(
                                          height: 0,
                                          color: Colors.grey,
                                          fontFamily: "Changa",
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.height * 0.030,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: size.height * 0.0175),
                                    Observer(builder: (_) {
                                      return Theme(
                                        data: ThemeData(
                                          canvasColor: Colors.white,
                                        ),
                                        child: CustomDropdownButton<String>(
                                          isTitle: false,
                                          height: size.height * 0.08,
                                          width: size.width * 0.545,
                                          label: "Categorias",
                                          // hint: "Categorias",
                                          items: controller.listCategoria,
                                          value: controller.categoriaSelect,
                                          onChanged:
                                              controller.setCategoriaSelect,
                                          isDense: true,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.035),
                                      child: CustomTextField(
                                        height: size.height * 0.06,
                                        isDense: true,
                                        controller:
                                            controller.nomeProdController,
                                        focusNode: controller.focusNomeProd,
                                        textInputType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (String value) {
                                          controller.focusNomeProd.unfocus();
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                            ProdutoModel.toNumCaracteres()[
                                                "nameProd"],
                                          ),
                                        ],
                                        isTitle: false,
                                        label: "Produto",
                                        hint: "Produto",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.035),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        right: size.width * 0.035,
                                      ),
                                      child: CustomTextField(
                                        height: size.height * 0.06,
                                        isDense: true,
                                        controller:
                                            controller.nomeShopController,
                                        focusNode: controller.focusShop,
                                        textInputType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (String value) {
                                          controller.focusNomeProd.unfocus();
                                        },
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                            UsuarioInfoJuridicoModel
                                                    .toNumCaracteres()[
                                                "nomeEmpresa"],
                                          ),
                                        ],
                                        isTitle: false,
                                        label: "Pet Shop",
                                        hint: "Pet Shop",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    // if (!controller.isSearch)
                    //   Container(
                    //     color: Colors.black12,
                    //     width: size.width * 0.85,
                    //     child: Row(
                    //       children: [
                    //         Text(
                    //           "  Produtos em Destaque",
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontFamily: "Changa",
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: size.height * 0.035,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    Container(
                      // color: controller.isSearch ? Colors.white : Colors.black12,
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () {
                          if (controller.isSearch == true) {
                            controller.setCloseSearch();
                            controller.setCategoriaSelect("Todos");
                            controller.nomeProdController.clear();
                            controller.nomeShopController.clear();
                          } else {
                            controller.setShowSearch();
                          }
                        },
                        child: Container(
                          height: size.width * 0.12,
                          width: size.width * 0.12,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.height * 0.0055,
                            vertical: size.height * 0.0375,
                          ),
                          decoration: BoxDecoration(
                            color: controller.isSearch
                                ? DefaultColors.background
                                : Colors.black12,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            FontAwesomeIcons.filter,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    if (!controller.isSearch)
                      Expanded(
                        child: Container(
                          height: size.height * 0.2,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(top: size.height * 0.0125),
                            children:
                                ProdutoModel.listIconCategorias.map((cat) {
                              return GestureDetector(
                                onTap: () {
                                  controller.setCategoriaSelect(cat["title"]);
                                },
                                child: Observer(builder: (_) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: size.height * 0.1,
                                        width: size.height * 0.1,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.025),
                                        padding:
                                            EdgeInsets.all(size.width * 0.0025),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: DefaultColors.tertiary,
                                            width: 3,
                                          ),
                                        ),
                                        child: Container(
                                          height: size.height * 0.0825,
                                          width: size.height * 0.0825,
                                          decoration: BoxDecoration(
                                            color: controller.categoriaSelect ==
                                                    cat["title"]
                                                ? Colors.transparent
                                                : Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: cat["type"] == "image"
                                                ? DecorationImage(
                                                    image:
                                                        AssetImage(cat["img"]),
                                                    fit: BoxFit.cover,
                                                    scale: 0.5)
                                                : null,
                                          ),
                                          child: cat["type"] == "icon"
                                              ? cat["title"] == "Todos"
                                                  ? Icon(
                                                      FontAwesomeIcons.cube,
                                                      color: DefaultColors
                                                          .background,
                                                    )
                                                  : Icon(
                                                      Icons.more_horiz_outlined,
                                                      color: DefaultColors
                                                          .background,
                                                    )
                                              : null,
                                        ),
                                      ),
                                      Text(
                                        cat["title"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: DefaultColors.background,
                                          fontFamily: "Changa",
                                          fontSize: size.height * 0.0225,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
          Column(
            children: <Widget>[
              Observer(builder: (_) {
                return Container(
                    height: controller.isSearch
                        ? size.height * 0.185
                        : size.height * 0.125);
              }),
              FutureBuilder(
                future: controller.recuperarProdPetShop(),
                builder: (context, snapshot) {
                  Widget defaultWidget;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    defaultWidget = Container(
                      height: size.height * 0.793,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              DefaultColors.background),
                        ),
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      List<ProdutoModel> prods = snapshot.data;
                      if (prods.length > 0) {
                        defaultWidget = ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              controller.animationDrawer.isShowDrawer ? 40 : 0,
                            ),
                          ),
                          child: Observer(builder: (_) {
                            double height = size.height * 0.675;
                            if (controller.isSearch)
                              height = size.height * 0.79 - size.height * 0.185;
                            return Container(
                              alignment: Alignment.topCenter,
                              height: height,
                              padding: EdgeInsets.only(
                                  top: size.height * 0.08),
                              child: RefreshIndicator(
                                color: DefaultColors.primary,
                                onRefresh: this.onRefreshProd,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: prods.map((prod) {
                                      return PostProduto(
                                        height: size.height,
                                        width: size.width,
                                        produtoModel: prod,
                                        onTap: () {
                                          if (controller
                                              .animationDrawer.isShowDrawer) {
                                            return;
                                          }
                                          // Modular.to.pushNamed("/home/produto");
                                          controller.showPostAdocao(
                                              prod, size.height);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        defaultWidget = Container(
                          height: size.height * 0.793,
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
                        height: size.height * 0.793,
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
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
