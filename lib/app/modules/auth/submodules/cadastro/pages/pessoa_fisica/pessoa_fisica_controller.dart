import 'dart:async';
import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;

import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import '../../cadastro_controller.dart';

part 'pessoa_fisica_controller.g.dart';

class PessoaFisicaController = _PessoaFisicaControllerBase
    with _$PessoaFisicaController;

abstract class _PessoaFisicaControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final _picker = ImagePicker();
  final CadastroController cadastroController;
  TextEditingController nomeController;
  TextEditingController sobrenomeController;
  MaskedTextController dataController;
  MaskedTextController phoneController;

  FocusNode focusSobrenome;
  FocusNode focusData;
  FocusNode focusTelefone;

  final formKey = GlobalKey<FormState>();

  _PessoaFisicaControllerBase(this.cadastroController) {
    nomeController = TextEditingController(
      text: this.cadastroController.usuarioInf?.nome ?? "",
    );
    sobrenomeController = TextEditingController(
      text: this.cadastroController.usuarioInf?.sobreNome ?? "",
    );
    dataController = MaskedTextController(
      mask: "00/00/0000",
      text: this.cadastroController.usuarioInf?.dataNascimento ?? "",
    );
    phoneController = MaskedTextController(
      mask: "(00) 90000-0000",
      text: this.cadastroController.usuarioInf?.numeroTelefone ?? "",
    );
    focusSobrenome = FocusNode();
    focusData = FocusNode();
    focusTelefone = FocusNode();
  }

  File compressedImage;
  setCompressedImage(File value) => this.compressedImage = value;

  @observable
  File image;
  @action
  setImage(File value) => this.image = value;

  //? -----------------------------------------------------------------------
  //? Imagem
  void capturar(String op) async {
    PickedFile imageSelected;
    if (op == "camera") {
      imageSelected = await _picker.getImage(source: ImageSource.camera);
    } else if (op == "galeria") {
      imageSelected = await _picker.getImage(source: ImageSource.gallery);
    }
    if (imageSelected != null) {
      await _treatImage(File(imageSelected.path)).then((File auxImage) {
        setImage(File(imageSelected.path));
        setCompressedImage(auxImage);
      });
    }
  }

  Future<File> _treatImage(File fileImage) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = tempDir.path;
    //? String title = _titleController.text;

    String emailUser = "";
    for (var letra in cadastroController.usuario.email.codeUnits) {
      emailUser += letra.toString();
    }

    Img.Image image = Img.decodeImage(fileImage.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);

    File compressImg = new File("$path/image_$emailUser.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 10));
    return compressImg;
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
      lastDate: DateTime(DateTime.now().year),
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

  //----
  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;

  void next() async {
    if (formKey.currentState.validate()) {
      setError(false);
      String urlFoto;
      if (image != null) {
        urlFoto = "images/perfil/" + this.compressedImage.path.split("/").last;
      } else {
        urlFoto = "No Photo";
      }
      UsuarioInfoModel usuarioInfo = UsuarioInfoModel(
        name: nomeController.text.trim(),
        surname: sobrenomeController.text.trim(),
        data: dataController.text.trim(),
        telefone: phoneController.text.trim(),
        foto: urlFoto,
      );
      //* Start Loading
      this.showLoadin();
      this.cadastroController.setUsuarioInfoModel = usuarioInfo;
      await this.cadastroController.cadastrar(this.compressedImage, true).then((String result) {
        if (result == "Falha no Envio" || result == "Not Send"){
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro ao Enviar Imagem!",
          )..show(this.context);
        }
        else if (result == "Registered") {
          this.cadastroController.changePage(3);
        } else if (result == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else {
          //? Dados do Login Incorreto
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1750),
            title: "Cadastro",
            message: "Algum dado está Incorreto!",
          )..show(this.context);
        }
      });
    } else {
      setError(true);
    }
  }

  void back() {
    this.cadastroController.changePage(0);
  }

  showLoadin() {
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(DefaultColors.secondary),
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

  @override
  void dispose() {
    nomeController.dispose();
    sobrenomeController.dispose();
    dataController.dispose();
    phoneController.dispose();
    focusSobrenome.dispose();
    focusData.dispose();
    focusTelefone.dispose();
    if(image != null){
      image.delete();
      compressedImage.delete(); 
    }
  }
}
