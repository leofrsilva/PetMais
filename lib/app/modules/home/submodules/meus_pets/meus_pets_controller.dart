import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';

import '../../home_controller.dart';

part 'meus_pets_controller.g.dart';

@Injectable()
class MeusPetsController = _MeusPetsControllerBase with _$MeusPetsController;

abstract class _MeusPetsControllerBase with Store {
  HomeController _homeController;
  PetRemoteRepository _petRemoteRepository;
  AdocaoRemoteRepository _adocaoRemoteRepository;
  _MeusPetsControllerBase(
    this._homeController,
    this._petRemoteRepository,
    this._adocaoRemoteRepository,
  ) {
    selectedEspGroup = this.listEspGroup[0];
    selectedSexGroup = this.listSexGroup[0];
  }

  HomeController get home => this._homeController;

  UsuarioModel get usuario => this.home.auth.usuario;

  AnimationDrawerController get animationDrawer => this.home.animationDrawer;

  List<String> listEspGroup = ["Todos", "Cachorro", "Gato"];

  List<String> listSexGroup = ["Todos", "Macho", "Fêmea"];

  bool paraAdocao;
  setParaAdocao(bool value) => this.paraAdocao = value;

  List<String> listOp = const [
    "Agrupar Por",
  ];

  // Sexo
  @observable
  String selectedSexGroup;

  @action
  setSelectedSexGroup(String value) => this.selectedSexGroup = value;

  // Espécie
  @observable
  String selectedEspGroup;

  @action
  setSelectedEspGroup(String value) => this.selectedEspGroup = value;

  void onTapSelected(String op) {
    switch (op) {
      case "Agrupar Por":
        // Agrupar
        _agruparPor();
        break;
    }
  }

  Future _agruparPor() async {
    String selectedEsp = this.selectedEspGroup ?? "Todos";
    String selectedSex = this.selectedSexGroup ?? "Todos";
    bool checkParaAdocao = this.paraAdocao;
    bool selected = await Modular.to.showDialog(
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: this.listEspGroup.map((String opcao) {
                    return Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.black26),
                      child: RadioListTile<String>(
                        title: Text(opcao, style: kLabelStyle),
                        activeColor: DefaultColors.secondary,
                        selected: selectedEsp == opcao ? true : false,
                        value: opcao,
                        groupValue: selectedEsp,
                        onChanged: (String op) {
                          setState(() {
                            selectedEsp = op;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                Divider(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: this.listSexGroup.map((String opcao) {
                    return Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.black26),
                      child: RadioListTile<String>(
                        title: Text(opcao, style: kLabelStyle),
                        activeColor: DefaultColors.secondary,
                        selected: selectedSex == opcao ? true : false,
                        value: opcao,
                        groupValue: selectedSex,
                        onChanged: (String op) {
                          setState(() {
                            selectedSex = op;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: CustomCheckBox(
                    tristate: true,
                    text: "Para Adoção",
                    value: checkParaAdocao,
                    onChanged: (bool value) {
                      setState(() {
                        checkParaAdocao = value;
                      });
                    },
                    onTap: () {
                      if (checkParaAdocao == null) {
                        setState(() => checkParaAdocao = false);
                      } else if (checkParaAdocao == false) {
                        setState(() => checkParaAdocao = true);
                      } else if(checkParaAdocao == true){
                        setState(() => checkParaAdocao = null);
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancelar",
                  style: TextStyle(
                    color: DefaultColors.primary,
                    fontSize: 14,
                    fontFamily: "RussoOne",
                  ),
                ),
                onPressed: () {
                  Modular.to.pop(false);
                },
              ),
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
                  Modular.to.pop(true);
                },
              ),
            ],
          );
        });
      },
    );
    if (selected != null) {
      if (selected) {
        print(selectedEsp);
        print(selectedSex);
        print(checkParaAdocao);
        setSelectedEspGroup(selectedEsp);
        setSelectedSexGroup(selectedSex);
        setParaAdocao(checkParaAdocao);
      }
    }
  }

  //? -----------------------------------------------------------------------------
  //? -----------------------------------------------------------------------------
  //? Cadastro de Pet
  Future<Map<String, dynamic>> cadastrarPet(
      PetModel pet, List<File> listImages) async {
    Map<String, dynamic> result;
    int i = 0;
    for (File img in listImages) {
      i++;
      result = await this._petRemoteRepository.uploadImagePet(img, false);
      if (result["Result"] == "Falha no Envio" ||
          result["Result"] == "Not Send") {
        return result;
      }
    }
    if (i == listImages.length) {
      //* Registrar no Banco de Dados
      result = await this._petRemoteRepository.registerPet(pet);
      return result;
    }
    return {"Result": "Falha na Conexão"};
  }

  //? -----------------------------------------------------------------------------
  //? -----------------------------------------------------------------------------
  //? Cadastro de Pet
  Future<String> addAdocao(AdocaoModel adocaoModel) async {
    Map<String, dynamic> result =
        await this._adocaoRemoteRepository.registerAdocao(adocaoModel);
    return result["Result"];
  }

  Future<List<PetModel>> recuperarPets() async {
    String sexo;
    if (selectedSexGroup == listSexGroup[1]) {
      sexo = "M";
    } else if (selectedSexGroup == listSexGroup[2]) {
      sexo = "F";
    } else if (selectedSexGroup == listSexGroup[0]) {
      sexo = "todos";
    }
    return await this._petRemoteRepository.listPet(
          idDono: this.usuario.usuarioInfoModel.id,
          agruparEsp: this.selectedEspGroup.toLowerCase(),
          agruparSex: sexo,
          paraAdocao: this.paraAdocao,
        );
  }
}
