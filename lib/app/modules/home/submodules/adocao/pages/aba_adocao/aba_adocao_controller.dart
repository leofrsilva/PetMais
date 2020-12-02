import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

import '../../adocao_controller.dart';
part 'aba_adocao_controller.g.dart';

class AbaAdocaoController = _AbaAdocaoControllerBase with _$AbaAdocaoController;

abstract class _AbaAdocaoControllerBase with Store {
  // Função para atualizar a lista de adoções
  Function _updateListAdption;
  set updateListAdption(Function value) => this._updateListAdption = value;
  Function get updateListAdption => this._updateListAdption;

  final AdocaoController _adocaoController;
  _AbaAdocaoControllerBase(this._adocaoController){
    this.especieSelect = "Todos";
    this.racaSelect = "";
  }

  AnimationDrawerController get animationDrawer =>
      this._adocaoController.animationDrawer;
  AdocaoController get adocao => this._adocaoController;
  UsuarioModel get usuario => this._adocaoController.auth.usuario;

  //* Espécie
  @observable
  String especieSelect;
  @action
  setEspecieSelect(String value) {
    this.especieSelect = value;
    if(value == "Cachorro"){
      this.listRaca = PetModel.listDogs();
    }
    else if(value == "Gato"){
      this.listRaca = PetModel.listCats();
    }
    else{
    this.listRaca = [];
    }
    this.updateListAdption.call();
    this.setRacaSelect(null);
  }

  List<DropdownMenuItem<String>> listEspecie = [
    DropdownMenuItem(child: Text("Todos"), value: "Todos"),
    DropdownMenuItem(child: Text("Cachorro"), value: "Cachorro"),
    DropdownMenuItem(child: Text("Gato"), value: "Gato"),
  ];

  //* Raça
  @observable
  String racaSelect;
  @action
  setRacaSelect(String value) {
    this.racaSelect = value;
    this.updateListAdption.call();
  }

  List<DropdownMenuItem<String>> listRaca = [];

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
  setIsOnlyONG(bool value) {
    this.isOnlyONG = value;
    this.updateListAdption.call();
  }

  void search() {
    recuperarAdocoes();
  }

  @action
  Future<List<PostAdocaoModel>> recuperarAdocoes() async {
    String especie;
    if (this.especieSelect == "Cachorro") {
      especie = "cachorro";
    } else if (this.especieSelect == "Gato") {
      especie = "gato";
    }
    return await this
        ._adocaoController
        .listAllAdocoes(especie, this.racaSelect, this.isOnlyONG);
  }
}
