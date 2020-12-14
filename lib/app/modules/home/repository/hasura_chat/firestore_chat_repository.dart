import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:petmais/app/modules/home/submodules/adocao/models/conversation/conversation_model.dart';
import 'package:petmais/app/modules/home/submodules/chat/models/message/message_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

const HASURA_URL =
    "https://br-potatocompany-chat-petmais.herokuapp.com/v1/graphql";

class FirestoreChatRepository {
  // ignore: unused_field
  FirebaseApp _connection;

  FirebaseFirestore _firestore;
  FirebaseFirestore get store => this._firestore;

  FirestoreChatRepository() {
    init();
  }

  Future init() async {
    this._connection = await Firebase.initializeApp();
    this._firestore = FirebaseFirestore.instance;
  }

  Future setOnline(UsuarioChatModel usuario, bool status) async {
    usuario.status = status;
    await store
        .collection("usuarios")
        .doc(usuario.id.toString())
        .set(usuario.toMap(), SetOptions(merge: true));
  }

  Future<UsuarioChatModel> updateInfoUser(UsuarioModel usuario) async {
    UsuarioChatModel usuarioChat = UsuarioChatModel(
      identifier: usuario.usuarioInfo.id,
      name: usuario.usuarioInfo is UsuarioInfoModel
          ? (usuario.usuarioInfo as UsuarioInfoModel).nome +
              " " +
              (usuario.usuarioInfo as UsuarioInfoModel).sobreNome
          : (usuario.usuarioInfo as UsuarioInfoJuridicoModel).nomeOrg,
      image: usuario.usuarioInfo is UsuarioInfoModel
          ? (usuario.usuarioInfo as UsuarioInfoModel).urlFoto
          : (usuario.usuarioInfo as UsuarioInfoJuridicoModel).urlFoto,
      status: true,
    );
    if (this._connection == null) {
      await init().then((_) async {
        await store
            .collection("usuarios")
            .doc(usuarioChat.id.toString())
            .set(usuarioChat.toMap(), SetOptions(merge: true));
      });
    } else {
      await store
          .collection("usuarios")
          .doc(usuarioChat.id.toString())
          .set(usuarioChat.toMap(), SetOptions(merge: true));
    }
    return usuarioChat;
  }

  //* List Conversation
  Stream<QuerySnapshot> listConversation(String identifir) {
    return store
        .collection("conversas")
        .doc(identifir)
        .collection("ultima_conversa")
        .snapshots();
  }

  //* Verificar Status
  Stream checkStatus(String identifir) {
    return store.collection("usuarios").doc(identifir).snapshots();
  }

  //* Lista de Mensagem
  Stream<QuerySnapshot> listMessage(String idUser, String idUserConcat) {
    return store
        .collection("mensagens")
        .doc(idUser)
        .collection(idUserConcat)
        .orderBy("data", descending: false)
        .snapshots();
  }

  //* Set Viewed
  Future setViewed(bool view, String idUser, String idUserConcat) async {
    await store
        .collection("conversas")
        .doc(idUser)
        .collection("ultima_conversa")
        .doc(idUserConcat)
        .set({"viewed": true}, SetOptions(merge: true));
  }

  //* ----------------------------------------------------------------------
  //* Adicionar Conversation
  Future addConversation(
    ConversationModel conversation,
  ) async {
    /*
        + conversas
          + Leonardo
            + ultima_conversa
              + Marcelo
                <...>
                idRe
                idDes
                ...
    */
    await store
        .collection("conversas")
        .doc(conversation.idRemetente)
        .collection("ultima_conversa")
        .doc(conversation.idDestinatario)
        .set(conversation.toJson());
  }

  // Send Message
  Future<String> sendMessage(
      String idRemetente, String idDestinatario, MessageModel msg) async {
    await store
        .collection("mensagens")
        .doc(idRemetente)
        .collection(idDestinatario)
        .add(msg.toJson());
    /*
    *  + mensagens
    *    + Leonardo - ID
    *      + Marcelo - ID
    *        + IdentificadorFirebase
    ?          <Mensagem>
    **/
  }
}
