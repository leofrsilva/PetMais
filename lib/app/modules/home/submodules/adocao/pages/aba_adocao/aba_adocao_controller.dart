import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

import '../../adocao_controller.dart';
part 'aba_adocao_controller.g.dart';

class AbaAdocaoController = _AbaAdocaoControllerBase with _$AbaAdocaoController;

abstract class _AbaAdocaoControllerBase extends Disposable with Store {
  // Função para atualizar a lista de adoções
  Function _updateListAdption;
  set updateListAdption(Function value) => this._updateListAdption = value;
  Function get updateListAdption => this._updateListAdption;

  final AdocaoController _adocaoController;
  _AbaAdocaoControllerBase(this._adocaoController){
    racaController = TextEditingController();
  }

  AnimationDrawerController get animationDrawer => this._adocaoController.animationDrawer;
  AdocaoController get adocao => this._adocaoController;
  UsuarioModel get usuario => this._adocaoController.auth.usuario;
  TextEditingController racaController;

  @observable
  bool isDog = false;

  @action
  setIsDog(bool value){
    this.isDog = value;
    this.updateListAdption.call();
  }

  @observable
  bool isCat = false;

  @action
  setIsCat(bool value){
    this.isCat = value;
    this.updateListAdption.call();
  }

  @observable
  bool isUpKeyBoard = false;

  @action
  setUpKeyBoard() => this.isSearch = true;
  @action
  setDownKeyBoard() => this.isSearch = false;

  @observable
  bool isSearch = false;

  @action
  setShowSearch() => this.isSearch = true;
  @action
  setCloseSearch() => this.isSearch = false;

  @observable
  bool isOnlyONG = false;

  @action
  setIsOnlyONG(bool value){
    this.isOnlyONG = value;
    this.updateListAdption.call();
  }

  void search() {
    recuperarAdocoes();
  }

  @action
  Future<List<PostAdocaoModel>> recuperarAdocoes() async {
    String especie;
    if(this.isDog == true && this.isCat == false){
      especie = "cachorro";
    }
    else if(this.isDog == false && this.isCat == true){
      especie = "gato";
    }
    return await this._adocaoController.listAllAdocoes(especie, racaController.text.trim(), this.isOnlyONG);
  }

  @override
  void dispose() {
    racaController.dispose();
  }
}