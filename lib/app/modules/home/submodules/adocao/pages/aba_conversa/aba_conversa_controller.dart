import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:petmais/app/modules/home/submodules/adocao/models/conversation/conversation_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';

import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import '../../adocao_controller.dart';
part 'aba_conversa_controller.g.dart';

class AbaConversaController = _AbaConversaControllerBase
    with _$AbaConversaController;

abstract class _AbaConversaControllerBase extends Disposable with Store {
  final AdocaoController _adocaoController;
  final FirestoreChatRepository _chatRepository;
  _AbaConversaControllerBase(this._adocaoController, this._chatRepository);

  AnimationDrawerController get animationDrawer =>
      this._adocaoController.animationDrawer;

  AuthStore get auth => this._adocaoController.auth;

  UsuarioChatModel get userChat => this.auth.usuarioChat;

  final _controllerConversation = StreamController<QuerySnapshot>.broadcast();
  StreamController<QuerySnapshot> get conversations => this._controllerConversation;

  void addListenerConversations() {
    //Stream<QuerySnapshot>
    final stream = this._chatRepository.listConversation(
          this.auth.usuario.usuarioInfoModel.id.toString(),
        );

    stream.listen((dados) {
      if (!_controllerConversation.isClosed) {
        _controllerConversation.add(dados);
      }
    });
  }

  void logar() {
    Modular.to.pushNamedAndRemoveUntil("/auth", (_) => false);
  }

  @override
  void dispose() {
    this._controllerConversation.close();
  }
}
