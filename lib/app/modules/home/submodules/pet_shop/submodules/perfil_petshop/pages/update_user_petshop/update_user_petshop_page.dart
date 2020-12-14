import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';
import 'update_user_petshop_controller.dart';

class UpadateUserPetshopPage extends StatefulWidget {
  @override
  _UpadateUserPetshopPageState createState() =>
      _UpadateUserPetshopPageState();
}

class _UpadateUserPetshopPageState extends ModularState<
    UpadateUserPetshopPage, UpdateUserPetshopController> {
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

    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: size.height * 0.9,
          width: size.width * 0.9,
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                offset: Offset(10.0, 10.0),
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Form(
            key: controller.formKey,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.75,
                        child: ScrollConfiguration(
                          behavior: NoGlowBehavior(),
                          child: SingleChildScrollView(
                            controller: this.scrollController,
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: size.height * 0.03),
                                    CustomTextFieldIcon(
                                      enabled: false,
                                      height: size.height * 0.055,
                                      controller: controller.cnpjController,
                                      textInputType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      label: "CNPJ",
                                      hint: "00.000.000/0000-00",
                                      contentPadding: EdgeInsets.zero,
                                      widgetIcon: Icon(
                                        FontAwesomeIcons.search,
                                        color: Colors.black26,
                                      ),
                                      onPressedIcon: controller.findCNPJ,
                                    ),
                                    SizedBox(height: size.height * 0.03),
                                    Observer(builder: (_) {
                                      bool error = controller.isError;
                                      return CustomTextField(
                                        height: error
                                            ? size.height * 0.095
                                            : size.height * 0.055,
                                        controller: controller.emailController,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (String value) {
                                          controller.focusNomeOrg.unfocus();
                                        },
                                        label: "Email",
                                        hint: "Entre com seu Email",
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                            UsuarioModel.toNumCaracteres()[
                                                "email"],
                                          ),
                                        ],
                                        icon: Icons.email,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "    [O campo é obrigatório]";
                                          }
                                          if (value.contains("@") == false ||
                                              value.length < 4) {
                                            return "    [Email Inválido]";
                                          }
                                          if (controller.isEmailValid == null) {
                                            return "    [Error na Verificação do Email]";
                                          }
                                          if (controller.isEmailValid ==
                                              false) {
                                            return "    [Email já Existente]";
                                          }
                                          return null;
                                        },
                                      );
                                    }),
                                    SizedBox(height: size.height * 0.03),
                                    Observer(
                                      builder: (BuildContext context) {
                                        bool isError = controller.isError;
                                        return CustomTextField(
                                          height: isError
                                              ? size.height * 0.095
                                              : size.height * 0.055,
                                          controller:
                                              controller.nomeOrgController,
                                          focusNode: controller.focusNomeOrg,
                                          textInputType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (String value) {
                                            controller.focusTel1.requestFocus();
                                          },
                                          label: "Nome da Organização",
                                          hint: "Digete o nome ...",
                                          contentPadding: EdgeInsets.zero,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                              UsuarioInfoJuridicoModel
                                                      .toNumCaracteres()[
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
                                              controller:
                                                  controller.tel1Controller,
                                              focusNode: controller.focusTel1,
                                              textInputType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (String value) {
                                                controller.focusTel2
                                                    .requestFocus();
                                              },
                                              label: "Telefone",
                                              hint: "(00) 90000-0000",
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  UsuarioInfoJuridicoModel
                                                          .toNumCaracteres()[
                                                      COLUMN_TELEFONE1],
                                                ),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 0.0),
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
                                            controller:
                                                controller.tel2Controller,
                                            focusNode: controller.focusTel2,
                                            textInputType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (String value) {
                                              controller.isLoading = true;
                                              controller
                                                  .expansionTile.currentState
                                                  .expand();
                                              controller.focusCep
                                                  .requestFocus();
                                              controller.isLoading = false;
                                            },
                                            label: "Telefone 2",
                                            hint: "(00) 90000-0000",
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                UsuarioInfoJuridicoModel
                                                        .toNumCaracteres()[
                                                    COLUMN_TELEFONE2],
                                              ),
                                            ],
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 0.0),
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
                                        unselectedWidgetColor:
                                            DefaultColors.secondarySmooth,
                                        canvasColor: Colors.transparent,
                                      ),
                                      child: ExpansionTileCard(
                                        key: controller.expansionTile,
                                        onExpansionChanged: (bool isExpansion) {
                                          if (controller.isLoading) {
                                            return;
                                          }
                                          if (isExpansion) {
                                            Future.delayed(
                                                Duration(milliseconds: 200),
                                                () {
                                              // double positionMax = this.scrollController.position.maxScrollExtent;
                                              // double positionNow = this.scrollController.position.pixels;
                                              double desl = 0;
                                              desl = (size.height * 0.63);
                                              if (controller.isError) {
                                                desl = (size.height * 0.83);
                                              }
                                              this.scrollController.animateTo(
                                                    desl,
                                                    duration: Duration(
                                                        milliseconds: 150),
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
                                            color:
                                                DefaultColors.secondarySmooth,
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
                                              controller:
                                                  controller.cepController,
                                              focusNode: controller.focusCep,
                                              textInputType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (String value) {
                                                controller.focusRua
                                                    .requestFocus();
                                              },
                                              label: "CEP",
                                              hint: "00000-000",
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  DadosEnderecoModel
                                                      .toNumCaracteres()["cep"],
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
                                              controller:
                                                  controller.ruaController,
                                              focusNode: controller.focusRua,
                                              textInputType: TextInputType.text,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (String value) {
                                                controller.focusNumero
                                                    .requestFocus();
                                              },
                                              label: "Endereço",
                                              hint: " - ",
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  DadosEnderecoModel
                                                      .toNumCaracteres()["rua"],
                                                ),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
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
                                                  bool isError =
                                                      controller.isError;
                                                  return CustomTextField(
                                                    height: isError
                                                        ? size.height * 0.095
                                                        : size.height * 0.055,
                                                    controller: controller
                                                        .numeroController,
                                                    focusNode:
                                                        controller.focusNumero,
                                                    textInputType:
                                                        TextInputType.number,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onFieldSubmitted:
                                                        (String value) {
                                                      controller.focusComp
                                                          .requestFocus();
                                                    },
                                                    label: "Número",
                                                    hint: "",
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                        DadosEnderecoModel
                                                                .toNumCaracteres()[
                                                            "numero"],
                                                      ),
                                                    ],
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
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
                                                  controller:
                                                      controller.compController,
                                                  focusNode:
                                                      controller.focusComp,
                                                  textInputType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  onFieldSubmitted:
                                                      (String value) {
                                                    controller.focusBairro
                                                        .requestFocus();
                                                  },
                                                  label: "Complemento",
                                                  hint: "",
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                      DadosEnderecoModel
                                                              .toNumCaracteres()[
                                                          "complemento"],
                                                    ),
                                                  ],
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
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
                                              controller:
                                                  controller.bairroController,
                                              focusNode: controller.focusBairro,
                                              textInputType: TextInputType.text,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (String value) {
                                                controller.focusCidade
                                                    .requestFocus();
                                              },
                                              label: "Bairro",
                                              hint: " - ",
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  DadosEnderecoModel
                                                          .toNumCaracteres()[
                                                      "bairro"],
                                                ),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
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
                                                child: Observer(
                                                    builder: (context) {
                                                  bool isError =
                                                      controller.isError;
                                                  return CustomTextField(
                                                    height: isError
                                                        ? size.height * 0.095
                                                        : size.height * 0.055,
                                                    controller: controller
                                                        .cidadeController,
                                                    focusNode:
                                                        controller.focusCidade,
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    textInputType:
                                                        TextInputType.number,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onFieldSubmitted:
                                                        (String value) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    label: "Cidade",
                                                    hint: " - ",
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                        DadosEnderecoModel
                                                                .toNumCaracteres()[
                                                            "cidade"],
                                                      ),
                                                    ],
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
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
                                                    color:
                                                        DefaultColors.secondary,
                                                    fontFamily: "Changa",
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.045),
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              child: Text(
                                "Cancelar",
                                style: kFlatButtonStyle,
                              ),
                              onPressed: controller.exit,
                            ),
                            FlatButton(
                              child: Text(
                                "Atualizar",
                                style: kFlatButtonStyle,
                              ),
                              onPressed: controller.atualizar,
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
        ),
      ),
    );
  }
}
