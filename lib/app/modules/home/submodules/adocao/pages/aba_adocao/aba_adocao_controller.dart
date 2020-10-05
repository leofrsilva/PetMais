import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';

import '../../adocao_controller.dart';
part 'aba_adocao_controller.g.dart';

class AbaAdocaoController = _AbaAdocaoControllerBase with _$AbaAdocaoController;

abstract class _AbaAdocaoControllerBase extends Disposable with Store {
  final AdocaoController _adocaoController;
  _AbaAdocaoControllerBase(this._adocaoController){
    racaController = TextEditingController();
  }

  AnimationDrawerController get animationDrawer => this._adocaoController.animationDrawer;

  AdocaoController get adocao => this._adocaoController;

  TextEditingController racaController;

  @observable
  String especie;

  @action
  setEspecie(String value) => this.especie = value;

  @observable
  bool isSearch = false;

  @action
  setShowSearch() => this.isSearch = true;

  @action
  setCloseSearch() => this.isSearch = false;

  void search() {
    recuperarAdocoes();
  }

  @action
  Future<List<PostAdocaoModel>> recuperarAdocoes() async {
    return await this._adocaoController.listAllAdocoes(this.especie, racaController.text.trim());
  }

  @override
  void dispose() {
    racaController.dispose();
  }
}