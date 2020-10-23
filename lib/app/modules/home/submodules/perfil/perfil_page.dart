import 'dart:math';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/pages/show_post_adocao/show_post_adocao_page.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
import 'package:petmais/app/modules/home/widgets/BottomSheetPostAdocao.dart';
import 'package:petmais/app/modules/home/widgets/ImageMeuPet.dart';
import 'package:petmais/app/modules/home/widgets/ImagePet.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'widgets/ListInfo.dart';
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
              bottomLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              // physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _headerPerfil(size),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          controller.animationDrawer.isShowDrawer ? 40 : 0)),
                  child: Container(
                    height: size.height * 0.645,
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
                  ),
                ),
              ],
            ),
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
        height: height * 0.355,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
          ),
        ),
        // Moldura
        child: Stack(
          children: <Widget>[
            Container(
              height: height * 0.195,
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
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: Icon(
                          controller.animationDrawer.isShowDrawer
                              ? Icons.arrow_back
                              : Icons.menu,
                          color: Colors.grey,
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
              ),
            ),
            Positioned(
              width: width / 2,
              left: -40,
              top: 250 * 0.5,
              child: IconButton(
                icon: Icon(Icons.pets, color: DefaultColors.secondary),
                onPressed: () {
                  controller.home.changePage(2);
                },
              ),
            ),
            Positioned(
              width: width / 2,
              right: -40,
              top: 250 * 0.5,
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
        width: 175,
        height: 175,
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
        child: controller.usuario.usuarioInfoModel.urlFoto == "No Photo"
            ? Icon(
                Icons.person,
                size: 60,
                color: Colors.white.withOpacity(0.5),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  controller.usuario.usuarioInfoModel.urlFoto,
                  key: ValueKey(new Random().nextInt(100)),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
    return moldePhoto;
  }

  Widget _listPets(Size size) {
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
                          ? (size.height * 0.175 * 2.35)
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
                              // await Modular.to.showDialog(
                              //   builder: (context) {
                              //     return Center(
                              //       child: StatefulBuilder(
                              //           builder: (context, setState) {
                              //         return ShowPostAdocaoPage(
                              //           postAdotation: petAdocao,
                              //           usuarioModel:
                              //               controller.usuario ?? null,
                              //           isUpd: true,
                              //           isDelete: true,
                              //           onPressedUpd: () async {
                              //             await Modular.to
                              //                 .pushNamed(
                              //               "/home/adocaoUpd",
                              //               arguments: petAdocao,
                              //             )
                              //                 .then((dynamic adocaoModel) {
                              //               if (adocaoModel != null &&
                              //                   (adocaoModel is AdocaoModel)) {
                              //                 setState(() {
                              //                   petAdocao.email =
                              //                       adocaoModel.email;
                              //                   petAdocao.numeroTelefone =
                              //                       adocaoModel.numeroTelefone;
                              //                   petAdocao.descricao =
                              //                       adocaoModel.descricao;
                              //                 });
                              //               }
                              //             });
                              //           },
                              //           onPressedDel: () {
                              //             controller
                              //                 .onPressedDel(
                              //                     size, petAdocao.idPet)
                              //                 .then((bool result) {
                              //               if (result == true) {
                              //                 Modular.to.pop();
                              //               }
                              //             });
                              //           },
                              //         );
                              //       }),
                              //     );
                              //   },
                              // ).then((_) {
                              //   setState(() {});
                              // });
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
