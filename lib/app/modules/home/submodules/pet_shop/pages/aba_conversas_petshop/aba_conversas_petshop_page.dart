import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/adocao/models/conversation/conversation_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'aba_conversas_petshop_controller.dart';

class AbaConversasPetshopPage extends StatefulWidget {
  final String title;
  const AbaConversasPetshopPage({Key key, this.title = "AbaConversasPetshop"})
      : super(key: key);

  @override
  _AbaConversasPetshopPageState createState() =>
      _AbaConversasPetshopPageState();
}

class _AbaConversasPetshopPageState extends ModularState<
    AbaConversasPetshopPage, AbaConversasPetshopController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.addListenerConversations();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(builder: (_) {
      return ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft:
              Radius.circular(controller.animationDrawer.isShowDrawer ? 40 : 0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
      stream: controller.conversations.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  DefaultColors.background,
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              "Erro ao carregar os dados!",
              style: TextStyle(
                color: DefaultColors.error,
                fontFamily: "Changa",
              ),
            ));
          } else {
            QuerySnapshot querySnapshot = snapshot.data;
            if (querySnapshot.docs.length == 0) {
              return Center(
                child: Text(
                  "Você não tem nenhuma mensagem ainda :( ",
                  style: TextStyle(
                    color: DefaultColors.background,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: querySnapshot.docs.length,
              itemBuilder: (context, index) {
                List<DocumentSnapshot> conversas = querySnapshot.docs.toList();
                DocumentSnapshot item = conversas[index];
                ConversationModel conversation =
                    ConversationModel.fromMap(item.data());

                if (conversation.idDestinatario == null &&
                    conversas.length == 1) {
                  return Container(
                    height: size.height * 0.8,
                    child: Center(
                      child: Text(
                        "Você não tem nenhuma mensagem ainda :( ",
                        style: TextStyle(
                          color: DefaultColors.background,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                if (conversation.idDestinatario == null || conversation.isShop == false) {
                  return Container();
                }               

                UsuarioChatModel userChat = UsuarioChatModel(
                  identifier: int.tryParse(conversation.idDestinatario),
                  name: conversation.nome,
                  image: conversation.imgUser,
                  isShop: true,
                );

                return ListTile(
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey[400],
                    backgroundImage: conversation.imgUser != "No Photo"
                        ? NetworkImage(conversation.imgUser)
                        : null,
                  ),
                  title: Text(
                    conversation.nome,
                    style: TextStyle(
                      color: DefaultColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: conversation.type == "text"
                      ? Text(
                          conversation.message,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        )
                      : Row(
                          children: <Widget>[
                            Icon(Icons.image, color: Colors.grey, size: 18),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Text(
                                "Foto",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                  onTap: () {
                    //Abrir tela de mensagens
                    String nome = "Null";
                    String url = "Null";
                    Modular.to.pushNamed(
                        "/home/chat/${conversation.viewed}/$nome/$url",
                        arguments: userChat);
                  },
                  trailing: conversation.viewed == true
                      ? Container(
                          width: 10,
                          height: 10,
                        )
                      : Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: DefaultColors.background,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                );
              },
            );
          }
        } else {
          return Container();
        }
      },
    ),
        ),
      );
    });
  }
}
