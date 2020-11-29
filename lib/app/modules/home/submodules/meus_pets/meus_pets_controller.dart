import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';

import '../../home_controller.dart';

part 'meus_pets_controller.g.dart';

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
    selectedTypeGroup = this.listTypeGroup[0];
  }

  HomeController get home => this._homeController;

  UsuarioModel get usuario => this.home.auth.usuario;

  AnimationDrawerController get animationDrawer => this.home.animationDrawer;

  List<String> listEspGroup = ["Todos", "Cachorro", "Gato"];

  List<String> listSexGroup = ["Todos", "Macho", "Fêmea"];

  List<String> listTypeGroup = [
    "Especie (Cachorro | Gato)",
    "Sexo (Macho | Fêmea)"
  ];

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

  // ONG
  @observable
  String selectedTypeGroup;

  @action
  setSelectedTypeGroup(String value) => this.selectedTypeGroup = value;

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
    String selectedType = this.selectedTypeGroup ?? "Especie (Cachorro | Gato)";
    bool checkParaAdocao = this.paraAdocao;
    bool selected = await Modular.to.showDialog(
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          Widget options;
          if (this.usuario.usuarioInfo is UsuarioInfoModel) {
            options = Column(
              children: [
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
              ],
            );
          } else {
            options = Column(
              mainAxisSize: MainAxisSize.min,
              children: this.listTypeGroup.map((String opcao) {
                return Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black26),
                  child: RadioListTile<String>(
                    title: Text(opcao, style: kLabelStyle),
                    activeColor: DefaultColors.secondary,
                    selected: selectedType == opcao ? true : false,
                    value: opcao,
                    groupValue: selectedType,
                    onChanged: (String op) {
                      setState(() {
                        selectedType = op;
                      });
                    },
                  ),
                );
              }).toList(),
            );
          }
          return AlertDialog(
            contentPadding: EdgeInsets.only(
              left: 2.0,
              right: 2.0,
              bottom: 2.0,
              top: 12.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                options,
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
                      } else if (checkParaAdocao == true) {
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
        print(selectedType);
        print(checkParaAdocao);
        setSelectedEspGroup(selectedEsp);
        setSelectedSexGroup(selectedSex);
        setSelectedTypeGroup(selectedType);
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

  Map<String, List<PetModel>> ordernarPetsFor(
      List<PetModel> pets) {
    Map<String, List<PetModel>> order = {};
    if (this.selectedTypeGroup == listTypeGroup[0]) {
      List<PetModel> dog = [];
      List<PetModel> cat = [];
      pets.forEach((pet) {
        if (pet.especie == "Cachorro") {
          dog.add(pet);
        } else if (pet.especie == "Gato") {
          cat.add(pet);
        }
      });
      order["dog"] = dog;
      order["cat"] = cat;
    }
    else if (this.selectedTypeGroup == listTypeGroup[1]) {
      List<PetModel> m = [];
      List<PetModel> f = [];
      pets.forEach((pet) {
        if (pet.sexo == "M") {
          m.add(pet);
        } else if (pet.sexo == "F") {
          f.add(pet);
        }
      });
      order["macho"] = m;
      order["femea"] = f;
    }
    return order;
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
          idDono: this.usuario.usuarioInfo.id,
          agruparEsp: this.selectedEspGroup.toLowerCase(),
          agruparSex: sexo,
          paraAdocao: this.paraAdocao,
        );
  }
}
