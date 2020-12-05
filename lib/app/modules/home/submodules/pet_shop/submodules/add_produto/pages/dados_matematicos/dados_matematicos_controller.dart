import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/shared/utils/colors.dart';

import '../../add_produto_controller.dart';
part 'dados_matematicos_controller.g.dart';

class DadosMatematicosController = _DadosMatematicosControllerBase
    with _$DadosMatematicosController;

abstract class _DadosMatematicosControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  AddProdutoController _addProdutoController;
  _DadosMatematicosControllerBase(this._addProdutoController) {
    this.precoController = MoneyMaskedTextController(leftSymbol: 'R\$ ',);
    this.descontoController = MaskedTextController(
      mask: "000,00",
    );
    this.estoqueController = TextEditingController();
    this.focusPreco = FocusNode();
    this.focusDesconto = FocusNode();
  }

  AddProdutoController get addProd => this._addProdutoController;

  MoneyMaskedTextController precoController;
  MaskedTextController descontoController;
  TextEditingController estoqueController;

  FocusNode focusPreco;
  FocusNode focusDesconto;

  final formKey = GlobalKey<FormState>();

  //* Is Delivery
  @observable
  bool isDelivery = true;
  @action
  setIsDelivery(bool value) => this.isDelivery = value;

  // Is Error
  @observable
  bool isError = false;
  @action
  setError(bool value) => this.isError = value;

  Future cadatrar(){
    if(this.formKey.currentState.validate()){
      setError(false);
      //* Converte o valor de Desconto
      double desconto = double.tryParse(this.descontoController.text.replaceAll(",", "."));
      print(desconto);
    }
    else{
      setError(true);
    }
  }

  showLoading() {
    Modular.to.showDialog(builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(DefaultColors.secondary),
              ),
              SizedBox(height: 15.0),
              Text(
                "Carregando ...",
                style: TextStyle(
                  color: DefaultColors.secondary,
                  fontFamily: "Changa",
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  hideLoading() {
    Modular.to.pop();
  }

  @override
  void dispose() {
    this.precoController.dispose();
    this.descontoController.dispose();
    this.focusPreco.dispose();
    this.focusDesconto.dispose();
  }
}
