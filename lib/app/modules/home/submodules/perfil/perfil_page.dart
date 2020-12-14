import 'dart:math';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/perfil/widgets/PetsAdocao.dart';
import 'package:petmais/app/modules/home/widgets/BottomSheetPostAdocao.dart';
import 'package:petmais/app/modules/home/widgets/ImageMeuPet.dart';
import 'package:petmais/app/modules/home/widgets/ImagePet.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import '../../widgets/ListInfo.dart';
import 'perfil_controller.dart';

class PerfilPage extends StatefulWidget {
  final String title;
  const PerfilPage({Key key, this.title = "Perfil"}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends ModularState<PerfilPage, PerfilController> {
  //use 'controller' variable to access controller

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;
    //? -------------------------------

    return Scaffold(
      backgroundColor: DefaultColors.secondary,
      body: Observer(builder: (_) {
        return Container(
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
              bottomLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
            ),
          ),
          child: Column(
            children: <Widget>[
              _headerPerfil(size),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          controller.animationDrawer.isShowDrawer ? 40 : 0)),
                  child: Container(
                    height: size.height * 0.69,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              controller.animationDrawer.isShowDrawer
                                  ? 40
                                  : 0)),
                    ),
                    child: ListView(
                      controller: this.scrollController,
                      padding: const EdgeInsets.all(0),
                      children: <Widget>[
                        Observer(builder: (_) {
                          return ListInfo(
                              usuario: controller.usuario,
                              animationDrawer: controller.animationDrawer,
                              onPressedUpd: () {
                                controller.showUpdUser();
                              });
                        }),
                        _listPets(size),
                      ],
                    ),
                    // child: Container(),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _headerPerfil(Size size) {
    double width = size.width;
    double height = size.height;
    return Observer(builder: (_) {
      return Container(
        height: height * 0.310,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
          ),
        ),
        // Moldura
        child: Stack(
          children: <Widget>[
            Container(
              height: height * 0.168,
              decoration: BoxDecoration(
                color: DefaultColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      controller.animationDrawer.isShowDrawer ? 40 : 0),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: IconButton(
                            icon: Icon(
                              controller.animationDrawer.isShowDrawer
                                  ? Icons.arrow_back
                                  : Icons.menu,
                              color: Colors.black26,
                            ),
                            onPressed: () {
                              if (controller.animationDrawer.isShowDrawer) {
                                controller.animationDrawer.closeDrawer();
                              } else {
                                FocusScope.of(context).unfocus();
                                controller.animationDrawer.openDrawer();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              width: width / 2,
              left: -40,
              top: 250 * 0.45,
              child: IconButton(
                icon: Icon(Icons.pets, color: DefaultColors.secondary),
                onPressed: () {
                  controller.home.changePage(3);
                },
              ),
            ),
            Positioned(
              width: width / 2,
              right: -40,
              top: 250 * 0.45,
              child: PopupMenuButton<String>(
                onSelected: (String result) {
                  controller.updateFotoUser(result).then((_) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() {
                        imageCache.clear();
                        imageCache.clearLiveImages();
                        controller.atualizarImage();
                      });
                    });
                  });
                },
                //-----------------
                offset: Offset(-1, 1),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                      Icon(Icons.add_a_photo, color: DefaultColors.secondary),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: "camera",
                    child: Text("Câmera"),
                  ),
                  const PopupMenuItem<String>(
                    value: "galeria",
                    child: Text("Galeria"),
                  ),
                ],
              ),
            ),
            // Photo
            Align(
              alignment: Alignment.bottomCenter,
              child: _photoPerfil(height),
            ),
          ],
        ),
      );
    });
  }

  Widget _photoPerfil(double height) {
    final moldePhoto = Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: Container(
        width: height * 0.23,
        height: height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DefaultColors.others.withOpacity(0.5),
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
          color: DefaultColors.others,
        ),
        child: (controller.usuario.usuarioInfo is UsuarioInfoModel
                ? (controller.usuario.usuarioInfo as UsuarioInfoModel)
                        .urlFoto ==
                    "No Photo"
                : (controller.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                        .urlFoto ==
                    "No Photo")
            ? Icon(
                Icons.person,
                size: 60,
                color: Colors.white.withOpacity(0.5),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  controller.usuario.usuarioInfo is UsuarioInfoModel
                      ? (controller.usuario.usuarioInfo as UsuarioInfoModel)
                          .urlFoto
                      : (controller.usuario.usuarioInfo
                              as UsuarioInfoJuridicoModel)
                          .urlFoto,
                  key: ValueKey(new Random().nextInt(100)),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
    return moldePhoto;
  }

  Widget _listPets(Size size) {
    if (controller.usuario.usuarioInfo is UsuarioInfoModel) {
      return ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTileCard(
                  onExpansionChanged: (bool isExpansion) {
                    if (isExpansion) {
                      Future.delayed(Duration(milliseconds: 250), () {
                        this.scrollController.animateTo(
                              size.height * 0.175,
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeIn,
                            );
                      });
                    }
                  },
                  title: Text(
                    " Pets",
                    style: TextStyle(
                      color: DefaultColors.secondary,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        bottom: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: size.height * 0.2,
                            width: 4,
                            color: DefaultColors.background,
                          ),
                          Expanded(
                            child: getListPets(size),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTileCard(
                  onExpansionChanged: (bool isExpansion) {
                    if (isExpansion) {
                      Future.delayed(Duration(milliseconds: 250), () {
                        double desl = (size.height * 0.175) <
                                this.scrollController.position.maxScrollExtent
                            ? (size.height * 0.175 * 2.55)
                            : (size.height * 0.175);
                        this.scrollController.animateTo(
                              desl,
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeIn,
                            );
                      });
                    }
                  },
                  title: Text(
                    " Pets em Adoção",
                    style: TextStyle(
                      color: DefaultColors.secondary,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        bottom: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: size.height * 0.2,
                            width: 4,
                            color: DefaultColors.background,
                          ),
                          Expanded(
                            child: getListPetsAdocao(size),
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
    } else {
      return FutureBuilder<List<PostAdocaoModel>>(
        future: controller.recuperarPetsAdocao(),
        builder: (context, snapshot) {
          List<PostAdocaoModel> listPets = snapshot.data;

          Widget defaultWidget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              if (listPets.length > 0) {
                defaultWidget = ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.01),
                    height: size.height * 0.254,
                    width: size.width,
                    alignment: Alignment.center,
                    child: PageView.builder(
                      itemCount: listPets.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async {
                            PostAdocaoModel pet = listPets[index];
                            controller.showPostAdocao(
                              pet,
                              controller.usuario.usuarioInfo.id != null
                                  ? controller.usuario
                                  : null,
                              onPressedDelete: () {
                                controller
                                    .onPressedDel(size, pet.idPet)
                                    .then((bool result) {
                                  if (result == true) {
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  }
                                });
                              },
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02),
                            height: size.height * 0.254,
                            width: size.width,
                            child: PetsAdocao(
                              size: size,
                              height: size.height * 0.254,
                              adocaoModel: listPets[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                defaultWidget = ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    height: size.height * 0.254,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "Nenhum Pet para Adoção!",
                      style: TextStyle(
                        color: DefaultColors.backgroundSmooth,
                        fontSize: 18,
                        fontFamily: "Changa",
                      ),
                    ),
                  ),
                );
              }
            } else {
              defaultWidget = ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  height: size.height * 0.194,
                  color: Colors.white,
                  alignment: Alignment.center,
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            defaultWidget = Container(
              height: size.height * 0.194,
              alignment: Alignment.center,
              child: Container(
                height: 27.5,
                width: 27.5,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(DefaultColors.secondary),
                ),
              ),
            );
          } else {
            defaultWidget = Container();
          }
          return defaultWidget;
        },
      );
    }
  }

  Widget getListPets(Size size) {
    return Container(
      child: FutureBuilder<List<PetModel>>(
        future: controller.recuperarPets(),
        builder: (context, snapshot) {
          Widget defaultWidget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              List<PetModel> listPets = snapshot.data;
              if (listPets.length > 0) {
                defaultWidget = Container(
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            controller.animationDrawer.isShowDrawer ? 40 : 0)),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listPets?.length ?? 0,
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (_, int index) {
                        //* Pets
                        PetModel pet = listPets[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ImageMeuPet(
                            size: size.height * 0.2,
                            petModel: pet,
                            onTap: () async {
                              await Modular.to
                                  .pushNamed("/home/perfilPet",
                                      arguments: listPets[index])
                                  .then((_) {
                                setState(() {});
                              });
                            },
                          ),
                        );
                      }),
                );
              } else {
                defaultWidget = ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    height: size.height * 0.194,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "Nenhum Pet encontrado!",
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
              defaultWidget = ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  height: size.height * 0.194,
                  color: Colors.white,
                  alignment: Alignment.center,
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            defaultWidget = Container(
              height: size.height * 0.194,
              alignment: Alignment.center,
              child: Container(
                height: 27.5,
                width: 27.5,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(DefaultColors.secondary),
                ),
              ),
            );
          } else {
            defaultWidget = Container();
          }
          return defaultWidget;
        },
      ),
    );
  }

  Widget getListPetsAdocao(Size size) {
    return Container(
      child: FutureBuilder<List<PostAdocaoModel>>(
        future: controller.recuperarPetsAdocao(),
        builder: (context, snapshot) {
          Widget defaultWidget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              List<PostAdocaoModel> listPets = snapshot.data;
              if (listPets.length > 0) {
                defaultWidget = Container(
                  height: size.height * 0.2,
                  width: size.height * 0.2,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            controller.animationDrawer.isShowDrawer ? 40 : 0)),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listPets?.length ?? 0,
                      padding: const EdgeInsets.all(4.0),
                      itemBuilder: (_, int index) {
                        //* Pets para Adoção
                        PostAdocaoModel petAdocao = listPets[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ImagePet(
                            size: size.height * 0.2,
                            urlImage: petAdocao.petImages.imgPrincipal,
                            onTap: () async {
                              await showModalBottomSheet(
                                elevation: 6.0,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return BottomSheetPostAdocao(
                                    postAdotation: petAdocao,
                                    usuarioModel: controller.usuario ?? null,
                                    isUpd: true,
                                    isDelete: true,
                                    onPressedDel: () {
                                      controller
                                          .onPressedDel(size, petAdocao.idPet)
                                          .then((bool result) {
                                        if (result == true) {
                                          Navigator.of(context).pop();
                                        }
                                      });
                                    },
                                  );
                                },
                              ).then((_) {
                                setState(() {});
                              });
                            },
                          ),
                        );
                      }),
                );
              } else {
                defaultWidget = ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    height: size.height * 0.194,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "Nenhum Pet para Adoção!",
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
              defaultWidget = ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  height: size.height * 0.194,
                  color: Colors.white,
                  alignment: Alignment.center,
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            defaultWidget = Container(
              height: size.height * 0.194,
              alignment: Alignment.center,
              child: Container(
                height: 27.5,
                width: 27.5,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(DefaultColors.secondary),
                ),
              ),
            );
          } else {
            defaultWidget = Container();
          }
          return defaultWidget;
        },
      ),
    );
  }
}
