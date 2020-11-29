import 'dart:math';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
import 'package:petmais/app/modules/home/widgets/carousel/carousel_pro.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

import 'perfil_pet_controller.dart';

class PerfilPetPage extends StatefulWidget {
  final PetModel petModel;
  const PerfilPetPage({this.petModel});

  @override
  _PerfilPetPageState createState() => _PerfilPetPageState();
}

class _PerfilPetPageState
    extends ModularState<PerfilPetPage, PerfilPetController> {
  //use 'controller' variable to access controller
  void updateImage() {
    Future.delayed(Duration(milliseconds: 250), () {
      controller.pageController.jumpToPage(0);
      setState(() {
        imageCache.clear();
        imageCache.clearLiveImages();
      });
    });
  }

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    controller.setPet(widget.petModel);
    scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    controller.setUpdImg(updateImage);
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              backgroundColor: DefaultColors.primary,
              iconTheme: IconThemeData(color: DefaultColors.others),
              flexibleSpace: SafeArea(
                child: FlexibleSpaceBar(
                  titlePadding:
                      EdgeInsetsDirectional.only(start: 72, bottom: 6),
                  title: Text(
                    controller.pet.nome,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: "Changa",
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.3, 0.3),
                          blurRadius: 2.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Observer(builder: (_) {
                      return Carousel(
                        controller: controller.pageController,
                        autoplay: false,
                        dotSize: 7,
                        dotBgColor: Colors.transparent,
                        dotColor: Colors.white,
                        dotIncreasedColor: DefaultColors.primary,
                        images: controller.pet.petImages.listImages
                            .where((url) => url != "No Photo")
                            .map((url) {
                          return _getListaImagens(url);
                        }).toList(),
                      );
                    }),
                  ),
                ),
              ),
              leading: IconButton(
                icon: Stack(
                  children: <Widget>[
                    Positioned(
                      left: -0.5,
                      top: 1.0,
                      child: Icon(Icons.arrow_back, color: Colors.black26),
                    ),
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ],
                ),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
              actions: <Widget>[
                PopupMenuButton(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: -0.5,
                        top: 1.0,
                        child: Icon(Icons.more_vert,
                            color: Colors.black26, size: 28),
                      ),
                      Icon(Icons.more_vert, color: Colors.white, size: 28),
                    ],
                  ),
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
                ),
              ],
            ),
          ];
        },
        body: Container(
          child: SingleChildScrollView(
            controller: this.scrollController,
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: size.height * 0.055, child: Divider()),
                _listInfos(),
                SizedBox(height: 20),
                controller.pet.estado == 0
                    ? Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                DefaultColors.secondarySmooth,
                                DefaultColors.primarySmooth,
                              ],
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                              stops: [
                                -0.2,
                                1.0,
                              ]),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            final result = await Modular.to.pushNamed(
                              "/home/addAdocao",
                              arguments: controller.pet,
                            );
                            if (result != null && (result is AdocaoModel)) {
                              setState(() {
                                controller.pet.estado = 1;
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: size.width * 0.04,
                                  height: size.height * 0.075),
                              Icon(Icons.add_box,
                                  color: Colors.white, size: 30),
                              SizedBox(width: 10),
                              Text("Adicionar para Adoção",
                                  style: kButtonStyle),
                            ],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: Theme(
                          data: ThemeData(
                            accentColor: DefaultColors.secondary,
                            unselectedWidgetColor:
                                DefaultColors.secondarySmooth,
                            canvasColor: Colors.white,
                          ),
                          child: ExpansionTileCard(
                            onExpansionChanged: (bool isExpansion) {
                              if (isExpansion) {
                                Future.delayed(Duration(milliseconds: 250), () {
                                  double desl = (size.height * 0.375);
                                  this.scrollController.animateTo(
                                        desl,
                                        duration: Duration(milliseconds: 150),
                                        curve: Curves.easeIn,
                                      );
                                });
                              }
                            },
                            // baseColor: DefaultColors.secondary,
                            // colorCurve: DefaultColors.secondary,

                            title: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      DefaultColors.secondarySmooth,
                                      DefaultColors.primarySmooth,
                                      Colors.white,
                                    ],
                                    begin: AlignmentDirectional.topStart,
                                    end: AlignmentDirectional.bottomEnd,
                                    stops: [
                                      -0.2,
                                      0.5,
                                      1.0,
                                    ]),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.check,
                                      size: 30, color: Colors.white),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      " Para Adoção",
                                      style: kButtonStyle,
                                      // style: TextStyle(
                                      //   // color: DefaultColors.secondary,
                                      //   color: Colors.white,
                                      //   fontFamily: 'OpenSans',
                                      //   fontWeight: FontWeight.w500,
                                      //   fontSize: 18,
                                      // ),
                                    ),
                                  ),
                                ],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: _getPetInAdocao(size),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPetInAdocao(Size size) {
    return FutureBuilder<PostAdocaoModel>(
      future: controller.recuperarPetAdocao(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            PostAdocaoModel postAdocao = snapshot.data;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          postAdocao.email,
                          style: TextStyle(
                            color: DefaultColors.secondarySmooth,
                            fontFamily: "Changa",
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          controller.usuario.usuarioInfo
                                  is UsuarioInfoJuridicoModel
                              ? controller
                                  .formatterPhone(postAdocao.numeroTelefone)
                              : postAdocao.numeroTelefone,
                          style: TextStyle(
                            color: DefaultColors.secondarySmooth,
                            fontFamily: "Changa",
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Descrição",
                          textAlign: TextAlign.start,
                          style: kLabelTitleStyle,
                        ),
                        Row(children: [
                          Expanded(
                            child: Text(
                              postAdocao.descricao,
                              style: TextStyle(
                                color: DefaultColors.secondarySmooth,
                                fontFamily: "Changa",
                              ),
                            ),
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  color: DefaultColors.secondary,
                                  icon: Icon(FontAwesomeIcons.solidEdit),
                                  onPressed: () async {
                                    await Modular.to
                                        .pushNamed(
                                      "/home/adocaoUpd",
                                      arguments: postAdocao,
                                    )
                                        .then((dynamic adocaoModel) {
                                      if (adocaoModel != null &&
                                          (adocaoModel is AdocaoModel)) {
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          double desl = (size.height * 0.3);
                                          this.scrollController.animateTo(desl,
                                              duration:
                                                  Duration(milliseconds: 150),
                                              curve: Curves.easeIn);
                                        });
                                        setState(() {
                                          postAdocao.email = adocaoModel.email;
                                          postAdocao.numeroTelefone =
                                              adocaoModel.numeroTelefone;
                                          postAdocao.descricao =
                                              adocaoModel.descricao;
                                        });
                                      }
                                    });
                                  },
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  color: DefaultColors.secondary,
                                  icon: Icon(FontAwesomeIcons.trashAlt),
                                  onPressed: () {
                                    controller
                                        .onPressedDel(size, postAdocao.idPet)
                                        .then((bool result) {
                                      if (result == true) {
                                        setState(() {
                                          controller.pet.estado = 0;
                                        });
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "Erro na Conexão",
                style: TextStyle(
                  color: DefaultColors.error,
                  fontSize: 16,
                  fontFamily: "Changa",
                ),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                DefaultColors.secondary,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _getListaImagens(String url) {
    return Container(
      key: ValueKey(new Random().nextInt(100)),
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _listInfos() {
    String sexo;
    if (controller.pet.sexo == "M") {
      sexo = "Macho";
    } else if (controller.pet.sexo == "F") {
      sexo = "Fêmea";
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.6, 0.6),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              padding: EdgeInsets.all(0),
              visualDensity:
                  VisualDensity(vertical: VisualDensity.minimumDensity),
              icon: Icon(
                Icons.edit,
                color: DefaultColors.secondary,
              ),
              onPressed: () async {
                await controller.showUpdPet().then((_) {
                  setState(() {});
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    controller.pet.especie,
                    style: kDescriptionBigStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    controller.pet.raca.isNotEmpty
                        ? "Raça: ${controller.pet.raca}"
                        : "Raça:  - ",
                    style: kDescriptionBigStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Sexo: " + sexo,
                    style: kDescriptionBigStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    controller.pet.dataNascimento != null
                        ? "Data: ${controller.pet.dataNascimento}"
                        : "Data:  - ",
                    style: kDescriptionBigStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
