import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';
import 'widgets/custom_search_delegate.dart';
import '../../home_controller.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';

part 'search_user_controller.g.dart';

class SearchUserController = _SearchUserControllerBase
    with _$SearchUserController;

abstract class _SearchUserControllerBase with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;


  HomeController _homeController;
  AuthStore _authStore;
  _SearchUserControllerBase(this._authStore, this._homeController);

  HomeController get home => this._homeController;

  AnimationDrawerController get animationDrawer => this.home.animationDrawer;

  UsuarioModel resultUser;

  void showSearchUser() async {
    resultUser = await showSearch(
      context: context,
      delegate: CustomSearchDelegate(this._authStore.usuario),
    );
    this.exit();
    if(resultUser != null ){
      Future.delayed(Duration(milliseconds: 200), (){
        Modular.to.pushNamed("/home/perfilUser", arguments: resultUser);
      });
    }
    // if (resultUser != null) {
    //   User user = User.fromMapForUpdate(json.decode(resultUser));
    //   Navigator.pushNamed(context, "/perfilUser",
    //       arguments: [_userChat, user]).whenComplete(() {
    //     model.close(index: 3);
    //   });
    // }
    
  }

  void exit(){
    this._homeController.changePage(1);
  }
}
