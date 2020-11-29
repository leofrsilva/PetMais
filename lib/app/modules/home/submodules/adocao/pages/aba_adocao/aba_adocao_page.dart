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

  FocusNode _focusRaca = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusRaca.addListener(() {
      // print("Has raça focus: ${_focusRaca.hasFocus}");
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusRaca.dispose();
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
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          _searchForEspecie(size),
                                          _searchForRaca(size),
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
                                            setState(() {
                                              controller.setIsCat(null);
                                              controller.setIsDog(null);
                                              controller.racaController.clear();
                                              controller.recuperarAdocoes();
                                              controller.setCloseSearch();
                                            });
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
                                                  if (controller.usuario !=
                                                      null) {
                                                    return Column(
                                                      children: <Widget>[
                                                        PostAdotation(
                                                          idDono: controller
                                                                      .usuario
                                                                      .usuarioInfo ==
                                                                  null
                                                              ? 0
                                                              : controller
                                                                  .usuario
                                                                  .usuarioInfo
                                                                  .id,
                                                          postAdotationModel:
                                                              post,
                                                          onTap: () async {
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
                                                  } else {
                                                    return Container();
                                                  }
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
      floatingActionButton: _focusRaca.hasFocus
          ? FloatingActionButton(
              backgroundColor: DefaultColors.background,
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
            )
          : Observer(builder: (_) {
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

  Widget _searchForEspecie(Size size) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.45,
      padding: EdgeInsets.only(left: 8, top: 12),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Observer(builder: (_) {
            return CustomCheckBox(
              visualDensity:
                  VisualDensity(horizontal: VisualDensity.minimumDensity),
              text: "Cachorro",
              value: controller.isDog,
              onChanged: controller.setIsDog,
              activeColor: DefaultColors.primary,
              onTap: () {
                controller.setIsDog(!controller.isDog);
              },
            );
          }),
          Observer(builder: (_) {
            return CustomCheckBox(
              visualDensity:
                  VisualDensity(horizontal: VisualDensity.minimumDensity),
              text: "Gato",
              value: controller.isCat,
              onChanged: controller.setIsCat,
              activeColor: DefaultColors.primary,
              onTap: () {
                controller.setIsCat(!controller.isCat);
              },
            );
          }),
        ],
      ),
      // CustomRadioButton(
      //   size: size,
      //   label: "Especie",
      //   activeColor: DefaultColors.primary,
      //   primaryTitle: "Cachorro",
      //   primaryValue: "cachorro",
      //   secondyTitle: "Gato",
      //   secondyValue: "gato",
      //   groupValue: controller.especie,
      //   primaryOnChanged: controller.setEspecie,
      //   secondyOnChanged: controller.setEspecie,
      // ),
    );
  }

  Widget _searchForRaca(Size size) {
    return Container(
      height: size.height * 0.25,
      width: size.width * 0.5,
      padding: EdgeInsets.only(top: 12),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Observer(builder: (_) {
            return CustomTextField(
              isTitle: false,
              height: size.height * 0.06,
              heightText: size.height * 0.05,
              focusNode: _focusRaca,
              readOnly: controller.animationDrawer.isShowDrawer ? true : false,
              controller: controller.racaController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (String value) {
                FocusScope.of(context).unfocus();
              },
              label: "Raça",
              hint: "Raça do pet ...",
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                  PetModel.toNumCaracteres()["raca"],
                ),
              ],
              textInputType: TextInputType.text,
              validator: (String value) {
                if (value.isEmpty) {
                  return "    [O campo é obrigatório]";
                }
                return null;
              },
            );
          }),
          SizedBox(height: size.height * 0.02),
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
          // RaisedButton.icon(
          //   onPressed: () {
          //     setState(() {
          //       controller.recuperarAdocoes();
          //     });
          //   },
          //   icon: Icon(FontAwesomeIcons.paw),
          //   label: Text("Buscar"),
          //   elevation: 0,
          //   color: DefaultColors.primarySmooth, //Colors.grey[100],
          //   textColor: DefaultColors.secondarySmooth,
          //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          //   shape: ContinuousRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          // ),
        ],
      ),
    );
  }
}
