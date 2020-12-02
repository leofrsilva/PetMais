import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/adocao/models/conversation/conversation_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';

import 'aba_conversa_controller.dart';

class AbaConversaPage extends StatefulWidget {
  @override
  _AbaConversaPageState createState() => _AbaConversaPageState();
}

class _AbaConversaPageState
    extends ModularState<AbaConversaPage, AbaConversaController> {
  Widget noLogado(Size size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Necessario está Logado!",
            style: kLabelStyle,
          ),
          SizedBox(height: 15),
          CustomButton(
            text: "LOGAR",
            onPressed: controller.logar,
            elevation: 0.0,
            width: size.width * 0.5,
            decoration: kDecorationContainerGradient,
          ),
        ],
      ),
    );
  }

  Widget logado() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.conversations.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  DefaultColors.secondary,
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

                if (conversation.idDestinatario == null) {
                  return Container();
                }

                UsuarioChatModel userChat = UsuarioChatModel(
                  identifier: int.tryParse(conversation.idDestinatario),
                  name: conversation.nome,
                  image: conversation.imgUser,
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
    );
    // return StreamBuilder<List<ConversationModel>>(
    //   stream: null,
    //   builder: (context, snapshot) {
    //     return StreamBuilder<List<ConversationModel>>(
    //       stream: null,
    //       builder: (context, snapshot) {
    //         switch (snapshot.connectionState) {
    //           case ConnectionState.none:
    //           case ConnectionState.waiting:
    //             return Center(
    //               child: Column(
    //                 children: <Widget>[
    //                   Padding(
    //                     padding: const EdgeInsets.all(16.0),
    //                     child: CircularProgressIndicator(
    //                       valueColor:
    //                           AlwaysStoppedAnimation<Color>(Colors.green),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             );
    //             break;
    //           case ConnectionState.active:
    //           case ConnectionState.done:
    //             if (snapshot.hasError) {
    //               return Center(child: Text("Erro ao carregar os dados!"));
    //             } else {
    //               QuerySnapshot querySnapshot = snapshot.data;
    //               if (querySnapshot.documents.length == 0) {
    //                 return Center(
    //                   child: Text(
    //                     "Você não tem nenhuma mensagem ainda :( ",
    //                     style: TextStyle(
    //                       fontSize: 18.0,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 );
    //               }
    //               return ListView.builder(
    //                 itemCount: querySnapshot.documents.length,
    //                 itemBuilder: (context, index) {
    //                   List<DocumentSnapshot> conversas =
    //                       querySnapshot.documents.toList();
    //                   DocumentSnapshot item = conversas[index];

    //                   String urlImage = item["caminhoFoto"];
    //                   String tipo = item["tipoMensagem"];
    //                   String mensagem = item["mensagem"];
    //                   String nome = item["nome"];
    //                   String idDestinatario = item["idDestinatario"];
    //                   bool visualizado = item["visualizado"];

    //                   if (idDestinatario == null) {
    //                     return Container();
    //                   }

    //                   UserChat usuario = UserChat();
    //                   usuario.idUser = int.tryParse(idDestinatario);
    //                   usuario.nome = nome;
    //                   usuario.urlImagem = urlImage;

    //                   return ListTile(
    //                     contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    //                     leading: CircleAvatar(
    //                       maxRadius: 30,
    //                       backgroundColor: Colors.grey,
    //                       backgroundImage: urlImage != null
    //                           ? MemoryImage(
    //                               Uint8List.fromList(urlImage.codeUnits))
    //                           : null,
    //                     ),
    //                     title: Text(
    //                       nome,
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 16,
    //                       ),
    //                     ),
    //                     subtitle: tipo == "texto"
    //                         ? Text(
    //                             mensagem,
    //                             style: TextStyle(
    //                               color: Colors.grey,
    //                               fontSize: 14,
    //                             ),
    //                           )
    //                         : Row(
    //                             children: <Widget>[
    //                               Icon(Icons.image,
    //                                   color: Colors.grey, size: 18),
    //                               Padding(
    //                                 padding: const EdgeInsets.only(left: 6.0),
    //                                 child: Text(
    //                                   "Foto",
    //                                   style: TextStyle(
    //                                     color: Colors.grey,
    //                                     fontSize: 14,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                     onTap: () {
    //                       //Abrir tela de mensagens
    //                       Navigator.pushNamed(
    //                         context,
    //                         "/mensagens",
    //                         arguments: [_userChat, usuario, visualizado],
    //                       );
    //                     },
    //                     trailing: visualizado == true
    //                         ? Container(
    //                             width: 10,
    //                             height: 10,
    //                           )
    //                         : Container(
    //                             width: 10,
    //                             height: 10,
    //                             decoration: BoxDecoration(
    //                               color: DefaultColors.secondary,
    //                               borderRadius: BorderRadius.circular(100),
    //                             ),
    //                           ),
    //                   );
    //                 },
    //               );
    //             }
    //             break;
    //         }
    //       },
    //     );
    //   },
    // );
  }

  @override
  void initState() {
    super.initState();
    if (controller.auth.isLogged) controller.addListenerConversations();
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
          child: controller.auth.isLogged ? logado() : noLogado(size),
        ),
      );
    });
  }
}
