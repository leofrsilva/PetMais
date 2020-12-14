import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/submodules/drawer/drawer_menu_controller.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';

import '../../../../home_controller.dart';

part 'perfil_petshop_controller.g.dart';

@Injectable()
class PerfilPetshopController = _PerfilPetshopControllerBase
    with _$PerfilPetshopController;

abstract class _PerfilPetshopControllerBase with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final _picker = ImagePicker();
  HomeController _homeController;
  DrawerMenuController _drawerMenuController;
  _PerfilPetshopControllerBase(
    this._homeController,
    this._drawerMenuController,
  );

  HomeController get home => this._homeController;
  UsuarioModel get usuario => this.home.auth.usuario;
  UsuarioInfoJuridicoModel get usuarioInfo => (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel);
  AnimationDrawerController get animationDrawer => this.home.animationDrawer;

  void showUpdUser() async {
    var result = await Navigator.of(context).pushNamed("/updatePetshop");
 
    if (result != null) {
      FlushbarHelper.createSuccess(
        duration: Duration(milliseconds: 1750),
        message: "Atualizado com Sucesso!",
      )..show(this.context);
      this._homeController.auth.usuario = result;
      await this._homeController.signIn();
      this.atualizarInfoUser();
    }
  }

  void updateInAppImage(String urlFoto) {
    UsuarioModel usuarioModel = this.usuario;
    (usuarioModel.usuarioInfo as UsuarioInfoModel).urlFoto =
        UsuarioRemoteRepository.URL + "/files/" + urlFoto;
    this._homeController.signIn();
  }

  //* Atualizando Imagem do Drawer
  void atualizarImage() {
    this._drawerMenuController.execClearCache();
  }

  //* Atualizando Imagem do Drawer
  void atualizarInfoUser() {
    this._drawerMenuController.resetInfoUser();
  }

  //? -----------------------------------------------------------------------
  //? Imagem
  String imgDepreciada;
  bool isDeleteImgDepreciada = false;

  Future<File> _captureFoto(String op) async {
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
        return await _treatImage(auxImage);
      }
    }
    return null;
  }

  Future<File> _treatImage(File fileImage) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = tempDir.path;
    //? String title = _titleController.text;
    String emailUser = "";
    for (var letra in this.usuario.email.codeUnits) {
      emailUser += letra.toString();
    }
    emailUser = emailUser + ".jpg";

    if (this.usuario.usuarioInfo.urlFoto != "No Photo") {
      this.imgDepreciada = (this.usuario.usuarioInfo is UsuarioInfoModel)
          ? (this.usuario.usuarioInfo as UsuarioInfoModel)
              .urlFoto
              .split("image_")[1]
          : (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
              .urlFoto
              .split("image_")[1];
      //*Verificando diferença entre nome dos arquivos
      if (emailUser != this.imgDepreciada) {
        this.isDeleteImgDepreciada = true;
      }
    } else {
      this.isDeleteImgDepreciada = true;
    }

    File compressImg = new File("$path/image_$emailUser")
      ..writeAsBytesSync(fileImage.readAsBytesSync().toList());
    return compressImg;
  }

  Future updateFotoUser(String op) async {
    File tmpImage = await this._captureFoto(op);
    if (tmpImage != null) {
      //* Start Loading
      this.showLoading();
      final usuarioRepository = UsuarioRemoteRepository();
      String path;
      //? -----------------------
      if (this.isDeleteImgDepreciada && (this.imgDepreciada != null))
        path = "image_" + imgDepreciada;
      //? -----------------------
      await usuarioRepository
          .uploadImagePerfil(tmpImage, false, imgDepreciada: path)
          .then((Map<String, dynamic> result) async {
        if (result["Result"] == "Falha no Envio" ||
            result["Result"] == "Not Send") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro ao Enviar Imagem!",
          )..show(this.context);
        } else if (result["Result"] == "Send") {
          //? -----------------------
          if (isDeleteImgDepreciada) {
            String urlFoto = "images/perfil/" + tmpImage.path.split("/").last;
            await usuarioRepository
                .updateUrlFotoUser(this.usuario.usuarioInfo.id, urlFoto)
                .then((String result) {
              //* Stop Loading
              Modular.to.pop();
              if (result == "Falha na Conexão") {
                //? Mensagem de Erro
                FlushbarHelper.createError(
                  duration: Duration(milliseconds: 1500),
                  message: "Erro ao atualizar da Imagem!",
                )..show(this.context);
              } else if (result == "Not Found Register") {
                //? Erro Select
                FlushbarHelper.createInformation(
                  duration: Duration(milliseconds: 1750),
                  message: "Dados no Encontrados!",
                )..show(this.context);
              } else if (result == "Register Update") {
                FlushbarHelper.createSuccess(
                  duration: Duration(milliseconds: 1500),
                  message: "Imagem Atualizada com Sucesso!",
                )..show(this.context);
                //? Atualizando URL da Imagem no APP
                this.updateInAppImage(urlFoto);
              }
            });
          } else {
            //* Stop Loading
            Modular.to.pop();
            FlushbarHelper.createSuccess(
              duration: Duration(milliseconds: 1500),
              message: "Imagem Atualizada com Sucesso!",
            )..show(this.context);
          }
        }
      });
    }
  }

  //* Check Email
  Future<String> checkEmail(String email, {bool isLoading}) async {
    final usuarioRepository = UsuarioRemoteRepository();
    Map<String, dynamic> result;
    result = await usuarioRepository.checkEmail(email, loading: isLoading);
    return result["Result"];
  }

  //* Update Pet Shop
  Future<String> update(UsuarioModel usuario) async {
    final usuarioRepository = UsuarioRemoteRepository();
    Map<String, dynamic> result;
    result = await usuarioRepository.updateUser(usuario);
    return result["Result"];
  }

  //? Loading
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

  //? Hide Loading
  void hideLoading(){
    Modular.to.pop();
  }
}
