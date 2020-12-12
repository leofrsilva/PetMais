import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:spinner_input/spinner_input.dart';
import 'dados_matematicos_controller.dart';

class DadosMatematicosPage extends StatefulWidget {
  final String title;
  const DadosMatematicosPage({Key key, this.title = "DadosMatematicos"})
      : super(key: key);

  @override
  _DadosMatematicosPageState createState() => _DadosMatematicosPageState();
}

class _DadosMatematicosPageState
    extends ModularState<DadosMatematicosPage, DadosMatematicosController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.setContext(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: size.height * 0.75,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Observer(builder: (_) {
                          bool isError = controller.isError;
                          return CustomTextField(
                            height: isError
                                ? size.height * 0.075
                                : size.height * 0.055,
                            isDense: true,
                            colorLabel: DefaultColors.backgroundSmooth,
                            colorText: DefaultColors.background,
                            contentPadding: const EdgeInsets.all(0),
                            controller: controller.precoController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusDesconto.requestFocus();
                            },
                            label: "Preço",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                ProdutoModel.toNumCaracteres()["price"],
                              ),
                            ],
                            textInputType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "[O campo é obrigatório]";
                              }
                              if (double.tryParse(value
                                      .replaceAll(",", ".")
                                      .trim()
                                      .toString()
                                      .replaceAll("R\$", "")) ==
                                  0.0) {
                                return "[O valor do produto deve ser maior que R\$ 0,00]";
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Observer(builder: (_) {
                          bool isError = controller.isError;
                          return CustomTextField(
                            height: isError
                                ? size.height * 0.075
                                : size.height * 0.055,
                            isDense: true,
                            colorLabel: DefaultColors.backgroundSmooth,
                            colorText: DefaultColors.background,
                            contentPadding: const EdgeInsets.all(0),
                            controller: controller.descontoController,
                            focusNode: controller.focusDesconto,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              controller.focusDesconto.unfocus();
                            },
                            label: "Desconto",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                ProdutoModel.toNumCaracteres()["desconto"],
                              ),
                            ],
                            textInputType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "[O campo é obrigatório]";
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.addProd.produto.categoria == "Rações"
                                  ? "Quantidade: (KG)"
                                  : "Quantidade:",
                              style: TextStyle(
                                color: DefaultColors.backgroundSmooth,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: size.width * 0.075),
                            Observer(builder: (_) {
                              return SpinnerInput(
                                disabledPopup: true,
                                spinnerValue: controller.quant,
                                minValue: 1,
                                maxValue: 100000,
                                middleNumberWidth: size.width * 0.15,
                                middleNumberStyle: TextStyle(
                                  fontFamily: "Changa",
                                  color: DefaultColors.background,
                                  fontSize: size.height * 0.035,
                                ),
                                minusButton: SpinnerButtonStyle(
                                  color: DefaultColors.tertiary,
                                  textColor: Colors.black26,
                                ),
                                plusButton: SpinnerButtonStyle(
                                  color: DefaultColors.backgroundSmooth,
                                  textColor: Colors.black26,
                                ),
                                onChange: controller.setQuantidade,
                              );
                            }),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Observer(builder: (_) {
                          return CustomCheckBox(
                            color: DefaultColors.background,
                            text: "Produto disponível para Entrega",
                            value: controller.isDelivery,
                            onChanged: controller.setIsDelivery,
                            onTap: () {
                              controller.setIsDelivery(!controller.isDelivery);
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Observer(builder: (_) {
                          if (!controller.isDelivery) {
                            return Container();
                          }
                          return CustomTextField(
                            height: size.height * 0.055,
                            isDense: true,
                            colorLabel: DefaultColors.backgroundSmooth,
                            colorText: DefaultColors.background,
                            contentPadding: const EdgeInsets.all(0),
                            controller: controller.freteController,
                            focusNode: controller.focusFrete,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              controller.focusDesconto.unfocus();
                            },
                            label: "Valor do Frete",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                ProdutoModel.toNumCaracteres()["valoKm"],
                              ),
                            ],
                            textInputType: TextInputType.number,                            
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: size.height * 0.0125),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonOutline(
                      text: " < ",
                      corText: DefaultColors.backgroundSmooth,
                      height: size.height * 0.075,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: DefaultColors.backgroundSmooth,
                          width: 2,
                        ),
                      ),
                      onPressed: controller.addProd.prevPage,
                    ),
                    CustomButtonOutline(
                      text: "Cadastrar",
                      corText: DefaultColors.backgroundSmooth,
                      height: size.height * 0.075,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: DefaultColors.backgroundSmooth,
                          width: 2,
                        ),
                      ),
                      onPressed: controller.cadatrar,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
