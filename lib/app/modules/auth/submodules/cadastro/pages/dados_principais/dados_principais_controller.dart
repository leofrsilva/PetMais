import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import '../../cadastro_controller.dart';

part 'dados_principais_controller.g.dart';

class DadosPrincipaisController = _DadosPrincipaisControllerBase
    with _$DadosPrincipaisController;

abstract class _DadosPrincipaisControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final CadastroController cadastroController;
  TextEditingController emailController;
  TextEditingController senhaController;
  TextEditingController senhaConfController;
  FocusNode focusSenha;
  FocusNode focusConfSenha;
  _DadosPrincipaisControllerBase(this.cadastroController) {
    emailController = TextEditingController(
      text: this.cadastroController.usuario.email,
    );
    senhaController = TextEditingController(text: "");
    senhaConfController = TextEditingController(text: "");

    this.typeUser =
        this.cadastroController.usuario?.typeUser ?? TypeUser.fisica;
    focusSenha = FocusNode();
    focusConfSenha = FocusNode();
  }

  final formKey = GlobalKey<FormState>();

  @observable
  bool isEmailValid;

  @action
  setIsEmailValid(bool value) => this.isEmailValid = value;

  //* VerificarEmail
  Future verificarEmail() async {
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
                valueColor: AlwaysStoppedAnimation(DefaultColors.secondary),
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
    await this
        .cadastroController
        .checkEmail(this.emailController.text.trim(), isLoading: true)
        .then((String result) {
      if(result == "Falha na Conexão"){
        //? Mensagem de Erro
        FlushbarHelper.createError(
          duration: Duration(milliseconds: 1750),
          message: "Erro na Conexão!",
        )..show(this.context);
      }else if (result == "Found") {
        setIsEmailValid(false);
      } else {
        setIsEmailValid(true);
      }
      
    });
  }

  //* Verificar Senha
  bool verificarSenha() {
    String pass = senhaController.text.trim();
    bool isNumber = false;
    bool isText = false;
    for (var item in pass.codeUnits) {
      for (int i = 48; i <= 57; i++) {
        if (item == i) isNumber = true;
      }
    }
    for (var item in pass.codeUnits) {
      for (int i = 65; i <= 90; i++) {
        if (item == i) isText = true;
      }
      for (int i = 97; i <= 122; i++) {
        if (item == i) isText = true;
      }
    }
    if (!(isNumber && isText)) {
      return true;
    } else {
      return false;
    }
  }

  @observable
  bool obscureText = true;
  @action
  setObscureText() => this.obscureText = !this.obscureText;

  @observable
  bool obscureTextConf = true;
  @action
  setObscureTextConf() => this.obscureTextConf = !this.obscureTextConf;

  // Categoria do Usuário
  @observable
  TypeUser typeUser;

  @action
  setTypeUser(TypeUser type) => this.typeUser = type;

  // ERROR ----------------------
  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;

  // LOADING --------------------
  @observable
  bool isLoading = false;

  @action
  setLoading(bool value) => this.isLoading = value;
  //---------------------

  Future next() async {
    await verificarEmail().whenComplete((){
      if (formKey.currentState.validate()) {
        setError(false);
        UsuarioModel usuario = UsuarioModel(
          email: this.emailController.text.trim(),
          senha: this.senhaController.text.trim(),
          type: this.typeUser,
        );
        this.cadastroController.setUsuarioModel = usuario;
        if (this.typeUser == TypeUser.fisica) {
          this.cadastroController.changePage(1);
        } else if (this.typeUser == TypeUser.juridica) {
          this.cadastroController.changePage(2);
        }
      } else {
        setError(true);
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    senhaConfController.dispose();
    focusSenha.dispose();
    focusConfSenha.dispose();
  }
}
