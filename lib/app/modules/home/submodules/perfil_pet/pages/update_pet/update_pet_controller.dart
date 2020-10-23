import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/perfil_pet/perfil_pet_controller.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomRadioButton.dart';
part 'update_pet_controller.g.dart';

class UpdatePetController = _UpdatePetControllerBase with _$UpdatePetController;

abstract class _UpdatePetControllerBase with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  PerfilPetController _perfilPetController;
  _UpdatePetControllerBase(this._perfilPetController) {
    this.dataController = MaskedTextController(
      mask: "00/00/0000",
    );
    this.nomeController = TextEditingController();
    this.especieController = TextEditingController();
    this.racaController = TextEditingController();
    this.focusNome = FocusNode();
    this.focusData = FocusNode();
    this.focusEspecie = FocusNode();
    this.focusRaca = FocusNode();
  }

  //? Inicializar Form
  void init(PetModel pet) {
    this.petModel = pet;
    this.dataController = MaskedTextController(
      text: pet.dataNascimento ?? "",
      mask: "00/00/0000",
    );
    this.nomeController = TextEditingController(text: pet.nome);
    this.especieController = TextEditingController(text: pet.especie);
    this.racaController = TextEditingController(text: pet.raca ?? "");
    this.valueSexo = pet.sexo;
  }

  PetModel petModel;
  TextEditingController nomeController;
  MaskedTextController dataController;
  TextEditingController especieController;
  TextEditingController racaController;

  FocusNode focusNome;
  FocusNode focusData;
  FocusNode focusEspecie;
  FocusNode focusRaca;

  final formKey = GlobalKey<FormState>();

  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;

  @observable
  String valueSexo = "M";

  @action
  setSexo(String value) => this.valueSexo = value;

  //? -----------------------------------------------------------------------
  //? Data
  void selectData(BuildContext context) async {
    DateTime initData = DateTime(DateTime.now().year - 18);
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
    DateTime dataNow = DateTime.now();
    DateTime dataTime = convertStringForDate(textData);
    String data = _formatarData(dataTime.toString());

    if (data == textData) {
      if (dataTime.year > dataNow.year) {
        return false;
      } else if (dataTime.year == dataNow.year &&
          dataTime.month > dataNow.month) {
        return false;
      } else if (dataTime.year == dataNow.year &&
          dataTime.month == dataNow.month &&
          dataTime.day > dataNow.day) {
        return false;
      }
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

  //? -----------------------------------------------------------------------
  //? Atualizar
  Future atualizar() async {
    if (formKey.currentState.validate()) {
      setError(false);
      if ((petModel.nome != nomeController.text.trim()) ||
          (petModel.dataNascimento != dataController.text.trim()) ||
          (petModel.especie != dataController.text.trim()) ||
          (petModel.raca != racaController.text.trim()) ||
          (petModel.sexo != this.valueSexo)) {
        //* Start Loading
        this.showLoading();
        PetModel pet = this.petModel;
        pet.nome = this.nomeController.text.trim();
        pet.dataNascimento = this.dataController.text.trim();
        pet.especie = this.especieController.text;
        pet.raca = this.racaController.text.isEmpty
            ? "SRD (Sem Raça Definida)"
            : this.racaController.text.trim();
        pet.sexo = this.valueSexo;
        await this._perfilPetController.update(pet).then((String result) {
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
            Modular.to.pop(pet);
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
  }

  void exit() {
    Modular.to.pop();
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
}
