import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/submodules/graphics/graphics_module.dart';
import 'package:petmais/app/modules/home/widgets/ListInfo.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'perfil_petshop_controller.dart';

class PerfilPetshopPage extends StatefulWidget {
  final String title;
  const PerfilPetshopPage({Key key, this.title = "PerfilPetshop"})
      : super(key: key);

  @override
  _PerfilPetshopPageState createState() => _PerfilPetshopPageState();
}

class _PerfilPetshopPageState
    extends ModularState<PerfilPetshopPage, PerfilPetshopController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;

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
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        controller.animationDrawer.isShowDrawer ? 40 : 0)),
                child: Container(
                  height: size.height * 0.285,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                            controller.animationDrawer.isShowDrawer ? 40 : 0)),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      _listInfo(size),
                    ],
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.width * 0.6,
                alignment: Alignment.center,
                child: RouterOutlet(module: GraphicsModule()),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _headerPerfil(Size size) {
    // double width = size.width;
    double height = size.height;
    return Observer(builder: (_) {
      return Container(
        height: height * 0.325,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
          ),
        ),
        // Moldura
        child: Stack(
          children: <Widget>[
            Container(
              height: height * 0.315,
              decoration: BoxDecoration(
                color: DefaultColors.tertiary,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _photoPerfil(height),
                          Expanded(
                            child: Container(
                              height: height * 0.16,
                              padding: EdgeInsets.only(
                                  left: size.width * 0.02,
                                  right: size.width * 0.0095),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.usuarioInfo.nomeOrg,
                                          maxLines: 2,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            height: size.height * 0.0015,
                                            fontFamily: "Changa",
                                            fontSize: size.height * 0.0275,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          controller.usuarioInfo.formCnpj,
                                          maxLines: 2,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            height: size.height * 0.0015,
                                            fontFamily: "Changa",
                                            fontSize: size.height * 0.025,
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ],
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
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _photoPerfil(double height) {
    return Container(
      width: height * 0.2,
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
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
              ? (controller.usuario.usuarioInfo as UsuarioInfoModel).urlFoto ==
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
              borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
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
    );
  }

  Widget _listInfo(Size size) {
    return Container(
      height: size.height * 0.3,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.height * 0.2,
                height: size.height * 0.075,
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
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: size.width * 0.05,
                    right: size.width * 0.0095,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.usuarioInfo.endereco.toLogadouro(),
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            height: size.height * 0.0015,
                            fontFamily: "Changa",
                            fontSize: size.height * 0.0275,
                            color: DefaultColors.backgroundSmooth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Observer(builder: (_) {
            return ListInfo(
                usuario: controller.usuario,
                animationDrawer: controller.animationDrawer,
                isPetshop: true,
                onPressedUpd: () {
                  controller.showUpdUser();
                });
          }),
        ],
      ),
    );
  }
}
