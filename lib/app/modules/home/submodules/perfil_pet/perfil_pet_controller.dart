import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:petmais/app/modules/home/submodules/adocao_del/adocao_del_module.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

import '../../home_controller.dart';

part 'perfil_pet_controller.g.dart';

class PerfilPetController = _PerfilPetControllerBase with _$PerfilPetController;

abstract class _PerfilPetControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  HomeController _homeController;
  PetRemoteRepository _petRemoteRepository;
  _PerfilPetControllerBase(
    this._homeController,
    this._petRemoteRepository,
  ) {
    this.pageController = PageController();
  }

  PageController pageController;

  HomeController get home => this._homeController;
  UsuarioModel get usuario => this.home.auth.usuario;

  // Get Repository Pet
  PetRemoteRepository get petRepository => this._petRemoteRepository;

  @observable
  PetModel pet;

  @action
  setPet(PetModel value) => this.pet = value;

  @action
  setPetImages(PetImagesModel value) => this.pet.petImages = value;

  List<String> listOp = ["Atualizar Foto", "Excluir Pet"];

  //* ---------------------------------------------------------------------
  //* Formatar Telefone
  String formatterPhone(String phon){
    if(phon.length == 13){
      return phon.replaceRange(8, 9, phon.substring(8, 9) + "-"); 
    }
    else if (phon.length == 14) {
      return phon.replaceRange(9, 10, phon.substring(9, 10) + "-");
    }
  }

  //? ---------------------------------------------------------------------
  //? Update Imagem
  Function updImg;
  setUpdImg(Function function) => this.updImg = function;

  Future onTapSelected(String op) async {
    switch (op) {
      case "Atualizar Foto":
        _editarFoto();
        break;
      case "Excluir Pet":
        _excluirPet();
        break;
    }
  }

  //? -------------------------------------------------------------------
  //? Atualizar Foto
  Future _editarFoto() async {
    await this.showUpdPetImages();
  }

  //? -------------------------------------------------------------------
  //? Excluir Pet
  void _excluirPet() async {
    bool isDelete = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Tem certeza que deseja remover seu Pet?",
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
                  Navigator.pop(context, false);
                },
              ),
              FlatButton(
                child: Text(
                  "Sim",
                  style: kFlatButtonStyle,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
      },
    );
    if (isDelete == true) {
      //* Start Loading
      this.showLoading();
      await this
          ._petRemoteRepository
          .deletePet(this.pet.id)
          .then((Map<String, dynamic> result) {
        Modular.to.pop();
        if (result["Result"] == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro ao executar Exclusão!",
          )..show(this.context);
        } else if (result["Result"] == "Delete Register") {
          //? Sucesso na Exclusão
          print("Pet Excluido!");
          Modular.to.pop();
        } else {
          //? Problema na Exclusão
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1500),
            message: "Problema na Exclusão do Pet!",
          )..show(this.context);
        }
      });
    }
  }

  //? ---------------------------------------------------------------------------
  //? Atualizar Info Pet
  Future showUpdPet() async {
    var result =
        await Modular.link.pushNamed("/updatePet", arguments: this.pet);
    if (result != null) {
      FlushbarHelper.createSuccess(
        duration: Duration(milliseconds: 1750),
        message: "Atualizado com Sucesso!",
      )..show(this.context);
      setPet(result);
    }
  }

  //? ---------------------------------------------------------------------------
  //? Atualizar Images Pet
  Future showUpdPetImages() async {
    var result = await Modular.link
        .pushNamed("/updatePetImages", arguments: this.pet.petImages);
    if (result != null) {
      FlushbarHelper.createSuccess(
        duration: Duration(milliseconds: 1750),
        message: "Atualizado com Sucesso!",
      )..show(this.context);
      this.setPetImages(result);
      this.updImg.call();
    }
  }

  Future<String> update(PetModel pet) async {
    Map<String, dynamic> result;
    result = await this._petRemoteRepository.updatePet(pet);
    return result["Result"];
  }

  void showLoading() {
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

  Future<PostAdocaoModel> recuperarPetAdocao() async {
    Map<String, dynamic> map =
        await this._petRemoteRepository.getAdocao(idPet: this.pet.id);
    if (map["Result"] == "Found adocao") {
      Map<String, dynamic> adocao = json.decode(map["PetInfo"]);
      PostAdocaoModel postAdocao = PostAdocaoModel(
        idDono: this.usuario.usuarioInfo.id,
        idPet: this.pet.id,
        nomeDono: this.usuario.usuarioInfo is UsuarioInfoModel
            ? (this.usuario.usuarioInfo as UsuarioInfoModel).nome
            : (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).nomeOrg,
        nome: this.pet.nome,
        imgDono: this.usuario.usuarioInfo is UsuarioInfoModel
            ? (this.usuario.usuarioInfo as UsuarioInfoModel).urlFoto
            : (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).urlFoto,
        especie: this.pet.especie,
        raca: this.pet.raca,
        sexo: this.pet.sexo,
        petImages: this.pet.petImages,
        dataNascimento: this.pet.dataNascimento,
        email: adocao["email"],
        numeroTelefone: adocao["numeroTelefone"],
        dataRegistro: adocao["dataRegistro"],
        descricao: adocao["descricao"],
      );
      return postAdocao;
    } else {
      return null;
    }
  }

  //* Delete Adoção
  Future<bool> onPressedDel(Size size, int id) async {
    return await Modular.to.showDialog(builder: (_) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: size.height * 0.2,
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(12.0),
            child: RouterOutlet(
              initialRoute: "/$id",
              module: AdocaoDelModule(),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    this.pageController.dispose();
  }
}
