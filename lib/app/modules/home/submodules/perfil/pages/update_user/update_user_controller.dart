import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/home/submodules/perfil/perfil_controller.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
part 'update_user_controller.g.dart';

class UpdateUserController = _UpdateUserControllerBase
    with _$UpdateUserController;

abstract class _UpdateUserControllerBase with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  PerfilController _perfilController;
  _UpdateUserControllerBase(this._perfilController) {
    this.nomeController = TextEditingController(
      text: this.usuario.usuarioInfoModel.nome,
    );
    this.sobrenomeController = TextEditingController(
      text: this.usuario.usuarioInfoModel.sobreNome,
    );
    this.emailController = TextEditingController(
      text: this.usuario.email,
    );
    this.dataController = MaskedTextController(
      text: this.usuario.usuarioInfoModel.dataNascimento,
      mask: "00/00/0000",
    );
    phoneController = MaskedTextController(
      text: this.usuario.usuarioInfoModel.numeroTelefone,
      mask: "(00) 90000-0000",
    );
    focusSobrenome = FocusNode();
  }

  UsuarioModel get usuario => this._perfilController.usuario;

  TextEditingController nomeController;
  TextEditingController sobrenomeController;
  TextEditingController emailController;
  MaskedTextController dataController;
  MaskedTextController phoneController;

  FocusNode focusSobrenome;
  FocusNode focusEmail;
  FocusNode focusData;
  FocusNode focusTelefone;

  final formKey = GlobalKey<FormState>();

  @observable
  bool isEmailValid;

  @action
  setIsEmailValid(bool value) => this.isEmailValid = value;

  //----
  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;

  //* VerificarEmail
  Future<bool> verificarEmail() async {
    bool record = false;
    if (this.emailController.text.trim().toLowerCase() !=
        this.usuario.email.toLowerCase()) {
      // Start Loading
      this.showLoading();
      await this
          ._perfilController
          .checkEmail(this.emailController.text.trim(), isLoading: false)
          .then((String result) {
        if (result == "Falha na Conexão") {
          Modular.to.pop();
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1750),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else if (result == "Found") {
          Modular.to.pop();
          setIsEmailValid(false);
        } else {
          setIsEmailValid(true);
          record = false;
        }
      });
    } else {
      setIsEmailValid(true);
      record = true;
    }
    return record;
  }

  //? -----------------------------------------------------------------------
  //? Data
  void selectData(BuildContext context) async {
    DateTime initData = DateTime(DateTime.now().year - 1);
    if (dataController.text.isNotEmpty && dataController.text.length == 10) {
      initData = convertStringForDate(dataController.text);
    }
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 120),
      lastDate: DateTime(DateTime.now().year - 1),
      initialDate: initData,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: const Color(0xff66FFB3),
              primaryVariant: const Color(0xff66FFB3).withOpacity(0.5),
              secondary: const Color(0xff00B0B8),
              secondaryVariant: const Color(0xff00B0B8).withOpacity(0.5),
              surface: const Color(0xff66FFB3),
              background: const Color(0xff21eb13),
              error: const Color(0xffcf6679),
              onPrimary: Colors.grey,
              onSecondary: Colors.black,
              onSurface: Colors.grey,
              onBackground: Colors.grey,
              onError: Colors.black,
              brightness: Brightness.light,
            ),
          ),
          // data: ThemeData(
          //   colorScheme: ColorSchemeDefault.colors,
          // ),
          child: child,
        );
      },
    );
    if (date != null) {
      final dataFormat = _formatarData(date.toString());
      dataController.updateText(dataFormat);
    }
  }

  DateTime convertStringForDate(String textData) {
    List<String> listNumData = textData.split("/");
    String data = "";
    for (var item in listNumData.reversed) {
      data = data + item;
    }
    final result = DateTime.tryParse(data);
    return result;
  }

  String _formatarData(String data) {
    initializeDateFormatting("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    //var formatter = DateFormat("d/M/y");
    var formatter = DateFormat.yMd("pt_BR");

    String dataFomatada = formatter.format(dataConvertida);
    return dataFomatada;
  }

  bool isValidData(String textData) {
    DateTime dataTime = convertStringForDate(textData);
    String data = _formatarData(dataTime.toString());
    if (data == textData) {
      return true;
    } else {
      return false;
    }
  }

  //? -----------------------------------------------------------------------
  //? Atualizar
  Future atualizar() async {
    await verificarEmail().then((bool record) async {
      if (formKey.currentState.validate()) {
        //* Start Loading
        if (record) this.showLoading();
        setError(false);
        if ((usuario.usuarioInfoModel.nome.toLowerCase() !=
                nomeController.text.trim().toLowerCase()) ||
            (usuario.usuarioInfoModel.sobreNome.toLowerCase() !=
                sobrenomeController.text.trim().toLowerCase()) ||
            (usuario.usuarioInfoModel.dataNascimento.toLowerCase() !=
                dataController.text.trim().toLowerCase()) ||
            (usuario.usuarioInfoModel.numeroTelefone.toLowerCase() !=
                phoneController.text.trim().toLowerCase()) ||
            (usuario.email.toLowerCase() !=
                emailController.text.trim().toLowerCase())) {
          UsuarioModel usuarioModel = this.usuario;
          usuarioModel.email = emailController.text.trim();
          usuarioModel.usuarioInfoModel.nome = nomeController.text.trim();
          usuarioModel.usuarioInfoModel.sobreNome =
              sobrenomeController.text.trim();
          usuarioModel.usuarioInfoModel.dataNascimento =
              dataController.text.trim();
          usuarioModel.usuarioInfoModel.numeroTelefone =
              phoneController.text.trim();
          await this
              ._perfilController
              .update(usuarioModel)
              .then((String result) {
            Modular.to.pop();
            if (result == "Falha na Conexão") {
              //? Mensagem de Erro
              FlushbarHelper.createError(
                duration: Duration(milliseconds: 1500),
                message: "Erro na Conexão!",
              )..show(this.context);
            } else if (result == "Not Found Register") {
              //? Dados da Atualização Incorreto
              FlushbarHelper.createInformation(
                duration: Duration(milliseconds: 1750),
                title: "Atualização",
                message: "Algum dado está Incorreto!",
              )..show(this.context);
            } else if (result == "Register Update") {
              //? Sair do Update User e  Confirma Atualização
              Navigator.pop(context, usuarioModel);
            } else {
              //? Mensagem de Falha na Atualização
              FlushbarHelper.createError(
                duration: Duration(milliseconds: 1500),
                message: "Falha na atualização dos Dados!",
              )..show(this.context);
            }
          });
        } else {
          this.exit();
        }
      } else {
        setError(true);
      }
    });
  }

  void exit() {
    Navigator.pop(context, null);
  }

  void showLoading() {
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
  }

  // void toDispose() {
  //   nomeController.dispose();
  //   sobrenomeController.dispose();
  //   emailController.dispose();
  //   dataController.dispose();
  //   phoneController.dispose();

  //   focusSobrenome.dispose();
  //   focusEmail.dispose();
  //   focusData.dispose();
  //   focusTelefone.dispose();
  // }
}
