import 'dart:convert';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/usuario_persistence_local/usuario_persistence_local_repository.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  AuthStore _authStore;
  _SplashControllerBase(this._authStore);

  AuthStore get auth => this._authStore;

  Future checkUsuarioLogado() async {
    await UsuarioPersistenceLocalRepository.getUserLogado()
        .then((Map<String, String> user) async {
      if (user != null) {
        _recuperarUsuario(user);
      } else {
        _authScreen();
      }
    });
  }

  String _decryptSenha(String key, String encrypted) {
    if (key != "Falha na Conexão") {
      this.auth.cryptoAes.setkey(key);
      this.auth.cryptoAes.setEncrypted(encrypted);
      return this.auth.cryptoAes.decryptPass();
    } else {
      return key;
    }
  }

  void _recuperarUsuario(Map<String, String> user) async {
    final usuarioRepository = UsuarioRemoteRepository();

    String senha = _decryptSenha(
      await usuarioRepository.getKey(),
      user["senha"],
    );

    Map<String, dynamic> result;
    result = await usuarioRepository.loginUser(user["email"], senha, user["type"]);
    if (result["Result"] == "Found User") {
      UsuarioModel user = UsuarioModel.fromMap(json.decode(result["User"]));
      auth.setUser(user);
      _homeScreen();
    }
    else if (result["Result"] == "Falha na Conexão") {
      FlushbarHelper.createError(
        duration: Duration(milliseconds: 1775),
        title: "Error",
        message: "Falha na Conexão",
      )..show(context).then((_) {
          _authScreen();
        });
    } else if (result["Result"] == "Not Found User") {
      _authScreen();
    }
    else{
      _authScreen();
    }
  }

  void _authScreen() {
    Modular.to.pushNamedAndRemoveUntil(
      "/auth",
      (_) => false,
    );
  }

  void _homeScreen() {
    Modular.to.pushNamedAndRemoveUntil(
      "/home",
      (_) => false,
    );
  }

  // Future _saveLocalUser(String email, String senha, String key) async {
  //   this.auth.cryptoAes.setkey(key);
  //   senha = this.auth.cryptoAes.encryptPass(senha);
  //   await UsuarioPersistenceLocalRepository.setUserLogado(
  //     {
  //       "email": email,
  //       "senha": senha,
  //     },
  //   ).then((bool result) {
  //     if (result == true)
  //       print("Keep it connected");
  //     else
  //       print("Don't keep connected");
  //   });
  // }

  // void _loginScreen() {
  //   Modular.to.pushNamedAndRemoveUntil(
  //     "/login",
  //     (_) => false,
  //   );
  // }

  @observable
  bool isErrorConnection = false;

  @action
  void setIsErrorConnection(bool value) => this.isErrorConnection = value;
}
