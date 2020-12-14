import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import '../../pet_shop_controller.dart';

part 'aba_conversas_petshop_controller.g.dart';

@Injectable()
class AbaConversasPetshopController = _AbaConversasPetshopControllerBase
    with _$AbaConversasPetshopController;

abstract class _AbaConversasPetshopControllerBase extends Disposable with Store {
  final PetShopController _petShopController;
  final FirestoreChatRepository _chatRepository;
  _AbaConversasPetshopControllerBase(this._petShopController, this._chatRepository);

  AnimationDrawerController get animationDrawer =>
      this._petShopController.animationDrawer;
  AuthStore get auth => this._petShopController.auth;
  UsuarioChatModel get userChat => this.auth.usuarioChat;

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
