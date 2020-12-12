import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';
import 'package:petmais/app/shared/widgets/CustomDropdownButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:spinner_input/spinner_input.dart';
import 'update_produto_controller.dart';

class UpdateProdutoPage extends StatefulWidget {
  final ProdutoModel produtoModel;
  const UpdateProdutoPage({this.produtoModel});

  @override
  _UpdateProdutoPageState createState() => _UpdateProdutoPageState();
}

class _UpdateProdutoPageState
    extends ModularState<UpdateProdutoPage, UpdateProdutoController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.produtoModel = widget.produtoModel;
    controller.nomeProdController.text = widget.produtoModel.nameProd;
    controller.descricaoController.text = widget.produtoModel.descricao;
    controller.categoriaSelect = widget.produtoModel.categoria;

    controller.precoController.text =
        (widget.produtoModel.price * 10).toString();
    controller.descontoController.text =
        (widget.produtoModel.desconto * 10).toString();
    controller.setQuantidade(widget.produtoModel.estoque.toDouble());
    controller.setIsDelivery(widget.produtoModel.delivery == 1 ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: size.height * 0.065,
            margin: EdgeInsets.only(bottom: size.height * 0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close,
                        color: DefaultColors.tertiary, size: 28),
                    onPressed: () {
                      if (controller.compressedImage != null) {
                        Modular.to.pop(2);
                      } else {
                        Modular.to.pop(0);
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent, size: 25),
                    onPressed: controller.delete,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: size.height * 0.265,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  //* Imagem do Produto
                                  Observer(builder: (_) {
                                    bool isError = controller.isError;
                                    return Container(
                                      height: isError
                                          ? size.height * 0.165
                                          : size.height * 0.18,
                                      width: size.height * 0.18,
                                      margin:
                                          EdgeInsets.all(size.height * 0.01),
                                      decoration: BoxDecoration(
                                        color: DefaultColors.backgroundSmooth
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: controller.image != null
                                            ? Image.file(
                                                controller.image,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                widget.produtoModel.imgProd,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    );
                                  }),

                                  //* Atulizar Imagem
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.capturar("camera");
                                        },
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              size.height * 0.0055),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: DefaultColors.background,
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: DefaultColors.background,
                                            size: size.height * 0.030,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      InkWell(
                                        onTap: () {
                                          controller.capturar("galeria");
                                        },
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              size.height * 0.0055),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: DefaultColors.background,
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.photo_camera_back,
                                            color: DefaultColors.background,
                                            size: size.height * 0.0315,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Observer(builder: (_) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          bottom: size.height * 0.015,
                                          left: size.height * 0.025,
                                          right: size.width * 0.025,
                                        ),
                                        child: Theme(
                                          data: ThemeData(
                                            canvasColor: Colors.white,
                                          ),
                                          child: CustomDropdownButton<String>(
                                            height: size.height * 0.065,
                                            label: "Categoria",
                                            colorLabel:
                                                DefaultColors.backgroundSmooth,

                                            // hint: "Categorias",
                                            items: controller.listCategoria,
                                            value: controller.categoriaSelect,
                                            onChanged:
                                                controller.setCategoriaSelect,
                                            isDense: true,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return "[O campo é obrigatório]";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.015,
                                        horizontal: size.width * 0.05,
                                      ),
                                      child: Observer(builder: (_) {
                                        bool isError = controller.isError;
                                        return CustomTextField(
                                          height: isError
                                              ? size.height * 0.075
                                              : size.height * 0.055,
                                          isDense: true,
                                          colorLabel:
                                              DefaultColors.backgroundSmooth,
                                          colorText: DefaultColors.background,
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          controller:
                                              controller.nomeProdController,
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (String value) {
                                            FocusScope.of(context).unfocus();
                                          },
                                          label: "Nome do Produto",
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                              ProdutoModel.toNumCaracteres()[
                                                  "nameProd"],
                                            ),
                                          ],
                                          textInputType: TextInputType.text,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "[O campo é obrigatório]";
                                            }
                                            if (value.length < 3) {
                                              return "[O nome do produto deve conter mais de 2 caracteres]";
                                            }
                                            return null;
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //* Descrição
                        Container(
                          height: size.height * 0.20,
                          child: Column(
                            children: [
                              Observer(builder: (_) {
                                bool isError = controller.isError;
                                return Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.015),
                                  height: isError
                                      ? size.height * 0.16
                                      : size.height * 0.18,
                                  width: size.width * 0.9,
                                  child: CustomTextField(
                                    height: isError
                                        ? size.height * 0.12
                                        : size.height * 0.14,
                                    heightText: size.height * 0.825,
                                    colorLabel: DefaultColors.backgroundSmooth,
                                    colorText: DefaultColors.background,
                                    controller: controller.descricaoController,
                                    focusNode: controller.focusDescricao,
                                    label: "Decrição",
                                    hint: "  ...",
                                    numLines: 5,
                                    maxCaracteres: 215,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (String value) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "  [Campo Obrigatório]";
                                      }
                                      if (value.length < 5) {
                                        return "  [Descrição deve conter mais de 5 caracteres]";
                                      }
                                      return null;
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        //* Preço e Desconto
                        Container(
                          padding: EdgeInsets.only(top: size.height * 0.0025),
                          height: size.height * 0.24,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height * 0.125,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.05,
                                        ),
                                        child: Observer(builder: (_) {
                                          bool isError = controller.isError;
                                          return CustomTextField(
                                            height: isError
                                                ? size.height * 0.075
                                                : size.height * 0.055,
                                            isDense: true,
                                            colorLabel:
                                                DefaultColors.backgroundSmooth,
                                            colorText: DefaultColors.background,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            controller:
                                                controller.precoController,
                                            focusNode: controller.focusPreco,
                                            textInputAction:
                                                TextInputAction.done,
                                            onFieldSubmitted: (String value) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            label: "Preço",
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                ProdutoModel.toNumCaracteres()[
                                                    "price"],
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
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05),
                                        child: Observer(builder: (_) {
                                          bool isError = controller.isError;
                                          return CustomTextField(
                                            height: isError
                                                ? size.height * 0.075
                                                : size.height * 0.055,
                                            isDense: true,
                                            colorLabel:
                                                DefaultColors.backgroundSmooth,
                                            colorText: DefaultColors.background,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            controller:
                                                controller.descontoController,
                                            focusNode: controller.focusDesconto,
                                            textInputAction:
                                                TextInputAction.done,
                                            onFieldSubmitted: (String value) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            label: "Desconto",
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                ProdutoModel.toNumCaracteres()[
                                                    "desconto"],
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
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.01,
                                  horizontal: size.width * 0.05,
                                ),
                                child: Observer(builder: (_) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.categoriaSelect == "Rações"
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
                                      SpinnerInput(
                                        disabledPopup: true,
                                        spinnerValue: controller.quant,
                                        minValue: 1,
                                        maxValue: 100000,
                                        middleNumberWidth: size.width * 0.175,
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
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01),
                          child: Observer(builder: (_) {
                            return CustomCheckBox(
                              color: DefaultColors.background,
                              text: "Produto disponível para Entrega",
                              value: controller.isDelivery,
                              onChanged: controller.setIsDelivery,
                              onTap: () {
                                controller
                                    .setIsDelivery(!controller.isDelivery);
                              },
                            );
                          }),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: size.height * 0.0125),
                          child: CustomButtonOutline(
                            text: "SALVAR",
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
                            onPressed: controller.salvar,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
