import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/modules/home/submodules/meus_pets/meus_pets_controller.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomRadioButton.dart';

part 'add_pet_controller.g.dart';

class AddPetController = _AddPetControllerBase with _$AddPetController;

abstract class _AddPetControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final _picker = ImagePicker();
  MeusPetsController _meusPetsController;
  _AddPetControllerBase(this._meusPetsController) {
    this.dataController = MaskedTextController(
      mask: "00/00/0000",
    );
    this.nomeController = TextEditingController();
    this.especieController = TextEditingController();
    this.racaController = TextEditingController();
    this.descricaoController = TextEditingController();
    this.emailController = TextEditingController(
      text: this.usuario.email,
    );
    this.phoneController = MaskedTextController(
      text: this.usuario.usuarioInfoModel.numeroTelefone,
      mask: "(00) 90000-0000",
    );
    this.pageController = PageController(initialPage: 0);

    this.focusNome = FocusNode();
    this.focusData = FocusNode();
    this.focusEspecie = FocusNode();
    this.focusRaca = FocusNode();
    this.focusDescricao = FocusNode();
    this.focusEmail = FocusNode();
    this.focusPhone = FocusNode();
  }

  UsuarioModel get usuario => this._meusPetsController.usuario;

  TextEditingController nomeController;
  MaskedTextController dataController;
  TextEditingController especieController;
  TextEditingController racaController;

  FocusNode focusNome;
  FocusNode focusData;
  FocusNode focusEspecie;
  FocusNode focusRaca;

  //? Text Editing Adoção
  PageController pageController;
  //
  TextEditingController descricaoController;
  FocusNode focusDescricao;
  TextEditingController emailController;
  FocusNode focusEmail;
  TextEditingController phoneController;
  FocusNode focusPhone;

  final formKey = GlobalKey<FormState>();

  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;

  @observable
  bool forAdocao = false;

  @action
  setForAdocao(bool value) {
    if (this.forAdocao == false) {
      this.emailController.text = this.usuario.email;
      this.phoneController.text = this.usuario.usuarioInfoModel.numeroTelefone;
      this.setError(false);
    }
    this.forAdocao = value;
  }

  @observable
  String valueSexo = "M";

  @action
  setSexo(String value) => this.valueSexo = value;

  //? -----------------------------------------------------------------------
  //? Lista de Imagem
  @observable
  ObservableList<File> listImages = List<File>().asObservable();

  @computed
  int get totalImg => listImages.length;

  @action
  addItem(File value) {
    listImages.add(value);
  }

  @action
  removeItem(File value) {
    listImages.removeWhere((img) => img.path == value.path);
  }

  //? -----------------------------------------------------------------------
  //? Imagem
  Future selectImage() async {
    String op = await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop("camera");
                  },
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: DefaultColors.background,
                  child: Text(
                    "Câmera",
                    style: kButtonStyle,
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop("galeria");
                  },
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: DefaultColors.background,
                  child: Text(
                    "Galeria",
                    style: kButtonStyle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    this.capturar(op);
  }

  Future capturar(String op) async {
    PickedFile imageSelected;
    if (op == "camera") {
      imageSelected = await _picker.getImage(source: ImageSource.camera);
    } else if (op == "galeria") {
      imageSelected = await _picker.getImage(source: ImageSource.gallery);
    }
    if (imageSelected != null) {
      File img = File(imageSelected.path);
      File auxImage = await ImageCropper.cropImage(
          sourcePath: img.path,
          // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 95,
          cropStyle: CropStyle.circle,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Recortar',
            toolbarColor: DefaultColors.primary,
            toolbarWidgetColor: Colors.grey,
            activeControlsWidgetColor: Colors.grey,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (auxImage != null) {
        await _treatImage(auxImage).then((File imgFile) {
          this.addItem(imgFile);
        });
      }
    }
  }

  Future<File> _treatImage(File fileImage) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = tempDir.path;
    //? String title = _titleController.text;
    String id = this.usuario.usuarioInfoModel.id.toString();
    String rand = DateTime.now().millisecondsSinceEpoch.toString();

    File compressImg = new File("$path/image_$id" + "_$rand.jpg")
      ..writeAsBytesSync(fileImage.readAsBytesSync().toList());
    print(compressImg.toString());
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
      final dataFormat = _formatarData(date);
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

  //* Formatar Data
  String _formatarData(DateTime data) {
    initializeDateFormatting("pt_BR");
    //var formatter = DateFormat("d/M/y");
    var formatter = DateFormat.yMd("pt_BR");
    String dataFomatada = formatter.format(data);
    return dataFomatada;
  }

  bool isValidData(String textData) {
    DateTime dataTime = convertStringForDate(textData);
    String data = _formatarData(dataTime);
    if (data == textData) {
      return true;
    } else {
      return false;
    }
  }

  //? ------------------------------------------------------------------------
  //?
  void showEspecie() async {
    String especieSelected = especieController.text?.trim() ?? "Cachorro";
    await Modular.to.showDialog(
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(0),
            actionsPadding: const EdgeInsets.all(0),
            buttonPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CustomRadioButton<String>(
                    primaryTitle: "Cachorro",
                    secondyTitle: "Gato",
                    primaryValue: "Cachorro",
                    secondyValue: "Gato",
                    groupValue: especieSelected,
                    primaryOnChanged: (String value) {
                      setState(() {
                        especieSelected = value;
                      });
                    },
                    secondyOnChanged: (String value) {
                      setState(() {
                        especieSelected = value;
                      });
                    },
                    activeColor: DefaultColors.background,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Ok",
                  style: TextStyle(
                    color: DefaultColors.primary,
                    fontSize: 14,
                    fontFamily: "RussoOne",
                  ),
                ),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            ],
          );
        });
      },
    );
    especieController.text = especieSelected;
  }

  //? ------------------------------------------------------------------------
  //? Adicionar PET
  Future adicionar() async {
    if (this.formKey.currentState.validate()) {
      setError(false);
      //Model Images do Pet
      PetImagesModel petImages = PetImagesModel(
        imgP:
            "images/pets/" + this.listImages.elementAt(0).path.split("/").last,
        imgS: this.listImages.length >= 2
            ? "images/pets/" + this.listImages.elementAt(1).path.split("/").last
            : "No Photo",
        imgT: this.listImages.length >= 3
            ? "images/pets/" + this.listImages.elementAt(2).path.split("/").last
            : "No Photo",
      );
      // Model Pet
      PetModel pet = PetModel(
        idDono: this.usuario.usuarioInfoModel.id,
        nome: this.nomeController.text.trim(),
        dataNascimento: this.dataController.text.trim(),
        especie: this.especieController.text.trim(),
        raca: this.racaController.text.trim().isEmpty
            ? "SRD (Sem Raça Definida)"
            : this.racaController.text.trim(),
        sexo: this.valueSexo,
        estado: this.forAdocao ? 1 : 0,
        petImages: petImages,
      );
      //* Start Loading
      this.showLoading();
      Map<String, dynamic> record = await this
          ._meusPetsController
          .cadastrarPet(pet, this.listImages.toList());
      String result = record["Result"];
      int idPet = record["Id"];
      //* Falha no Envio da Imagem
      if (result == "Falha no Envio" || result == "Not Send") {
        //* Stop Loading
        Modular.to.pop();
        //? Mensagem de Erro
        FlushbarHelper.createError(
          duration: Duration(milliseconds: 1500),
          message: "Erro ao Enviar Imagem!",
        )..show(this.context);
      } else if (result == "Falha na Conexão") {
        Navigator.of(this.context).pop();
        //* Stop Loading
        Modular.to.pop();
        //? Mensagem de Erro
        FlushbarHelper.createError(
          duration: Duration(milliseconds: 1500),
          message: "Erro na Conexão!",
        )..show(this.context);
      } else if (result == "No Registered in Pets") {
        //* Stop Loading
        Modular.to.pop();
        //? Dados do Login Incorreto
        FlushbarHelper.createInformation(
          duration: Duration(milliseconds: 1750),
          title: "Cadastro",
          message: "Falha no cadastro do Pet!",
        )..show(this.context);
      } else if (result == "No Registered in Pet_Images") {
        //* Stop Loading
        Modular.to.pop();
        //? Dados do Login Incorreto
        FlushbarHelper.createInformation(
          duration: Duration(milliseconds: 1750),
          title: "Cadastro",
          message: "Falha no cadastro das Imagens do Pet!",
        )..show(this.context);
      }
      //* Sucesso no Cadastro
      else if (result == "Registered") {
        if (this.forAdocao == true) {
          AdocaoModel adocaoModel = AdocaoModel(
            idPet: idPet,
            email: this.emailController.text.trim(),
            numeroTelefone: this.phoneController.text.trim(),
            dataRegistro: _formatarData(DateTime.now()),
            descricao: this.descricaoController.text.trim(),
          );
          await this
              ._meusPetsController
              .addAdocao(adocaoModel)
              .then((String resposta) {
            Modular.to.pop();
            if (resposta == "Falha na Conexão") {
              Navigator.of(this.context).pop();
              //? Mensagem de Erro
              FlushbarHelper.createError(
                duration: Duration(milliseconds: 1500),
                message: "Erro na Conexão, ao Adicionar a Adoção!",
              )..show(this.context);
            } else if (resposta == "Registered") {
              Navigator.of(this.context).pop();
              FlushbarHelper.createSuccess(
                duration: Duration(milliseconds: 1500),
                message: "Cadastrado com Sucesso!",
              )..show(this.context);
            } else {
              //? Dados do Login Incorreto
              FlushbarHelper.createInformation(
                duration: Duration(milliseconds: 1750),
                title: "Cadastro",
                message: "Não foi possivel Cadastrar a Adoção!",
              )..show(this.context);
            }
          });
        } else {
          //* Stop Loading
          Modular.to.pop();
          Navigator.of(this.context).pop();
          FlushbarHelper.createSuccess(
            duration: Duration(milliseconds: 1500),
            message: "Cadastrado com Sucesso!",
          )..show(this.context);
        }
      }
    } else {
      setError(true);
    }
  }

  showLoading() {
    Modular.to.showDialog(
        barrierDismissible: false,
        builder: (_) {
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
    this.nomeController.dispose();
    this.dataController.dispose();
    this.especieController.dispose();
    this.racaController.dispose();
    this.descricaoController.dispose();

    this.emailController.dispose();
    this.focusEmail.dispose();
    this.phoneController.dispose();
    this.focusPhone.dispose();

    this.pageController.dispose();

    this.focusNome.dispose();
    this.focusData.dispose();
    this.focusEspecie.dispose();
    this.focusRaca.dispose();
    this.focusDescricao.dispose();
  }
}
