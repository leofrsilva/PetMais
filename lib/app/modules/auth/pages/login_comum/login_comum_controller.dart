import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';

import '../../auth_controller.dart';
part 'login_comum_controller.g.dart';

class LoginComumController = _LoginComumControllerBase with _$LoginComumController;

abstract class _LoginComumControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final AuthController authController;
  TextEditingController emailController;
  TextEditingController senhaController;
  FocusNode focusEmail;
  FocusNode focusSenha;
  _LoginComumControllerBase(this.authController) {
    this.emailController = TextEditingController();
    this.senhaController = TextEditingController();
    this.focusEmail = FocusNode();
    this.focusEmail.addListener(() {
      if (focusEmail.canRequestFocus)
        setIsVisibleBackground(!this.isVisibleBackground);
    });
    this.focusSenha = FocusNode();
    this.focusSenha.addListener(() {
      if (focusSenha.canRequestFocus)
        setIsVisibleBackground(!this.isVisibleBackground);
    });
  }

  TextEditingController emailAuxController = TextEditingController();
  FocusNode focusEmailAux = FocusNode();

  final formKey = GlobalKey<FormState>();

  //* Visible Background
  @observable
  bool isVisibleBackground = true;
  @action
  setIsVisibleBackground(bool value) => this.isVisibleBackground = value;

  //* Is Password
  @observable
  bool obscureText = true;
  @action
  setObscureText(bool value) => this.obscureText = value;

  //* TextField Error
  @observable
  bool isError = false;
  @action
  setError(bool value) => this.isError = value;

  //* Loading
  @observable
  bool isLoading = false;
  @action
  setLoading(bool value) => this.isLoading = value;

  //? ---------------------------------------------------------
  //? Escqueci a Senha
  Future esqueciMinhaSenha() async {
    var formCheckEmail = GlobalKey<FormState>();
    await showDialog<bool>(
      context: this.context,
      builder: (context) {
        bool notFoundEmail = false;
        bool erro = false;
        return StatefulBuilder(builder: (context, setState) {
          return GestureDetector(
            onTap: () {
              this.focusEmailAux.unfocus();
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text(
                "Recuperar Senha",
                style: TextStyle(
                  fontFamily: "Changa",
                  fontSize: 26,
                  color: DefaultColors.secondarySmooth,
                ),
              ),
              content: Form(
                key: formCheckEmail,
                child: CustomTextField(
                  height: erro ? 70.0 : 40.0,
                  controller: this.emailAuxController,
                  focusNode: this.focusEmailAux,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (String value) {
                    focusEmailAux.unfocus();
                  },
                  label: "Email",
                  hint: "Entre com seu Email",
                  icon: Icons.email,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      UsuarioModel.toNumCaracteres()["email"],
                    ),
                  ],
                  textInputType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "    [O campo é obrigatório]";
                    }
                    if (value.contains("@") == false || value.length < 4) {
                      return "    [Email Inválido]";
                    }
                    if (notFoundEmail) {
                      return "    [Email não identificado]";
                    }
                    return null;
                  },
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "CANCELAR",
                    style: kFlatButtonStyle,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text(
                    "ENVIAR",
                    style: kFlatButtonStyle,
                  ),
                  onPressed: () async {
                    setState(() {
                      notFoundEmail = false;
                      erro = false;
                    });
                    if (formCheckEmail.currentState.validate()) {
                      setState(() => erro = false);
                      this.focusEmailAux.unfocus();
                      String email = this.emailAuxController.text.trim();
                      //* Start Loading
                      this.showLoading();
                      await authController
                          .checkEmail(email, isLoading: false)
                          .then((String result) async {
                        if (result == "Falha na Conexão") {
                          //* Stop Loading
                          Modular.to.pop();
                          //? Mensagem de Erro
                          FlushbarHelper.createError(
                            duration: Duration(milliseconds: 1750),
                            message: "Erro na Conexão!",
                          )..show(this.context);
                        } else if (result == "Found") {
                          setState(() => notFoundEmail = false);
                          print("Encontrado");
                          //* Enviar Solicitação para recuperação da senha
                          await authController
                              .recuperarSenha(email)
                              .then((String result) {
                            //* Stop Loading
                            Modular.to.pop();
                            if (result == "Falha na Conexão") {
                              //? Mensagem de Erro
                              FlushbarHelper.createError(
                                duration: Duration(milliseconds: 1750),
                                message: "Erro na Conexão!",
                              )..show(this.context);
                            } else if (result == "Not Send") {
                              //? Falha no Envio
                              FlushbarHelper.createError(
                                duration: Duration(milliseconds: 1750),
                                message:
                                    "Não foi possivel enviar a solicitação!",
                              )..show(this.context);
                            } else if (result == "Send") {
                              Navigator.of(context).pop(true);
                            }
                          });
                        } else {
                          //* Stop Loading
                          Modular.to.pop();
                          setState(() {
                            notFoundEmail = true;
                            erro = true;
                          });
                          formCheckEmail.currentState.validate();
                          await this._desejaSeCadastrar();
                        }
                      });
                    } else {
                      setState(() => erro = true);
                    }
                  },
                ),
              ],
            ),
          );
        });
      },
    ).then((bool result) {
      emailAuxController.clear();
      if (result == true) {
        FlushbarHelper.createSuccess(
            message: "Solicitação Enviada para seu Email")
          ..show(this.context);
      }
    });
  }

  //? ---------------------------------------------------------
  //? Entrar
  @action
  Future logar() async {
    if (formKey.currentState.validate()) {
      this.setError(false);
      this.setLoading(true);

      // String typeUser = this.onUsuarioJuridico ? "j" : "c";
      await authController
          .entrar(
        email: this.emailController.text.trim().toLowerCase(),
        senha: this.senhaController.text.trim(),
        type: TypeUser.fisica,
      )
          .then((String result) {
        this.setLoading(false);
        if (result == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1750),
            message: "Erro na Conexão!",
          )..show(this.context);
        }
        if (result == "Found User") {
          //? Direcionar para tela Princiapl
          _signMainScreen();
        } else if (result == "Not Found User") {
          //? Dados do Login Incorreto
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1750),
            title: "Autenticação",
            message: "Email ou Senha Incorreta!",
          )..show(this.context);
        }
      });
    } else {
      this.setError(true);
      this.setLoading(false);
    }
  }

  _signMainScreen() async {
    Modular.to.pushNamedAndRemoveUntil("/home", (_) => false);
  }

  _desejaSeCadastrar() async {
    bool isCadastrar = await Modular.to.showDialog(
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Não existe conta para esse E-mail, deseja criar uma conta com esse email?",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Changa",
                    color: DefaultColors.secondary,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Não",
                  style: kFlatButtonStyle,
                ),
                onPressed: () {
                  Modular.to.pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  "Sim",
                  style: kFlatButtonStyle,
                ),
                onPressed: () {
                  Modular.to.pop(true);
                },
              ),
            ],
          );
        });
      },
    );
    if (isCadastrar) Modular.to.pushReplacementNamed("/auth/cadastro");
  }

  void showLoading() {
    Modular.to.showDialog(
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Center(
              child: Container(
                color: Colors.transparent,
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(DefaultColors.primarySmooth),
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    this.emailController.dispose();
    this.senhaController.dispose();
    this.emailAuxController.dispose();
    this.focusEmailAux.dispose();
    this.focusEmail.dispose();
    this.focusSenha.dispose();
  }
}