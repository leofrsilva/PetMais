import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/repository/usuario_persistence_local/usuario_persistence_local_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import 'submodules/adocao/adocao_module.dart';
import 'submodules/meus_pets/meus_pets_module.dart';
import 'submodules/perfil/perfil_module.dart';
import 'submodules/pet_shop/pet_shop_module.dart';
import 'submodules/search_user/search_user_module.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase extends Disposable with Store {
  final AuthStore _authStore;
  final AnimationDrawerController _animationDrawerController;
  final FirestoreChatRepository _firestoreChatRepository;

  AuthStore get auth => this._authStore;
  AnimationDrawerController get animationDrawer =>
      this._animationDrawerController;

  PageController pageController;
  _HomeControllerBase(this._authStore, this._animationDrawerController,
      this._firestoreChatRepository) {
    int initPage = 1;
    if ((this.auth.usuario.usuarioInfo is UsuarioInfoJuridicoModel)) {
      if ((this.auth.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
              .typeJuridico ==
          TypeJuridico.petshop) {
        modulesScreen = screensPetshop;
        initPage = 0;
      }
    }

    pageController = PageController(initialPage: initPage, keepPage: false);
  }

  double get maxExtentPages => this.pageController.position.maxScrollExtent;

  @observable
  double screen = 1;

  @action
  setScreen(double value) => this.screen = value;

  @action
  void changePage(double value) {
    double page;
    if (value == (modulesScreen.length - 1)) {
      page = maxExtentPages;
    } else {
      page = ((maxExtentPages / modulesScreen.length) * (value + 0.3));
    }
    pageController.jumpTo(
      page,
    );
    setScreen(value);
  }

  List<Widget> modulesScreen = <Widget>[
    RouterOutlet(module: PetShopModule()),
    RouterOutlet(module: AdocaoModule()),
    RouterOutlet(module: PerfilModule()),
    RouterOutlet(module: MeusPetsModule()),
    RouterOutlet(module: SearchUserModule())
  ];

  List<Widget> screensPetshop = <Widget>[
    RouterOutlet(module: PetShopModule()),
    RouterOutlet(module: PerfilModule()),
    RouterOutlet(module: SearchUserModule())
  ];

  //? Online
  Future setOnline() async {
    if (this._authStore.isLogged) {
      await this._firestoreChatRepository.setOnline(
            this._authStore.usuarioChat,
            true,
          );
    }
  }

  //? Offline
  Future setOffline() async {
    if (this._authStore.isLogged) {
      await this._firestoreChatRepository.setOnline(
            this._authStore.usuarioChat,
            false,
          );
    }
  }

  //? Sign In
  Future signIn() async {
    if (this._authStore.isLogged) {
      final usuarioChat = await this._firestoreChatRepository.updateInfoUser(
            this._authStore.usuario,
          );
      this._authStore.setUserChat(usuarioChat);
    }
  }

  Future exit() async {
    await UsuarioPersistenceLocalRepository.removeUserLogado()
        .then((bool result) {
      if (result == true)
        print(
            "Exclusão dos Dados da Persistencia de Usuário, feita com Sucesso!");
      else
        print(" - Error ao excluir dados da persistencia de Usuário - ");
    });
  }

  void logar() {
    _loginScreen();
  }

  void _loginScreen() =>
      Modular.to.pushNamedAndRemoveUntil(Modular.initialRoute, (_) => false);

  @override
  void dispose() {
    pageController.dispose();
  }
}
