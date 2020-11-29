import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/modules/auth/widgets/CustomDropdownButton.dart';
import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';
import 'pessoa_juridica_controller.dart';

class PessoaJuridicaPage extends StatefulWidget {
  final String title;
  const PessoaJuridicaPage({Key key, this.title = "DadosConta"})
      : super(key: key);

  @override
  _PessoaJuridicaPageState createState() => _PessoaJuridicaPageState();
}

class _PessoaJuridicaPageState
    extends ModularState<PessoaJuridicaPage, PessoaJuridicaController> {
  //use 'controller' variable to access controller

  bool obscureText = true;
  bool obscureTextConf = true;

  ScrollController scrollController;
  scrollTop() {
    this.scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 150),
          curve: Curves.easeIn,
        );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    controller.setScrollTop(this.scrollTop);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: controller.formKey,
        child: AspectRatio(
          aspectRatio: size.aspectRatio,
          child: Container(
            height: size.height * 0.8,
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.075,
            ),
            child: SingleChildScrollView(
              controller: this.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: size.height * 0.02),
                  _selectFoto(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(
                          right: size.width * 0.5,
                        ),
                        child: Observer(builder: (_) {
                          return Theme(
                            data: ThemeData(
                              canvasColor: Colors.white,
                            ),
                            child: CustomDropdownButton<TypeJuridico>(
                              height: size.height * 0.055,
                              label: "Função",
                              hint: "ONG",
                              value: controller.typeJuridico,
                              items: controller.listTypeJuridico,
                              onChanged: controller.setTypeJuridico,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: size.height * 0.045),
                      Observer(
                        builder: (BuildContext context) {
                          bool isError = controller.isError;
                          return CustomTextFieldIcon(
                            height: isError
                                ? size.height * 0.095
                                : size.height * 0.055,
                            controller: controller.cnpjController,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusNomeOrg.requestFocus();
                            },
                            label: "CNPJ",
                            hint: "00.000.000/0000-00",
                            contentPadding: EdgeInsets.zero,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioInfoJuridicoModel.toNumCaracteres()[
                                    COLUMN_CNPJ],
                              )
                            ],
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "  [Campo Obrigatório]";
                              }
                              if (controller.validationCNPJ == null) {
                                return "[Erro na Conexão]";
                              }
                              if (controller.validationCNPJ == false) {
                                return "[CNPJ Inválido]";
                              }
                              if (controller.isCnpjValid == null) {
                                return "[Error na Verificação do CNPJ]";
                              }
                              if (controller.isCnpjValid == false) {
                                return "[CNPJ já Cadastrado]";
                              }
                              return null;
                            },
                            widgetIcon: Icon(
                              FontAwesomeIcons.search,
                              color: Colors.black26,
                            ),
                            onPressedIcon: controller.findCNPJ,
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      Observer(
                        builder: (BuildContext context) {
                          bool isError = controller.isError;
                          return CustomTextField(
                            height: isError
                                ? size.height * 0.095
                                : size.height * 0.055,
                            controller: controller.nomeOrgController,
                            focusNode: controller.focusNomeOrg,
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusTel1.requestFocus();
                            },
                            label: "Nome da Organização",
                            hint: "Digete o nome ...",
                            contentPadding: EdgeInsets.zero,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioInfoJuridicoModel.toNumCaracteres()[
                                    COLUMN_NOMEORG],
                              )
                            ],
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "  [Campo Obrigatório]";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Observer(builder: (_) {
                              bool isError = controller.isError;
                              return CustomTextField(
                                height: isError
                                    ? size.height * 0.095
                                    : size.height * 0.055,
                                controller: controller.tel1Controller,
                                focusNode: controller.focusTel1,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  controller.focusTel2.requestFocus();
                                },
                                label: "Telefone",
                                hint: "(00) 90000-0000",
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                    UsuarioInfoJuridicoModel.toNumCaracteres()[
                                        COLUMN_TELEFONE1],
                                  ),
                                ],
                                contentPadding:
                                    const EdgeInsets.only(left: 0.0),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "[O campo é obrigatório]";
                                  }
                                  if (value.length < 13) {
                                    return "[Telefone Incompleto]";
                                  }
                                  return null;
                                },
                              );
                            }),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              height: size.height * 0.055,
                              controller: controller.tel2Controller,
                              focusNode: controller.focusTel2,
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                controller.isLoading = true;
                                controller.expansionTile.currentState.expand();
                                controller.focusCep.requestFocus();
                                controller.isLoading = false;
                              },
                              label: "Telefone 2",
                              hint: "(00) 90000-0000",
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                  UsuarioInfoJuridicoModel.toNumCaracteres()[
                                      COLUMN_TELEFONE2],
                                ),
                              ],
                              contentPadding: const EdgeInsets.only(left: 0.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.025)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.03),
                      Theme(
                        data: ThemeData(
                          accentColor: DefaultColors.secondary,
                          unselectedWidgetColor: DefaultColors.secondarySmooth,
                          canvasColor: Colors.transparent,
                        ),
                        child: ExpansionTileCard(
                          key: controller.expansionTile,
                          onExpansionChanged: (bool isExpansion) {
                            if (controller.isLoading) {
                              return;
                            }
                            if (isExpansion) {
                              Future.delayed(Duration(milliseconds: 200), () {
                                // double positionMax = this.scrollController.position.maxScrollExtent;
                                // double positionNow = this.scrollController.position.pixels;
                                double desl = 0;
                                desl = (size.height * 0.63);
                                if (controller.isError) {
                                  desl = (size.height * 0.83);
                                }
                                this.scrollController.animateTo(
                                      desl,
                                      duration: Duration(milliseconds: 150),
                                      curve: Curves.easeIn,
                                    );
                              });
                            }
                          },
                          expandedColor: Colors.transparent,
                          elevation: 0.0,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Endereço",
                            style: TextStyle(
                              color: DefaultColors.secondarySmooth,
                              fontFamily: 'RussoOne',
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          children: [
                            SizedBox(height: size.height * 0.02),
                            Observer(builder: (context) {
                              bool isError = controller.isError;
                              return CustomTextFieldIcon(
                                height: isError
                                    ? size.height * 0.095
                                    : size.height * 0.055,
                                controller: controller.cepController,
                                focusNode: controller.focusCep,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  controller.focusRua.requestFocus();
                                },
                                label: "CEP",
                                hint: "00000-000",
                                contentPadding:
                                    const EdgeInsets.only(left: 15.0),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                    DadosEnderecoModel.toNumCaracteres()["cep"],
                                  ),
                                ],
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return " [Campo Obrigatório]";
                                  }
                                  if (value.length < 9) {
                                    return " [O CEP está Incompleto]";
                                  }
                                  return null;
                                },
                                widgetIcon: Icon(
                                  FontAwesomeIcons.searchLocation,
                                  color: Colors.black26,
                                ),
                                onPressedIcon: () {
                                  controller.findCEP();
                                },
                              );
                            }),
                            SizedBox(height: size.height * 0.03),
                            Observer(builder: (context) {
                              bool isError = controller.isError;
                              return CustomTextField(
                                height: isError
                                    ? size.height * 0.095
                                    : size.height * 0.055,
                                controller: controller.ruaController,
                                focusNode: controller.focusRua,
                                textInputType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  controller.focusNumero.requestFocus();
                                },
                                label: "Endereço",
                                hint: " - ",
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                    DadosEnderecoModel.toNumCaracteres()["rua"],
                                  ),
                                ],
                                contentPadding:
                                    const EdgeInsets.only(left: 15.0),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return " [Campo Obrigatório]";
                                  }
                                  if (value.length < 4) {
                                    return " [O endereço deve conter mais de 3 caracteres]";
                                  }
                                  return null;
                                },
                              );
                            }),
                            SizedBox(height: size.height * 0.03),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Observer(builder: (_) {
                                    bool isError = controller.isError;
                                    return CustomTextField(
                                      height: isError
                                          ? size.height * 0.095
                                          : size.height * 0.055,
                                      controller: controller.numeroController,
                                      focusNode: controller.focusNumero,
                                      textInputType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (String value) {
                                        controller.focusComp.requestFocus();
                                      },
                                      label: "Número",
                                      hint: "",
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          DadosEnderecoModel.toNumCaracteres()["numero"],
                                        ),
                                      ],
                                      contentPadding:
                                          const EdgeInsets.only(left: 15.0),
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "[Obrigatório]";
                                        }
                                        return null;
                                      },
                                    );
                                  }),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 4,
                                  child: CustomTextField(
                                    height: size.height * 0.055,
                                    controller: controller.compController,
                                    focusNode: controller.focusComp,
                                    textInputType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String value) {
                                      controller.focusBairro.requestFocus();
                                    },
                                    label: "Complemento",
                                    hint: "",
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(
                                        DadosEnderecoModel.toNumCaracteres()["complemento"],
                                      ),
                                    ],
                                    contentPadding:
                                        const EdgeInsets.only(left: 15.0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.03),
                            Observer(builder: (context) {
                              bool isError = controller.isError;
                              return CustomTextField(
                                height: isError
                                    ? size.height * 0.095
                                    : size.height * 0.055,
                                controller: controller.bairroController,
                                focusNode: controller.focusBairro,
                                textInputType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {
                                  controller.focusCidade.requestFocus();
                                },
                                label: "Bairro",
                                hint: " - ",
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                    DadosEnderecoModel.toNumCaracteres()["bairro"],
                                  ),
                                ],
                                contentPadding:
                                    const EdgeInsets.only(left: 15.0),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return " [Campo Obrigatório]";
                                  }
                                  if (value.length < 4) {
                                    return " [O Bairro deve conter mais de 3 caracteres]";
                                  }
                                  return null;
                                },
                              );
                            }),
                            SizedBox(height: size.height * 0.03),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Observer(builder: (context) {
                                    bool isError = controller.isError;
                                    return CustomTextField(
                                      height: isError
                                          ? size.height * 0.095
                                          : size.height * 0.055,
                                      controller: controller.cidadeController,
                                      focusNode: controller.focusCidade,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      textInputType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (String value) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      label: "Cidade",
                                      hint: " - ",
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          DadosEnderecoModel.toNumCaracteres()["cidade"],
                                        ),
                                      ],
                                      contentPadding:
                                          const EdgeInsets.only(left: 15.0),
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return " [Campo Obrigatório]";
                                        }
                                        if (value.length < 4) {
                                          return " [A Cidade deve conter mais de 3 caracteres]";
                                        }
                                        return null;
                                      },
                                    );
                                  }),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "PE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: DefaultColors.secondary,
                                      fontFamily: "Changa",
                                      fontSize: 16,
                                    ),
                                  ),
                                  //child: Observer(builder: (_) {
                                  // return Theme(
                                  //   data: ThemeData(
                                  //     canvasColor: Colors.white,
                                  //   ),
                                  //   child: CustomDropdownButton(
                                  //     height: size.height * 0.055,
                                  //     label: "Estado",
                                  //     hint: "PE",
                                  //     value: controller.siglaEstado,
                                  //     items: controller.getUF,
                                  //     onChanged: null,
                                  //     contentPadding:
                                  //         const EdgeInsets.symmetric(
                                  //             horizontal: 15.0),
                                  //   ),
                                  // );
                                  //}),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.045),
                    height: size.height * 0.28,
                    width: size.width * 0.9,
                    child: CustomTextField(
                      height: size.height * 0.23,
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
                  ),
                  Container(
                    height: size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomButtonOutline(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            controller.back();
                          },
                          text: "VOLTAR",
                          elevation: 0.0,
                          width: size.width * 0.3,
                          height: size.height * 0.07,
                          decoration: kDecorationContainerBorder,
                        ),
                        CustomButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            controller.next();
                          },
                          text: "AVANÇAR",
                          elevation: 0.0,
                          width: size.width * 0.4,
                          height: size.height * 0.07,
                          decoration: kDecorationContainer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectFoto() {
    return FormField<File>(
        initialValue: controller.image,
        validator: (img) {
          if (controller.image == null) {
            return "Imagem da Organização Obrigatória";
          }
          return null;
        },
        builder: (FormFieldState<File> state) {
          return Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Observer(builder: (_) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 1.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor:
                              DefaultColors.primarySmooth, //Colors.black12,
                          backgroundImage: controller.image == null
                              ? null
                              : FileImage(controller.image),
                          child: controller.image != null
                              ? null
                              : Icon(
                                  FontAwesomeIcons.building,
                                  color: DefaultColors.secondarySmooth,
                                  size: 50,
                                ),
                          maxRadius: 55,
                        ),
                      );
                    }),
                    Column(
                      children: <Widget>[
                        RaisedButton.icon(
                          onPressed: () {
                            controller.capturar("camera");
                          },
                          icon: Icon(Icons.camera_alt),
                          label: Text("Câmera"),
                          elevation: 0,
                          color:
                              DefaultColors.primarySmooth, //Colors.grey[100],
                          textColor: DefaultColors.secondarySmooth,
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        RaisedButton.icon(
                          onPressed: () {
                            controller.capturar("galeria");
                          },
                          icon: Icon(Icons.photo),
                          label: Text("Galeria"),
                          elevation: 0,
                          color: DefaultColors.primarySmooth,
                          textColor: DefaultColors.secondarySmooth,
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
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
            ),
          );
        });
  }
}
