import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:petmais/app/modules/home/submodules/adocao/widgets/PostAdotation.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';

import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomDropdownButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';

import 'aba_adocao_controller.dart';

class AbaAdocaoPage extends StatefulWidget {
  @override
  _AbaAdocaoPageState createState() => _AbaAdocaoPageState();
}

class _AbaAdocaoPageState
    extends ModularState<AbaAdocaoPage, AbaAdocaoController> {
  Future<void> onRefreshAdoption() async {
    setState(() {
      controller.recuperarAdocoes();
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.updateListAdption = this.onRefreshAdoption;
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
              height: size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      controller.animationDrawer.isShowDrawer ? 40 : 0),
                ),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Observer(
                      builder: (_) {
                        if (controller.isSearch == true) {
                          return AspectRatio(
                            aspectRatio: size.height / size.width,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: size.height * 0.25, //160,
                                width: size.width - 10,
                                padding: EdgeInsets.only(bottom: 12),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 6,
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          _searchForEspecieRaca(size),
                                          _searchForOng(size),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: DefaultColors.others,
                                          ),
                                          onPressed: () {
                                            controller.setIsOnlyONG(false);
                                            controller.setCloseSearch();
                                            controller
                                                .setEspecieSelect("Todos");
                                            controller.setRacaSelect("");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    Column(
                      children: <Widget>[
                        Observer(builder: (_) {
                          return controller.isSearch == true
                              ? Container(height: size.height * 0.25)
                              : Container();
                        }),
                        FutureBuilder(
                            future: controller.recuperarAdocoes(),
                            builder: (context, snapshot) {
                              Widget defaultWidget;
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                defaultWidget = Container(
                                  height: size.height * 0.793,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          DefaultColors.secondary),
                                    ),
                                  ),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data != null) {
                                  List<PostAdocaoModel> posts = snapshot.data;
                                  if (posts.length > 0) {
                                    defaultWidget = ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                          controller
                                                  .animationDrawer.isShowDrawer
                                              ? 40
                                              : 0,
                                        ),
                                      ),
                                      child: Observer(builder: (_) {
                                        bool isSearch = controller.isSearch;
                                        return Container(
                                          height: isSearch == true
                                              ? size.height * 0.793 -
                                                  size.height * 0.25
                                              : size.height * 0.793,
                                          child: RefreshIndicator(
                                            color: DefaultColors.primary,
                                            onRefresh: onRefreshAdoption,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: posts.map((post) {
                                                  //i++;
                                                  
                                                    return Column(
                                                      children: <Widget>[
                                                        PostAdotation(
                                                          idDono: controller
                                                                      .usuario ==
                                                                  null
                                                              ? 0
                                                              : controller
                                                                  .usuario
                                                                  .usuarioInfo
                                                                  .id,
                                                          postAdotationModel:
                                                              post,
                                                          onTap: () async {
                                                            if (controller
                                                                .animationDrawer
                                                                .isShowDrawer) {
                                                              return;
                                                            }
                                                            controller.adocao
                                                                .showPostAdocao(
                                                              post,
                                                              controller
                                                                          .adocao
                                                                          .auth
                                                                          .usuario
                                                                          .usuarioInfo
                                                                          .id !=
                                                                      null
                                                                  ? controller
                                                                      .adocao
                                                                      .auth
                                                                      .usuario
                                                                  : null,
                                                            );
                                                          },
                                                        ),
                                                      ],
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
                                          "Nenhuma Adoção Disponível :(",
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
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
      floatingActionButton: Observer(builder: (_) {
              List<SpeedDialChild> listFloatButton = [
                SpeedDialChild(
                  child: Container(
                      width: 20,
                      child: Image.asset(
                        "assets/images/paw/searchPaw.png",
                        scale: 0.8,
                      )),
                  label: "Procurar Pet",
                  labelStyle: TextStyle(
                      fontFamily: "Changa", color: DefaultColors.primary),
                  backgroundColor: DefaultColors.secondary,
                  onTap: () {
                    controller.setShowSearch();
                  },
                ),
              ];
              if (controller.adocao.auth.isLogged) {
                listFloatButton.add(
                  SpeedDialChild(
                    child: Icon(Icons.add_box, color: Colors.white),
                    label: "Adicionar Adoção",
                    labelStyle: TextStyle(
                        fontFamily: "Changa", color: DefaultColors.primary),
                    backgroundColor: DefaultColors.secondary,
                    onTap: () {
                      Modular.to.pushNamed("/home/addAdocao");
                    },
                  ),
                );
              }
              return SpeedDial(
                backgroundColor: DefaultColors.background,
                foregroundColor: Colors.white,
                overlayOpacity: 0,
                animatedIcon: AnimatedIcons.list_view,
                children: listFloatButton,
              );
            }),
    );
  }

  Widget _searchForEspecieRaca(Size size) {
    return Container(
      height: size.height * 0.14,
      width: size.width,
      padding: EdgeInsets.only(
        left: size.width * 0.025,
        right: size.width * 0.025,
        top: size.height * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(builder: (_) {
            return Theme(
              data: ThemeData(
                canvasColor: Colors.white,
              ),
              child: CustomDropdownButton<String>(
                isTitle: false,
                height: size.height * 0.06,
                width: size.width * 0.5,
                label: "Especie",
                // hint: "Espécie",
                items: controller.listEspecie,
                value: controller.especieSelect,
                onChanged: controller.setEspecieSelect,
                isDense: true,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "  [Campo Obrigatório]";
                  }
                  return null;
                },
              ),
            );
          }),
          Observer(builder: (_) {
            return Theme(
              data: ThemeData(
                canvasColor: Colors.white,
              ),
              child: CustomDropdownButton<String>(
                isTitle: false,
                height: size.height * 0.06,
                width: size.width * 0.5,
                label: "Raça",
                hint: "Raça",
                items: controller.listRaca,
                value: controller.racaSelect,
                onChanged: controller.setRacaSelect,
                isDense: true,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _searchForOng(Size size) {
    return Container(
      color: DefaultColors.primary,
      height: size.height * 0.075,
      width: size.width * 0.4,
      padding: EdgeInsets.only(
          right: size.width * 0.05,
          left: size.width * 0.01,
          top: size.height * 0.005),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Observer(builder: (_) {
            return CustomCheckBox(
              visualDensity:
                  VisualDensity(horizontal: VisualDensity.minimumDensity),
              text: "Apenas ONGs",
              value: controller.isOnlyONG,
              onChanged: controller.setIsOnlyONG,
              activeColor: DefaultColors.primary,
              onTap: () {
                controller.setIsOnlyONG(!controller.isOnlyONG);
              },
            );
          }),
        ],
      ),
    );
  }
}
