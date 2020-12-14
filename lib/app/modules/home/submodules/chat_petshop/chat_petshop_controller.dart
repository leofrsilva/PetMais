import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import '../../home_controller.dart';

part 'chat_petshop_controller.g.dart';

@Injectable()
class ChatPetshopController = _ChatPetshopControllerBase
    with _$ChatPetshopController;

abstract class _ChatPetshopControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext value) => this.context = value;

  final HomeController _homeController;
  final FirestoreChatRepository _chatRepository;
  _ChatPetshopControllerBase(this._homeController, this._chatRepository);

  AuthStore get auth => this._homeController.auth;

  AnimationDrawerController get animationDrawer =>
      this._homeController.animationDrawer;

  HomeController get home => this._homeController;

  final _controllerConversation = StreamController<QuerySnapshot>.broadcast();
  StreamController<QuerySnapshot> get conversations => this._controllerConversation;

  void addListenerConversations() {
    //Stream<QuerySnapshot>
    final stream = this._chatRepository.listConversation(
          this.auth.usuario.usuarioInfo.id.toString(),
        );

    stream.listen((dados) {
      if (!_controllerConversation.isClosed) {
        _controllerConversation.add(dados);
      }
    });
  }

  @override
  void dispose() {
    this._controllerConversation.close();
  }
}
