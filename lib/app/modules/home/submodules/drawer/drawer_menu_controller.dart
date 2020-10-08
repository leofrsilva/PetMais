import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';
import 'package:petmais/app/shared/utils/colors.dart';
part 'drawer_menu_controller.g.dart';

class DrawerMenuController = _DrawerMenuControllerBase
    with _$DrawerMenuController;

abstract class _DrawerMenuControllerBase with Store {
  HomeController _homeController;
  _DrawerMenuControllerBase(this._homeController);

  AuthStore get auth => this._homeController.auth;

  UsuarioModel get usuario => this.auth.usuario;

  AnimationDrawerController get animationDrawer =>
      this._homeController.animationDrawer;

  int get opSelected => this._homeController.screen.toInt();

  setOpSelected(int value) => this._homeController.changePage(value.toDouble());

  @observable
  bool isSair = false;

  @action
  setSair(bool value) => this.isSair = value;

  //? ----------------------------------------------------------
  //? Limpar Cache
  Function functionClearCache;
  setFunctionClearCache(Function function){
    this.functionClearCache = function;
  }

  void execClearCache(){
    functionClearCache.call();
  }

  Future exitApp() async {
    this._homeController.exit().then((value) {
      this._homeController.changePage(1);
      Modular.to.showDialog(builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: Center(
            child: Container(
              color: Colors.transparent,
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(DefaultColors.primarySmooth),
              ),
            ),
          ),
        );
      });
      Future.delayed(Duration(milliseconds: 750), () {
        Modular.to.pop();
        this._homeController.setOffline();
        this.auth.setUser(UsuarioModel());
      });
    });
  }
}
