import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:petmais/app/shared/widgets/CustomDropdownButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'dados_principais_controller.dart';

class DadosPrincipaisPage extends StatefulWidget {
  final String title;
  const DadosPrincipaisPage({Key key, this.title = "DadosPrincipais"})
      : super(key: key);

  @override
  _DadosPrincipaisPageState createState() => _DadosPrincipaisPageState();
}

class _DadosPrincipaisPageState
    extends ModularState<DadosPrincipaisPage, DadosPrincipaisController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _selectPhoto(size),
                      Observer(builder: (_) {
                         bool isError = controller.isError;
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: size.height * 0.0215,
                            top: isError ? size.height * 0.018 : size.height * 0.04,
                          ),
                          child: Theme(
                            data: ThemeData(
                              canvasColor: Colors.white,
                            ),
                            child: CustomDropdownButton<String>(
                              height: size.height * 0.065,
                              label: "Categoria",
                              colorLabel: DefaultColors.backgroundSmooth,

                              // hint: "Categorias",
                              items: controller.listCategoria,
                              value: controller.categoriaSelect,
                              onChanged: controller.setCategoriaSelect,
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
                            controller: controller.nomeProdController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusDescricao.requestFocus();
                            },
                            label: "Nome do Produto",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                ProdutoModel.toNumCaracteres()["nameProd"],
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
                      Observer(builder: (_) {
                        bool isError = controller.isError;
                        return Container(
                          margin: EdgeInsets.only(top: size.height * 0.02),
                          height:
                              isError ? size.height * 0.2 : size.height * 0.25,
                          width: size.width * 0.9,
                          child: CustomTextField(
                            height: isError
                                ? size.height * 0.15
                                : size.height * 0.20,
                            heightText: size.height * 0.825,
                            colorLabel: DefaultColors.backgroundSmooth,
                            colorText: DefaultColors.background,
                            controller: controller.descricaoController,
                            focusNode: controller.focusDescricao,
                            label: "Decrição",
                            hint: "  ...",
                            numLines: 5,
                            maxCaracteres: 215,
                            textCapitalization: TextCapitalization.sentences,
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
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: size.height * 0.0125),
                child: CustomButtonOutline(
                  text: "AVANÇAR",
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
                  onPressed: controller.nextPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectPhoto(Size size) {
    return Observer(builder: (_) {
      bool isError = controller.isError;
      return Container(
        height: isError ? size.height * 0.23 : size.height * 0.18,
        child: FormField<File>(
          initialValue: controller.image,
          validator: (img) {
            if (controller.image == null) {
              return "Imagem do Produto Obrigatória";
            }
            return null;
          },
          builder: (FormFieldState<File> state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Observer(builder: (_) {
                      return Container(
                        height:
                            isError ? size.height * 0.165 : size.height * 0.18,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          color:
                              DefaultColors.backgroundSmooth.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: controller.image != null
                              ? Image.file(controller.image, fit: BoxFit.cover,)
                              : Icon(
                                  FontAwesomeIcons.cube,
                                  color: Colors.white,
                                  size: 50,
                                ),
                        ),
                      );
                    }),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.capturar("camera");
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.all(size.height * 0.004),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: DefaultColors.background,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: DefaultColors.background,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          InkWell(
                            onTap: () {
                              controller.capturar("galeria");
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: EdgeInsets.all(size.height * 0.004),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: DefaultColors.background,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.photo_camera_back,
                                color: DefaultColors.background,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (state.hasError)
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "[${state.errorText}]",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      );
    });
  }
}
