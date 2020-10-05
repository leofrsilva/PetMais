import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';
import 'update_user_controller.dart';

class UpdateUserPage extends StatefulWidget {
  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState
    extends ModularState<UpdateUserPage, UpdateUserController> {
  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextField(
                            height: error ? 70.0 : 40.0,
                            controller: controller.nomeController,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).unfocus();
                            },
                            label: "Nome",
                            hint: "Digite seu Nome",
                            contentPadding: const EdgeInsets.only(left: 15.0),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioInfoModel.toNumCaracteres()["nome"],
                              )
                            ],
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "  [Campo Obrigatório]";
                              }
                              if (value.length < 3) {
                                return "  [O Nome deve conter mais de 2 caracteres]";
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextField(
                            height: error ? 70.0 : 40.0,
                            controller: controller.sobrenomeController,
                            focusNode: controller.focusSobrenome,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              controller.focusSobrenome.unfocus();
                            },
                            label: "Sobrenome",
                            hint: "Digite seu Sobrenome",
                            contentPadding: const EdgeInsets.only(left: 15.0),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioInfoModel.toNumCaracteres()["sobrenome"],
                              )
                            ],
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "  [Campo Obrigatório]";
                              }
                              if (value.length < 3) {
                                return "  [O Nome deve conter mais de 2 caracteres]";
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextField(
                            height: error ? 70.0 : 40.0,
                            controller: controller.emailController,
                            focusNode: controller.focusEmail,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              controller.focusEmail.unfocus();
                            },
                            label: "Email",
                            hint: "Entre com seu Email",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioModel.toNumCaracteres()["email"],
                              ),
                            ],
                            icon: Icons.email,
                            textInputType: TextInputType.emailAddress,
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
                              if (controller.isEmailValid == false) {
                                return "    [Email já Existente]";
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextFieldIcon(
                            height: error ? 70.0 : 40.0,
                            controller: controller.dataController,
                            focusNode: controller.focusData,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              controller.focusData.unfocus();
                            },
                            label: "Data de Nascimento",
                            hint: "00/00/0000",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            widgetIcon: Icon(
                              FontAwesomeIcons.calendar,
                              color: Colors.black26,
                            ),
                            onPressedIcon: () {
                              controller.selectData(context);
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "  [Campo Obrigatório]";
                              }
                              if (value.length < 9) {
                                return "  [Data Incompleta]";
                              }
                              if (controller.isValidData(value) == false) {
                                return "  [Data Inválida]";
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextField(
                            height: error ? 70.0 : 40.0,
                            controller: controller.phoneController,
                            focusNode: controller.focusTelefone,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).unfocus();
                            },
                            label: "Telefone",
                            hint: "(00) 90000-0000",
                            icon: Icons.phone,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "    [O campo é obrigatório]";
                              }
                              if (value.length < 15) {
                                return "    [Número de telefone Incompleto]";
                              }
                              return null;
                            },
                          );
                        }),
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
