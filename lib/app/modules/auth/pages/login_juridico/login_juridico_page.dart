import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

import '../../widgets/CustomFlatButtonAuth.dart';
import '../../../../shared/widgets/CustomTextField.dart';
import '../../../../shared/widgets/CustomButton.dart';
import 'login_juridico_controller.dart';

class LoginJuridicoPage extends StatefulWidget {
  @override
  _LoginJuridicoPageState createState() => _LoginJuridicoPageState();
}

class _LoginJuridicoPageState extends ModularState<LoginJuridicoPage, LoginJuridicoController> {
  Widget get _backGround {
    return Stack(
      children: <Widget>[
        Observer(builder: (_) {
          return Positioned(
            bottom: 10,
            left: 0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 250),
              curve: Curves.fastOutSlowIn,
              opacity: controller.isVisibleBackground ? 1.0 : 0.0,
              child: Container(
                width: 154 * 0.3,
                height: 705 * 0.3,
                child: const Image(
                  image: AssetImage("assets/images/backgroundLine.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomEnd,
              colors: DefaultColors.gradientAux,
              stops: [0.2, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backGround,
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: controller.formKey,
              child: Container(
                height: size.height,
                width: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.075,
                  // vertical: size.height * 0.10,
                ),
                child: ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          height: size.height * 0.25,
                          alignment: Alignment.center,
                          // margin: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: DefaultColors.secondarySmooth,
                                  fontFamily: "OpenSans",
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              FaIcon(
                                FontAwesomeIcons.signInAlt,
                                size: 40,
                                color: DefaultColors.secondarySmooth,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: size.height * 0.04),
                        //--------------------------------
                        Container(
                          height: size.height * 0.45,
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Observer(builder: (_) {
                                bool isError = controller.isError;
                                return SizedBox(
                                    height:
                                        size.height * (isError ? 0.0 : 0.04));
                              }),
                              Observer(builder: (_) {
                                bool isError = controller.isError;
                                return CustomTextField(
                                  height: isError ? 70.0 : 40.0,
                                  controller: controller.emailController,
                                  focusNode: controller.focusEmail,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String value) {
                                    controller.focusSenha.requestFocus();
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
                                    if (value.contains("@") == false ||
                                        value.length < 4) {
                                      return "    [Email Inválido]";
                                    }
                                    return null;
                                  },
                                );
                              }),
                              SizedBox(height: 30.0),
                              Observer(builder: (_) {
                                bool isError = controller.isError;
                                return CustomTextField(
                                  height: isError ? 70.0 : 40.0,
                                  controller: controller.senhaController,
                                  focusNode: controller.focusSenha,
                                  label: "Senha",
                                  hint: "Entre com sua Senha",
                                  isPass: controller.obscureText,
                                  icon: Icons.lock,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                      UsuarioModel.toNumCaracteres()["senha"],
                                    ),
                                  ],
                                  onPressedVisiblePass: () {
                                    controller.setObscureText(
                                      !controller.obscureText,
                                    );
                                  },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "    [O campo é obrigatório]";
                                    }
                                    return null;
                                  },
                                );
                              }),
                              CustomFlatButtonAuth(
                                align: Alignment.topRight,
                                text: "Esqueceu a Senha?",
                                onPressed: controller.esqueciMinhaSenha,
                              ),
                            ],
                          ),
                        ),
                        //----------------------------------------
                        //SizedBox(height: size.height * 0.025),
                        Container(
                          height: size.height * 0.30,
                          child: Column(
                            children: <Widget>[
                              Observer(builder: (_) {
                                return CustomButton(
                                  text: "ENTRAR",
                                  onPressed: controller.logar,
                                  elevation: 0.0,
                                  width: size.width * 0.65,
                                  decoration: kDecorationContainer,
                                  isLoading: controller.isLoading,
                                );
                              }),
                              SizedBox(height: size.height * 0.025),
                              GestureDetector(
                                onTap: () {
                                  Modular.to.pushReplacementNamed("/auth/cadastro");
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Não possui uma conta?",
                                        style: TextStyle(
                                          color: DefaultColors.secondarySmooth,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "RussoOne",
                                        ),
                                      ),
                                      TextSpan(
                                        text: " Inscrever-se",
                                        style: TextStyle(
                                            color:
                                                DefaultColors.secondarySmooth,
                                            fontSize: 16.0,
                                            fontFamily: "RussoOne"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.04),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black26,
                                ),
                                onPressed: () {
                                  Modular.to.pushNamedAndRemoveUntil("/auth", (_) => false);
                                },
                              ),
                            ],
                          ),
                        ),
                        //--------------------------
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