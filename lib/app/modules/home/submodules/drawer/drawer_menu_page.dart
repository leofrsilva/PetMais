import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

import 'drawer_menu_controller.dart';

class DrawerMenuPage extends StatefulWidget {
  final String title;
  const DrawerMenuPage({Key key, this.title = "Drawer"}) : super(key: key);

  @override
  _DrawerMenuPageState createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState
    extends ModularState<DrawerMenuPage, DrawerMenuController> {
  //use 'controller' variable to access controller

  void updateImage() {
    setState(() {
      imageCache.clearLiveImages();
    });
  }

  void updateInfo() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    controller.setFunctionClearCache(updateImage);
    controller.setFunctionResetInfo(updateInfo);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: DefaultColors.secondary,
        child: controller.auth.isLogged == true
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: _avatar(
                        size,
                        nome: controller.usuario.usuarioInfo is UsuarioInfoModel
                            ? (controller.usuario.usuarioInfo
                                    as UsuarioInfoModel)
                                .nome
                            : (controller.usuario.usuarioInfo
                                    as UsuarioInfoJuridicoModel)
                                .nomeOrg,
                        email: controller.usuario.email,
                        urlFoto:
                            controller.usuario.usuarioInfo is UsuarioInfoModel
                                ? (controller.usuario.usuarioInfo
                                        as UsuarioInfoModel)
                                    .urlFoto
                                : (controller.usuario.usuarioInfo
                                        as UsuarioInfoJuridicoModel)
                                    .urlFoto,
                      ),
                    ),
                    Container(
                      height: size.height - 150,
                      child: _listMenu(controller.usuario),
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  Widget _avatar(Size size, {String nome, String email, String urlFoto}) {
    return Padding(
      padding: EdgeInsets.only(top: 18.0, bottom: 18.0, left: 18.0, right: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(40),
              boxShadow: urlFoto == "No Photo"
                  ? null
                  : <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[600],
                        blurRadius: 4.0,
                        offset: Offset(2.5, 2.5),
                      ),
                    ],
            ),
            child: urlFoto == "No Photo"
                ? Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.white.withOpacity(0.5),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      urlFoto,
                      key: ValueKey(new Random().nextInt(100)),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: size.width * 0.60,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          nome,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: nome.length <= 13 ? 24 : 18,
                            fontFamily:
                                'OpenSans', //GoogleFonts.montserrat().fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            wordSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.60,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          email,
                          style: kLabelSubTitleStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listMenu(UsuarioModel user) {
    bool removeAdocao = false;
    if (controller.usuario.usuarioInfo is UsuarioInfoJuridicoModel) {
      if ((controller.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
              .typeJuridico ==
          TypeJuridico.petshop) {
        removeAdocao = true;
      }
    }
    return Observer(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            if (!removeAdocao)
              _tilesImage(
                title: "ADOÇÂO",
                url: "assets/images/btnAdocao.png",
                selected: controller.opSelected == 1 ? true : false,
                onTap: () {
                  controller.setOpSelected(1);
                  controller.animationDrawer.closeDrawer();
                },
              ),
            if (!removeAdocao) SizedBox(height: 5),
            _tilesImage(
              title: "PET SHOP",
              url: "assets/images/btnPetShop.png",
              selected: controller.opSelected == 0 ? true : false,
              onTap: () {
                controller.setOpSelected(0);
                controller.animationDrawer.closeDrawer();
              },
            ),
            _tiles(
              title: "PERFIL",
              icon: Icons.account_circle,
              selected: removeAdocao ? controller.opSelected == 1 ? true : false : controller.opSelected == 2 ? true : false,
              onTap: () {
                if (removeAdocao) {
                  controller.setOpSelected(1);
                } else {
                  controller.setOpSelected(2);
                }
                controller.animationDrawer.closeDrawer();
              },
            ),
            if (!removeAdocao)
              _tiles(
                title: "MEUS PETS",
                icon: Icons.pets,
                selected: controller.opSelected == 3 ? true : false,
                onTap: () {
                  controller.setOpSelected(3);
                  controller.animationDrawer.closeDrawer();
                },
              ),
            if (!removeAdocao)
              _tiles(
                title: "USUÁRIOS",
                icon: Icons.search,
                selected: controller.opSelected == 4 ? true : false,
                onTap: () async {
                  if (removeAdocao) {
                    controller.setOpSelected(2);
                  } else {
                    controller.setOpSelected(4);
                  }
                  controller.animationDrawer.closeDrawer();
                },
              ),
            if (removeAdocao)
              _tiles(
                title: "CHAT",
                icon: Icons.message_outlined,
                selected: controller.opSelected == 2 ? true : false,
                onTap: () async {
                  controller.setOpSelected(2);
                  controller.animationDrawer.closeDrawer();
                },
              ),
            Divider(),
            _tiles(
              title: "SAIR",
              icon: Icons.exit_to_app,
              selected: controller.isSair,
              onTap: () {
                controller.setSair(true);
                controller.animationDrawer.closeDrawer();
                controller.exitApp();
                Modular.to.pushNamedAndRemoveUntil("/auth", (_) => false);
              },
            ),
          ],
        ),
      );
    });
  }

  //cria cada item do menu
  Widget _tiles({String title, IconData icon, bool selected, Function onTap}) {
    return ListTile(
      enabled: true,
      leading: Icon(
        icon,
        size: selected == true ? 30 : 24,
        color: selected == true
            ? DefaultColors.primary
            : DefaultColors.backgroundSmooth,
      ),
      selected: selected ?? false,
      title: Text(
        title,
        style: selected == true ? kItemSelected : kItemNoSelected,
      ),
      onTap: onTap,
    );
  }

  Widget _tilesImage(
      {String title, String url, bool selected, Function onTap}) {
    return ListTile(
      enabled: true,
      leading: Image.asset(url),
      selected: selected ?? false,
      title: Text(
        title,
        style: selected == true ? kItemSelected : kItemNoSelected,
      ),
      onTap: onTap,
    );
  }
}
