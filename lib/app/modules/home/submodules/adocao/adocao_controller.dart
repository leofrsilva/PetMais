import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/widgets/BottomSheetPostAdocao.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import '../../controllers/animation_drawer_controller.dart';
import '../../home_controller.dart';

import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';

part 'adocao_controller.g.dart';

class AdocaoController = _AdocaoControllerBase with _$AdocaoController;

abstract class _AdocaoControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext value) => this.context = value;

  HomeController _homeController;
  _AdocaoControllerBase(this._homeController);

  TabController tabController;
  setTaController(TabController controller) => this.tabController = controller;

  AuthStore get auth => this._homeController.auth;

  AnimationDrawerController get animationDrawer =>
      this._homeController.animationDrawer;

  HomeController get home => this._homeController;

  // -----------------------------------------------
  Future removerUsuarioLocalmente() async {
    await this._homeController.exit();
    this.auth.setUser(UsuarioModel());
  }

  Future<List<PostAdocaoModel>> listAllAdocoes(String esp, String rac, bool isONG) async {
    final adocaoRepository = AdocaoRemoteRepository();
    return await adocaoRepository.listAllAdocoes(0, especie: esp, raca: rac, ong: isONG);

  }

  Future showPostAdocao(
      PostAdocaoModel postAdocaoModel, UsuarioModel userModel) async {
    await showModalBottomSheet(
      elevation: 6.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BottomSheetPostAdocao(
          postAdotation: postAdocaoModel,
          usuarioModel: userModel,
        );
      },
    ).then((value) {
      if (value is bool && value == true) {
        UsuarioChatModel usuarioChat = UsuarioChatModel(
          identifier: postAdocaoModel.idDono,
          name: postAdocaoModel.nomeDono,
          image: postAdocaoModel.imgDono != "No Photo"
              ? UsuarioRemoteRepository.URL + "/files/" + postAdocaoModel.imgDono
              : "No Photo",
        );
        this.tabController.animateTo(1);
        Future.delayed(
            Duration(
              milliseconds: 200,
            ), () {
          bool viewed = false;
          Modular.to.pushNamed("/home/chat/$viewed", arguments: usuarioChat);
        });
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
  }
}
