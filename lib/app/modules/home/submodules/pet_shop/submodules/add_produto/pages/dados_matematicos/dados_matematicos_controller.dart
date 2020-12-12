import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/utils/colors.dart';

import '../../add_produto_controller.dart';

part 'dados_matematicos_controller.g.dart';

@Injectable()
class DadosMatematicosController = _DadosMatematicosControllerBase
    with _$DadosMatematicosController;

abstract class _DadosMatematicosControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  AddProdutoController _addProdutoController;
  _DadosMatematicosControllerBase(this._addProdutoController) {
    this.freteController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
    );
    this.precoController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
    );
    this.descontoController = MoneyMaskedTextController(
      rightSymbol: ' %',
    );
    this.focusDesconto = FocusNode();
    this.focusFrete = FocusNode();
    this.setQuantidade(1);
  }

  AddProdutoController get addProd => this._addProdutoController;

  MoneyMaskedTextController precoController;
  MoneyMaskedTextController freteController;
  MoneyMaskedTextController descontoController;

  FocusNode focusDesconto;
  FocusNode focusFrete;

  final formKey = GlobalKey<FormState>();

  //* Quantidade
  @observable
  double quant = 0;
  @action
  setQuantidade(double value) => this.quant = value;

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

  Future cadatrar() async {
    if (this.formKey.currentState.validate()) {
      setError(false);
      //* Converte o valor de Desconto
      double desconto = double.tryParse(this
          .descontoController
          .text
          .replaceAll(",", ".")
          .trim()
          .toString()
          .replaceAll("%", ""));
      double preco = double.tryParse(this
          .precoController
          .text
          .replaceAll(",", ".")
          .trim()
          .toString()
          .replaceAll("R\$", ""));
      double frete = double.tryParse(this
          .freteController
          .text
          .replaceAll(",", ".")
          .trim()
          .toString()
          .replaceAll("R\$", ""));
      int quantidade = this.quant.toInt();
      int delivery = this.isDelivery ? 1 : 0;
      this.addProd.setDadosMatematicos(
            preco: preco,
            desconto: desconto,
            estoque: quantidade,
            valKm: frete,
            delivery: delivery,
          );
      //* Show Loading
      this.showLoading();
      await this
          .addProd
          .registrerProd(this.addProd.produto, false)
          .then((String result) {
        //* Hide Loading
        this.hideLoading();
        if (result == "Falha no Envio" || result == "Not Send") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro ao Enviar Imagem!",
          )..show(this.context);
        } else if (result == "Registered") {
          //? Retorna para lista de Produtos
          Modular.to.pop();
        } else if (result == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else {
          //? Dados do Cadastro Incorreto
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1750),
            title: "Cadastro",
            message: "Algum dado está Incorreto!",
          )..show(this.context);
        }
      });
    } else {
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
    this.freteController.dispose();
    this.precoController.dispose();
    this.descontoController.dispose();
    this.focusDesconto.dispose();
    this.focusFrete.dispose();
  }
}
