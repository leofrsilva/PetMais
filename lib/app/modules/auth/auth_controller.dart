import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/usuario_persistence_local/usuario_persistence_local_repository.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final AuthStore _authStore;
  _AuthControllerBase(this._authStore);

  AuthStore get auth => this._authStore;

  Future<String> checkEmail(String email, {bool isLoading}) async {
    final usuarioRepository = UsuarioRemoteRepository();
    Map<String, dynamic> result;
    result = await usuarioRepository.checkEmail(email, loading: isLoading);
    return result["Result"];
  }

  Future<String> recuperarSenha(String email) async {
    final usuarioRepository = UsuarioRemoteRepository();
    Map<String, dynamic> result;
    result = await usuarioRepository.recuperarSenha(email);
    return result["Result"];
  }

  @action
  Future<String> entrar({String email, String senha, String type}) async {
    final usuarioRepository = UsuarioRemoteRepository();
    Map<String, dynamic> result;
    result = await usuarioRepository.loginUser(email, senha, type);
    if (result["Result"] == "Found User") {
      UsuarioModel user = UsuarioModel.fromMap(json.decode(result["User"]));
      auth.setUser(user);
      _saveLocalUser(user.email, senha, result["key"], type);
    }
    return result["Result"];
  }

  @action
  Future<String> cadastrar(
      UsuarioModel usuarioModel, File image, bool isLoading) async {
    final usuarioRepository = UsuarioRemoteRepository();
    if (image != null) {
      await usuarioRepository
          .uploadImagePerfil(image, isLoading)
          .then((Map<String, dynamic> result) {
        if (result["Result"] == "Falha no Envio" ||
            result["Result"] == "Not Send") {
          return result["Result"];
        } else {
          isLoading = false;
        }
      });
    }
    Map<String, dynamic> result;
    result =
        await usuarioRepository.registerUser(usuarioModel, loading: isLoading);
    if (result["Result"] == "Registered") {
      UsuarioModel user = UsuarioModel.fromMap(json.decode(result["User"]));
      auth.setUser(user);
      String type;
      if (usuarioModel.typeUser == TypeUser.fisica) {
        type = "c";
      } else {
        type = "j";
      }
      _saveLocalUser(user.email, usuarioModel.senha, result["key"], type);
    }
    return result["Result"];
  }

  _saveLocalUser(String email, String senha, String key, String type) async {
    this.auth.cryptoAes.setkey(key);
    senha = this.auth.cryptoAes.encryptPass(senha);
    await UsuarioPersistenceLocalRepository.setUserLogado(
      {
        "email": email,
        "senha": senha,
        "encrypted": this.auth.cryptoAes.getEncrypted,
        "type": type,
      },
    ).then((bool result) {
      if (result == true)
        print("Keep it connected");
      else
        print("Don't keep connected");
    });
  }

  //? Esqueci minha Senha
  
}
