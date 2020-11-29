import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/chat/models/message/message_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final UsuarioChatModel usuarioContact;
  final bool viewed;
  // final String nomePet;
  // final String urlFotoPet;
  ChatPage({this.usuarioContact, this.viewed});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.usuarioContact = widget.usuarioContact;
    controller.setViewed(widget.viewed);
    controller.addListenerIsOnline();
    controller.addListenerMessages();
    controller.isNewMessage();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black26,
        ),
        title: Row(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey.withOpacity(0.5),
              backgroundImage: controller.usuarioContact.image != "No Photo"
                  ? NetworkImage(controller.usuarioContact.image)
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: size.width * 0.6,
                    child: Text(
                      controller.usuarioContact.name,
                      maxLines: 1,
                      style: TextStyle(
                        color: DefaultColors.secondary,
                        fontSize: 20,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  // StreamBuilder<DocumentSnapshot>(
                  //   stream: controller.isOnline.stream,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.active) {
                  //       if (snapshot.hasError) {
                  //         return Container();
                  //       } else if (snapshot != null && snapshot.data != null) {
                  //         DocumentSnapshot user = snapshot.data;
                  //         bool status = user["status"];
                  //         if (status == true) {
                  //           return Text(
                  //             "Online",
                  //             textAlign: TextAlign.start,
                  //             style: TextStyle(
                  //                 fontSize: 12, color: Colors.black26),
                  //           );
                  //         } else {
                  //           return Container();
                  //         }
                  //       }
                  //     }
                  //     return Container();
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundChat.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _streamBuilder(),
                _boxMessages(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _streamBuilder() {
    return StreamBuilder(
      stream: controller.listMessage.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Expanded(
              child: Center(
                child: Text(
                  "Erro ao carregar Mensagens!",
                  style: TextStyle(
                    color: DefaultColors.error,
                    fontFamily: "Changa",
                  ),
                ),
              ),
            );
          } else {
            QuerySnapshot querySnapshot = snapshot.data;
            return Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  reverse: true,
                  controller: controller.scrollController,
                  child: Column(
                    children: querySnapshot.docs.map((msg) {
                      MessageModel message = MessageModel.fromJson(msg.data());
                      //Define cores e alinhamentos
                      AlignmentDirectional alignment =
                          AlignmentDirectional.centerEnd;
                      Color cor = DefaultColors.secondary;
                      if (controller.usuario.id !=
                          int.tryParse(message.idUsuario)) {
                        cor = Colors.orangeAccent;
                        alignment = AlignmentDirectional.centerStart;
                        controller.isNewMessage(isOnlineInChat: true);
                      }
                      //Definindo largura máxima
                      double widthContianer =
                          MediaQuery.of(context).size.width * 0.8;

                      return Align(
                        alignment: alignment,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Container(
                            width: message.type != "text"
                                ? MediaQuery.of(context).size.width * 0.7
                                : null,
                            height: message.type != "text"
                                ? MediaQuery.of(context).size.width * 0.7
                                : null,
                            constraints: BoxConstraints(
                              maxWidth: widthContianer,
                            ),
                            padding:
                                EdgeInsets.all(message.type == "text" ? 16 : 6),
                            decoration: BoxDecoration(
                              color: cor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: message.type == "text"
                                ? Text(
                                    message.message,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )
                                : Image.network(
                                    message.message,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }
        } else {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  DefaultColors.secondary,
                ),
              ),
            ),
          );
        }
      },
    );
    // return Observer(builder: (context) {
    //   return Expanded(
    //     child: Container(
    //       alignment: Alignment.topCenter,
    //       child: SingleChildScrollView(
    //         reverse: true,
    //         controller: controller.scrollController,
    //         child: Column(
    //           children: controller.listMsg.map((msg) {
    //             //Define cores e alinhamentos
    //             AlignmentDirectional alignment = AlignmentDirectional.centerEnd;
    //             Color cor = DefaultColors.secondary;
    //             if (controller.usuario.id != msg.idUser) {
    //               cor = Colors.orangeAccent;
    //               alignment = AlignmentDirectional.centerStart;
    //               // _isNewMessage(isOnlineInChat: true); //! Message Visualizada
    //             }
    //             //Definindo largura máxima
    //             double widthContianer = MediaQuery.of(context).size.width * 0.8;

    //             return Align(
    //               alignment: alignment,
    //               child: Padding(
    //                 padding: EdgeInsets.all(6),
    //                 child: Container(
    //                   width: msg.type != "text"
    //                       ? MediaQuery.of(context).size.width * 0.7
    //                       : null,
    //                   height: msg.type != "text"
    //                       ? MediaQuery.of(context).size.width * 0.7
    //                       : null,
    //                   constraints: BoxConstraints(
    //                     maxWidth: widthContianer,
    //                   ),
    //                   padding: EdgeInsets.all(msg.type == "text" ? 16 : 6),
    //                   decoration: BoxDecoration(
    //                     color: cor,
    //                     borderRadius: BorderRadius.all(Radius.circular(8)),
    //                   ),
    //                   child: msg.type == "text"
    //                       ? Text(
    //                           msg.text,
    //                           style:
    //                               TextStyle(fontSize: 18, color: Colors.white),
    //                         )
    //                       : Image.network(
    //                           msg.text,
    //                           fit: BoxFit.cover,
    //                         ),
    //                 ),
    //               ),
    //             );
    //           }).toList(),
    //         ),
    //       ),
    //     ),
    //   );
    // });
  }

  Widget _boxMessages() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: DefaultColors.primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Observer(builder: (_) {
                        return Container(
                          child: controller.isLoading
                              ? Container(
                                  padding: EdgeInsets.only(left: 15),
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        DefaultColors.primary),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.only(left: 15),
                                  width: 30,
                                  height: 30,
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 18.0,
                                      color: DefaultColors.primary,
                                    ),
                                    onPressed: () {
                                      controller.setSelectedImage(true);
                                    },
                                  ),
                                ),
                        );
                      }),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: TextField(
                            controller: controller.messageController,
                            autofocus: false,
                            focusNode: controller.focusMessage,
                            autocorrect: false,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                              hintText: "Digite uma mensagem",
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Observer(builder: (context) {
                    bool selectedImage = controller.isSelectedImage;
                    return selectedImage
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_left,
                                    size: 34,
                                    color: DefaultColors.primary,
                                  ),
                                  onPressed: () {
                                    controller.setSelectedImage(false);
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Câmera",
                                    style: kFlatButtonStyle,
                                  ),
                                  onPressed: () {
                                    controller.captureFoto("camera");
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Galeria",
                                    style: kFlatButtonStyle,
                                  ),
                                  onPressed: () {
                                    controller.captureFoto("galeria");
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container();
                  }),
                ],
              ),
            ),
          ),
          Platform.isIOS
              ? CupertinoButton(
                  child: Text(
                    "Enviar",
                    style: TextStyle(
                      color: DefaultColors.primary,
                      fontFamily: "RussoOne",
                    ),
                  ),
                  onPressed: controller.sendMessageText,
                )
              : FloatingActionButton(
                  child: Icon(Icons.send, color: Colors.white),
                  backgroundColor: DefaultColors.primary,
                  mini: true,
                  onPressed: controller.sendMessageText,
                ),
        ],
      ),
    );
  }
}
