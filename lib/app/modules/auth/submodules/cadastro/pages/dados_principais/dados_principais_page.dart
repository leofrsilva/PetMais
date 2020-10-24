import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/widgets/CustomRadioButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'dados_principais_controller.dart';

class DadosPrincipaisPage extends StatefulWidget {
  @override
  _DadosPrincipaisPageState createState() => _DadosPrincipaisPageState();
}

class _DadosPrincipaisPageState
    extends ModularState<DadosPrincipaisPage, DadosPrincipaisController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
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
              // vertical: size.height * 0.10,
            ),
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.05),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Observer(builder: (_) {
                          bool isError = controller.isError;
                          return CustomTextField(
                            height: isError ? 70.0 : 40.0,
                            controller: controller.emailController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusSenha.requestFocus();
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
                        SizedBox(height: size.height * 0.03),
                        Observer(builder: (_) {
                          bool isError = controller.isError;
                          return CustomTextField(
                            height: isError ? 70.0 : 40.0,
                            controller: controller.senhaController,
                            focusNode: controller.focusSenha,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusConfSenha.requestFocus();
                            },
                            label: "Senha",
                            hint: "Entre com sua Senha",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioModel.toNumCaracteres()["senha"],
                              ),
                            ],
                            icon: Icons.lock,
                            isPass: controller.obscureText,
                            onPressedVisiblePass: controller.setObscureText,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "    [O campo é obrigatório]";
                              }
                              if (value.length < 8) {
                                return "    [Senha deve conter mais de 8 Caracteres]";
                              }
                              if (controller.verificarSenha()) {
                                return "    [A senha deve conter numero e letras]";
                              }
                              return null;
                            },
                          );
                        }),
                        SizedBox(height: size.height * 0.03),
                        Observer(builder: (_) {
                          bool isError = controller.isError;
                          return CustomTextField(
                            height: isError ? 70.0 : 40.0,
                            controller: controller.senhaConfController,
                            focusNode: controller.focusConfSenha,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).unfocus();
                            },
                            label: "Confirma Senha",
                            hint: "Entre novamente com sua Senha",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioModel.toNumCaracteres()["senha"],
                              ),
                            ],
                            icon: Icons.lock,
                            isPass: controller.obscureTextConf,
                            onPressedVisiblePass: controller.setObscureTextConf,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "    [O campo é obrigatório]";
                              }
                              if (value.length < 3 || value.length > 12) {
                                return "    [Senha Inválido]";
                              }
                              if (value != controller.senhaController.text) {
                                return "    [Senha Incorreta]";
                              }
                              return null;
                            },
                          );
                        }),
                        SizedBox(height: size.height * 0.03),
                        Observer(builder: (_) {
                          return CustomRadioButton<TypeUser>(
                            label: "Categoria do Usuário",
                            primaryTitle: "Comum",
                            secondyTitle: "Jurídica",
                            primaryValue: TypeUser.fisica,
                            secondyValue: TypeUser.juridica,
                            groupValue: controller.typeUser,
                            primaryOnChanged: controller.setTypeUser,
                            secondyOnChanged: controller.setTypeUser,
                          );
                        }),
                      ],
                    ),
                    Observer(builder: (_) {
                      bool isError = controller.isError;
                      return SizedBox(
                          height: size.height * (isError ? 0.05 : 0.04));
                    }),
                    Container(
                      height: size.height * 0.15,
                      child: Column(
                        children: <Widget>[
                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.next();
                            },
                            text: "AVANÇAR",
                            elevation: 0.0,
                            width: size.width * 0.4,
                            decoration: kDecorationContainer,
                          ),
                          SizedBox(height: size.height * 0.02),
                          GestureDetector(
                            onTap: () {
                              Modular.to.pushReplacementNamed("/auth/logincomum");
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Já tem uma Conta?",
                                    style: TextStyle(
                                      color: DefaultColors.secondarySmooth,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "RussoOne",
                                    ),
                                  ),
                                  TextSpan(
                                    text: " Login",
                                    style: TextStyle(
                                        color: DefaultColors.secondarySmooth,
                                        fontSize: 16.0,
                                        fontFamily: "RussoOne"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
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
    );
  }
}
