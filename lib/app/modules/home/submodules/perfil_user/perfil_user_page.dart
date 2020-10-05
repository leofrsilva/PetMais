import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/pages/show_post_adocao/show_post_adocao_page.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'perfil_user_controller.dart';
import '../../widgets/ImagePet.dart';

class PerfilUserPage extends StatefulWidget {
  final UsuarioModel usuarioModel;
  const PerfilUserPage({this.usuarioModel});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState
    extends ModularState<PerfilUserPage, PerfilUserController> {
  //use 'controller' variable to access controller

  UsuarioModel user;

  @override
  void initState() {
    super.initState();
    user = widget.usuarioModel;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //? -------------------------------
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _headerPerfil(size),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      controller.animationDrawer.isShowDrawer ? 40 : 0)),
              child: Container(
                height: size.height * 0.535,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          controller.animationDrawer.isShowDrawer ? 40 : 0)),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * (0.037),
                        horizontal: 24,
                      ),
                      child: CustomButton(
                        text: "INICIAR CONVERSA",
                        corText: Colors.white,
                        elevation: 0.0,
                        width: size.width * 0.6,
                        decoration: kDecorationContainerGradient,
                        onPressed: () {
                          UsuarioChatModel usuarioChat = UsuarioChatModel(
                            identifier: user.usuarioInfoModel.id,
                            name: user.usuarioInfoModel.nome +
                                " " +
                                user.usuarioInfoModel.sobreNome,
                            image: user.usuarioInfoModel.urlFoto,
                          );
                          controller.changePageConversa();
                          Modular.to.pop();
                          Future.delayed(Duration(milliseconds: 200), () {
                            bool viewed = false;
                            Modular.to.pushNamed("/home/chat/$viewed", arguments: usuarioChat);
                          });

                          // Future.delayed(Duration(milliseconds: 200), (){
                          //   Modular.to.pushNamed("routeName");
                          // });
                          //if (_image != null) {
                          //       UserChat userDestinatario = UserChat();
                          //       userDestinatario.idUser = _user.id;
                          //       userDestinatario.nome = _user.nome;
                          //       userDestinatario.urlImagem = _image;
                          //       Navigator.pushNamed(
                          //         context,
                          //         "/mensagens",
                          //         arguments: [
                          //           widget.usuarioLogado,
                          //           userDestinatario,
                          //           false
                          //         ],
                          //       ).whenComplete((){
                          //         Navigator.pop(context);
                          //       });
                          //     }
                        },
                      ),
                    ),
                    //?-------------------------------------------
                    user != null
                        ? _listPets(user.usuarioInfoModel.id, size)
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerPerfil(Size size) {
    return Observer(
      builder: (BuildContext context) {
        return Container(
          height: size.height * 0.465,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
            ),
          ),
          // Moldura
          child: Stack(
            children: <Widget>[
              Container(
                height: (size.height * 0.465) * 2 / 3,
                width: size.width,
                decoration: BoxDecoration(
                  color: DefaultColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        controller.animationDrawer.isShowDrawer ? 40 : 0),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black26,
                                size: 26,
                              ),
                              onPressed: () {
                                Modular.to.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Divider(color: Colors.white, thickness: 6),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, bottom: 8.0),
                              child: Text(
                                user.usuarioInfoModel.nome,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Changa",
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 150,
                  width: size.width / 2 + 50,
                  padding: const EdgeInsets.only(right: 4.0, top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _info(
                        user.usuarioInfoModel.numeroTelefone,
                        Icon(
                          Icons.phone,
                          color: Colors.black26,
                        ),
                      ),
                      _info(
                        user.email,
                        Icon(
                          Icons.email,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Photo
              Align(
                alignment: Alignment.bottomLeft,
                child: _photoPerfil(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _info(String text, Icon icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.end,
            style: kDescriptionStyle,
          ),
        ),
        icon == null
            ? null
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: icon,
              ),
      ],
    );
  }

  Widget _photoPerfil() {
    final moldePhoto = Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: Container(
        width: 175,
        height: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DefaultColors.others.withOpacity(0.5),
              offset: Offset(3.0, 3.0),
              blurRadius: 3.0,
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
          color: DefaultColors.others,
        ),
        child: user.usuarioInfoModel.urlFoto == "No Photo"
            ? Icon(
                Icons.person,
                size: 60,
                color: Colors.white.withOpacity(0.5),
              )
            : ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                child: Image.network(
                  user.usuarioInfoModel.urlFoto,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
    return moldePhoto;
  }

  Widget _listPets(int id, Size size) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.04,
            margin: EdgeInsets.only(
              top: size.height * 0.0075,
              bottom: size.height * 0.0075,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: DefaultColors.primary, width: 5),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.pets, color: DefaultColors.primary),
                SizedBox(width: 6),
                Text(
                  "Pets em Adoção",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: DefaultColors.primary,
                    fontFamily:
                        'OpenSans', //GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.3,
            alignment: Alignment.center,
            child: FutureBuilder<List<PostAdocaoModel>>(
              future: controller.recuperarPets(this.user.usuarioInfoModel.id),
              builder: (context, snapshot) {
                Widget defaultWidget;
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    List<PostAdocaoModel> listPets = snapshot.data;
                    if (listPets.length > 0) {
                      defaultWidget = ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: GridView.builder(
                            itemCount: listPets?.length ?? 0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.1,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                            ),
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 8.0),
                            itemBuilder: (_, int index) {
                              PostAdocaoModel pet = listPets[index];
                              return ImagePet(
                                size: size.height * 0.25,
                                urlImage: pet.petImages.imgPrincipal,                                
                                onTap: () async {
                                  await Modular.to.showDialog(
                                    builder: (context) {
                                      return Center(
                                        child: ShowPostAdocaoPage(
                                          postAdotation: pet,
                                          usuarioModel:
                                              controller.usuario ?? null,
                                        ),
                                      );
                                    },
                                  ).then((value){
                                    if(value){
                                      UsuarioChatModel usuarioChat = UsuarioChatModel(
                                        identifier: user.usuarioInfoModel.id,
                                        name: user.usuarioInfoModel.nome +
                                            " " +
                                            user.usuarioInfoModel.sobreNome,
                                        image: user.usuarioInfoModel.urlFoto,
                                      );
                                      controller.changePageConversa();
                                      Modular.to.pop();
                                      Future.delayed(Duration(milliseconds: 200), () {
                                        bool viewed = false;
                                        Modular.to.pushNamed("/home/chat/$viewed", arguments: usuarioChat);
                                      });
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      defaultWidget = ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text(
                            "Nenhum Pet para Adoção!",
                            style: TextStyle(
                              color: DefaultColors.background,
                              fontSize: 16,
                              fontFamily: "Changa",
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    defaultWidget = ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "Erro na Conexão",
                          style: TextStyle(
                            color: DefaultColors.error,
                            fontSize: 16,
                            fontFamily: "Changa",
                          ),
                        ),
                      ),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  defaultWidget = Center(
                    child: Container(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            DefaultColors.secondary),
                      ),
                    ),
                  );
                } else {
                  defaultWidget = Container();
                }
                return defaultWidget;
              },
            ),
          ),
        ],
      ),
    );
  }
}
