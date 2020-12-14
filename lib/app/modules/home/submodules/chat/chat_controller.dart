import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmais/app/modules/home/repository/hasura_chat/firestore_chat_repository.dart';
import 'package:petmais/app/modules/home/submodules/adocao/models/conversation/conversation_model.dart';
import 'package:petmais/app/modules/home/submodules/chat/models/message/message_model.dart';
import 'package:petmais/app/modules/home/submodules/chat/utils/date_now.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';
import 'package:http_parser/http_parser.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

part 'chat_controller.g.dart';

class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase extends Disposable with Store {
  final _picker = ImagePicker();
  final AuthStore _authStore;
  final FirestoreChatRepository _chatRepository;
  _ChatControllerBase(this._authStore, this._chatRepository) {
    scrollController = ScrollController();
    messageController = TextEditingController();
    focusMessage = FocusNode();
  }

  ScrollController scrollController;
  TextEditingController messageController;
  FocusNode focusMessage;

  UsuarioChatModel get usuarioChat => _authStore.usuarioChat;
  UsuarioModel get usuario => _authStore.usuario;

  UsuarioChatModel _userContact;
  set userContact(UsuarioChatModel value) => this._userContact = value;
  UsuarioChatModel get userContact => this._userContact;

  // Visualizado
  bool _viewed;
  bool get viewed => this._viewed;
  setViewed(bool value) => this._viewed = value;

  Future isNewMessage({bool isOnlineInChat}) async {
    if (this.viewed == false) {
      await this._chatRepository.setViewed(
            true,
            this.usuarioChat.id.toString(),
            this.userContact.id.toString(),
          );
    } else if (isOnlineInChat != null) {
      if (isOnlineInChat = true) {
        await this._chatRepository.setViewed(
              true,
              this.usuarioChat.id.toString(),
              this.userContact.id.toString(),
            );
      }
    }
  }

  final _controllerListMessage = StreamController<QuerySnapshot>.broadcast();
  StreamController<QuerySnapshot> get listMessage =>
      this._controllerListMessage;
  final _controllerIsOnline = StreamController<DocumentSnapshot>.broadcast();
  StreamController<DocumentSnapshot> get isOnline => this._controllerIsOnline;

  //* ----------------------------------------------------------------
  //* List Message
  void addListenerMessages() async {
    //Stream<QuerySnapshot>
    try {
      final stream = this._chatRepository.listMessage(
            this.usuarioChat.id.toString(),
            this.userContact.id.toString(),
          );

      stream.listen((dados) {
        if (!_controllerListMessage.isClosed) {
          _controllerListMessage.add(dados);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  //* ----------------------------------------------------------------
  //* Check Online
  void addListenerIsOnline() {
    try {
      //Stream<QuerySnapshot>
      final stream = this._chatRepository.checkStatus(
            this.userContact.id.toString(),
          );
      stream.listen((dados) {
        if (!_controllerIsOnline.isClosed) {
          _controllerIsOnline.add(dados);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  //?----------------------------------------------
  //? Enviar Mensagem
  Future sendMessageText({String msg, Timestamp data}) async {
    String textMessage = msg ?? this.messageController.text.trim();
    if (textMessage.isNotEmpty) {
      this.messageController.clear();
      MessageModel message = MessageModel(
        idUsuario: this.usuarioChat.id.toString(),
        type: "text",
        message: textMessage,
      );
      message.data = data != null ? data : await DateNow.getDate();
      // message.data = Timestamp.now();
      //Salvando menssagem para o Remetente
      _saveMessage(this.usuarioChat.id.toString(),
          this.userContact.id.toString(), message);
      //Salvando menssagem para o Destinatário
      _saveMessage(this.userContact.id.toString(),
          this.usuarioChat.id.toString(), message);

      _salvarConversa(message);
    }
  }

  Future _saveMessage(
      String idRemetente, String idDestinatario, MessageModel msg) async {
    await this._chatRepository.sendMessage(idRemetente, idDestinatario, msg);
  }

  Future _salvarConversa(MessageModel msg) async {
    bool shop = this.userContact.isPetshop != null
        ? this.userContact.isPetshop == true
            ? true
            : false
        : false;
    if (shop == false) {
      if (this.usuario.isPetShop != null) {
        if (this.usuario.isPetShop) {
          shop = true;
        }
      }
    }
    ConversationModel cRemetente = ConversationModel(
      idRemetente: this.usuarioChat.id.toString(),
      idDestinatario: this.userContact.id.toString(),
      nome: this.userContact.name,
      imgUser: this.userContact.image,
      type: msg.type,
      message: msg.message,
      viewed: true,
      shop: shop,
    );
    this._chatRepository.addConversation(cRemetente);

    ConversationModel cDestinatario = ConversationModel(
      idRemetente: this.userContact.id.toString(),
      idDestinatario: this.usuarioChat.id.toString(),
      nome: this.usuarioChat.name,
      imgUser: this.usuarioChat.image,
      type: msg.type,
      message: msg.message,
      viewed: false,
      shop: shop,
    );
    this._chatRepository.addConversation(cDestinatario);
  }

  //? ---------------------------------------------
  //? Loading
  @observable
  bool isLoading = false;

  @action
  setLoading(bool value) => this.isLoading = value;

  //? ---------------------------------------------
  //? Loading Image
  @observable
  bool isSelectedImage = false;

  @action
  setSelectedImage(bool value) => this.isSelectedImage = value;

  Future captureFoto(String op) async {
    PickedFile imageSelected;
    if (op == "camera") {
      imageSelected = await _picker.getImage(source: ImageSource.camera);
    } else if (op == "galeria") {
      imageSelected = await _picker.getImage(source: ImageSource.gallery);
    }
    this.setSelectedImage(false);
    if (imageSelected != null) {
      File img = File(imageSelected.path);
      File auxImage = await ImageCropper.cropImage(
          sourcePath: img.path,
          compressQuality: 95,
          cropStyle: CropStyle.rectangle,
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
      this.setLoading(true);
      _sendImage(auxImage);
    }
  }

  Future _sendImage(File fileImage) async {
    try {
      if (fileImage == null) {
        return;
      }
      Directory tempDir = await getTemporaryDirectory();
      String path = tempDir.path;
      //? String title = _titleController.text;
      String rand = DateTime.now().millisecondsSinceEpoch.toString();
      // Img.Image image = Img.decodeImage(fileImage.readAsBytesSync());
      // Img.Image smallerImg = Img.copyResize(image, width: 500);

      File compressImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(fileImage.readAsBytesSync().toList());

      if (compressImg != null) {
        String urlImage = UsuarioRemoteRepository.URL +
            "/files/" +
            "images/chat/${compressImg.path.split('/').last}";
        await uploadImgChat(compressImg).then((String result) async {
          print(result);
          await sendImage(urlImage).then((_) {
            this.setLoading(false);
          });
        });
      } else {
        this.setLoading(false);
      }
    } catch (e) {
      this.setLoading(false);
      print(e);
    }
  }

  // ignore: missing_return
  Future<Timestamp> sendImage(String urlImage) async {
    String textMessage = urlImage;
    if (textMessage.isNotEmpty) {
      MessageModel message = MessageModel(
        idUsuario: this.usuarioChat.id.toString(),
        type: "image",
        message: textMessage,
      );
      message.data = await DateNow.getDate();
      // message.data = Timestamp.now();
      //Salvando menssagem para o Remetente
      _saveMessage(this.usuarioChat.id.toString(),
          this.userContact.id.toString(), message);
      //Salvando menssagem para o Destinatário
      _saveMessage(this.userContact.id.toString(),
          this.usuarioChat.id.toString(), message);

      _salvarConversa(message);
      return message.data;
    }
  }

  //? -------------------------------------------------------
  //? Upload Image Chat
  Future<String> uploadImgChat(File img) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/uploads/uploadImageChat.php";
    FormData file = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        img.path,
        filename: img.path.split("/").last,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    try {
      Response response = await dio.post(link, data: file);
      if (response.statusCode == 200) {
        return "Enviado";
      } else {
        return "Falha no Envio";
      }
    } catch (e) {
      print(e);
      return "Falha no Envio";
    }
  }

  @override
  void dispose() {
    _controllerListMessage.close();
    _controllerIsOnline.close();
    messageController.dispose();
    focusMessage.dispose();
  }
}
