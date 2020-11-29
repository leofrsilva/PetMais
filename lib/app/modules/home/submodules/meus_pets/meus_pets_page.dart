import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/widgets/ImageMeuPet.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'meus_pets_controller.dart';

class MeusPetsPage extends StatefulWidget {
  final String title;
  const MeusPetsPage({Key key, this.title = "MeusPets"}) : super(key: key);

  @override
  _MeusPetsPageState createState() => _MeusPetsPageState();
}

class _MeusPetsPageState
    extends ModularState<MeusPetsPage, MeusPetsController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DefaultColors.secondary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.084),
        child: Observer(builder: (_) {
          return AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
            )),
            leading: IconButton(
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
                }),
            title: Text(
              "Meus Pets",
              style: kLabelTitleAppBarStyle,
            ),
            iconTheme: IconThemeData(
              color: DefaultColors.others,
            ),
            actions: <Widget>[
              PopupMenuButton(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onSelected: controller.onTapSelected,
                itemBuilder: (context) => controller.listOp.map((String op) {
                  return PopupMenuItem<String>(
                    value: op,
                    child: Text(op),
                  );
                }).toList(),
              )
            ],
          );
        }),
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                    controller.animationDrawer.isShowDrawer ? 40 : 0),
              ),
            ),
            child: _listPets(size),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: DefaultColors.secondary,
        child: Container(
            width: 36, child: Image.asset("assets/images/paw/addPaw.png")),
        onPressed: () {
          Navigator.of(context).pushNamed("/addPet").then((_) {
            //* Atualizar Página
            setState(() {});
          });
        },
      ),
    );
  }

  Widget _listPets(Size size) {
    return FutureBuilder<List<PetModel>>(
      future: controller.recuperarPets(),
      builder: (context, snapshot) {
        Widget defaultWidget;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            List<PetModel> listPets = snapshot.data;
            if (listPets.length > 0) {
              if (controller.usuario.usuarioInfo is UsuarioInfoJuridicoModel) {
                // List Pets the Ong
                return _listPetsForOng(listPets, size);
              }
              // List User Comum
              defaultWidget = Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      controller.animationDrawer.isShowDrawer ? 40 : 0,
                    ),
                  ),
                  child: GridView.builder(
                    itemCount: listPets?.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, top: 10.0),
                    itemBuilder: (context, index) {
                      return ImageMeuPet(
                        petModel: listPets[index],
                        onTap: () async {
                          await Modular.to
                              .pushNamed("/home/perfilPet",
                                  arguments: listPets[index])
                              .then((_) {
                            setState(() {});
                          });
                        },
                      );
                    },
                  ),
                ),
              );
            } else {
              defaultWidget = Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Você não possui nenhum Pet!",
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
            defaultWidget = Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
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
          defaultWidget = Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(DefaultColors.secondary),
            ),
          );
        } else {
          defaultWidget = Container();
        }
        return defaultWidget;
      },
    );
  }

  Widget _listPetsForOng(List<PetModel> listPets, Size size) {
    Map<String, List<PetModel>> order = controller.ordernarPetsFor(listPets);

    Widget orderPets;
    if (controller.selectedTypeGroup == controller.listTypeGroup[0]) {
      List<PetModel> petDogs = order["dog"];
      List<PetModel> petCats = order["cat"];
      double sizeImgPetsDog =
          (petDogs.length / 3).ceilToDouble() * size.width * 0.33;
      double sizeImgPetsCat =
          (petCats.length / 3).ceilToDouble() * size.width * 0.33;
      orderPets = Column(
        children: [
          if (petDogs.length > 0)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.035,
                    ),
                    child: Text(
                      "Cachorro",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Changa",
                        color: DefaultColors.secondarySmooth,
                        // color: Colors.black26,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.greenAccent,
                    height: sizeImgPetsDog,
                    padding: EdgeInsets.only(right: (size.width * 0.0075) / 4),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: petDogs.map((pet) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: (size.width * 0.01) / 4,
                            bottom: (size.width * 0.01) / 4,
                          ),
                          child: ImageMeuPet(
                            size: size.width * 0.3225,
                            petModel: pet,
                            onTap: () async {
                              await Modular.to
                                  .pushNamed("/home/perfilPet", arguments: pet)
                                  .then((_) {
                                setState(() {});
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          if (petCats.length > 0)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.035,
                    ),
                    child: Text(
                      "Gato",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Changa",
                        color: DefaultColors.secondarySmooth,
                        // color: Colors.black26,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.greenAccent,
                    height: sizeImgPetsCat,
                    padding: EdgeInsets.only(right: (size.width * 0.0075) / 4),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: petCats.map((pet) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: (size.width * 0.01) / 4,
                            bottom: (size.width * 0.01) / 4,
                          ),
                          child: ImageMeuPet(
                            size: size.width * 0.3225,
                            petModel: pet,
                            onTap: () async {
                              await Modular.to
                                  .pushNamed("/home/perfilPet", arguments: pet)
                                  .then((_) {
                                setState(() {});
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    } else if (controller.selectedTypeGroup == controller.listTypeGroup[1]) {
      List<PetModel> petM = order["macho"];
      List<PetModel> petF = order["femea"];
      double sizeImgPetsM =
          (petM.length / 3).ceilToDouble() * size.width * 0.33;
      double sizeImgPetsF =
          (petF.length / 3).ceilToDouble() * size.width * 0.33;
      orderPets = Column(
        children: [
          if (petM.length > 0)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.035,
                    ),
                    child: Text(
                      "Macho",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Changa",
                        color: DefaultColors.secondarySmooth,
                        // color: Colors.black26,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.greenAccent,
                    height: sizeImgPetsM,
                    padding: EdgeInsets.only(right: (size.width * 0.0075) / 4),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: petM.map((pet) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: (size.width * 0.01) / 4,
                            bottom: (size.width * 0.01) / 4,
                          ),
                          child: ImageMeuPet(
                            size: size.width * 0.3225,
                            petModel: pet,
                            onTap: () async {
                              await Modular.to
                                  .pushNamed("/home/perfilPet", arguments: pet)
                                  .then((_) {
                                setState(() {});
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          if (petF.length > 0)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.05,
                      top: size.height * 0.035,
                    ),
                    child: Text(
                      "Fêmea",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Changa",
                        color: DefaultColors.secondarySmooth,
                        // color: Colors.black26,
                        fontSize: size.height * 0.035,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.greenAccent,
                    height: sizeImgPetsF,
                    padding: EdgeInsets.only(right: (size.width * 0.0075) / 4),
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: petF.map((pet) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: (size.width * 0.01) / 4,
                            bottom: (size.width * 0.01) / 4,
                          ),
                          child: ImageMeuPet(
                            size: size.width * 0.3225,
                            petModel: pet,
                            onTap: () async {
                              await Modular.to
                                  .pushNamed("/home/perfilPet", arguments: pet)
                                  .then((_) {
                                setState(() {});
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    return Container(
      padding: EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            controller.animationDrawer.isShowDrawer ? 40 : 0,
          ),
        ),
        child: ListView(
          children: [
            orderPets,
          ],
        ),
      ),
    );
  }
}
