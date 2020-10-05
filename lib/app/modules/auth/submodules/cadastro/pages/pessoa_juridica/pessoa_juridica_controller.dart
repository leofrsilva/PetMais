import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../cadastro_controller.dart';

part 'pessoa_juridica_controller.g.dart';

class PessoaJuridicaController = _PessoaJuridicaControllerBase
    with _$PessoaJuridicaController;

abstract class _PessoaJuridicaControllerBase extends Disposable with Store {
  BuildContext context;
  void setContext(BuildContext contx) => this.context = contx;

  final CadastroController cadastroController;
  _PessoaJuridicaControllerBase(this.cadastroController);

  final formKey = GlobalKey<FormState>();

  //----------------------
  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;

  //* Navegação
  void next() {
    if (formKey.currentState.validate()) {
      setError(false);
      this.cadastroController.changePage(1);
    } else {
      setError(true);
    }
  }

  void back() {
    
    this.cadastroController.changePage(0);
  }

  @override
  void dispose() {

  }
}
