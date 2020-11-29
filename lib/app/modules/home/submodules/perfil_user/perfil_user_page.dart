import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/pages/show_post_adocao/show_post_adocao_page.dart';
import 'package:petmais/app/modules/home/widgets/BottomSheetPostAdocao.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
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
                height: size.height * 0.575,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          controller.animationDrawer.isShowDrawer ? 40 : 0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                  child: Text(
                                    (user.usuarioInfo as UsuarioInfoJuridicoModel)
                                        .descricao,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: DefaultColors.secondarySmooth,
                                      fontFamily: "Changa",
                                      height: size.height * 0.00185,
                                      fontSize: size.height * 0.0275,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CustomButton(
                            text: "INICIAR CONVERSA",
                            corText: Colors.white,
                            elevation: 0.0,
                            width: size.width * 0.7,
                            decoration: kDecorationContainerGradient,
                            onPressed: () {
                              UsuarioChatModel usuarioChat = UsuarioChatModel(
                                identifier: user.usuarioInfo.id,
                                name: user.usuarioInfo is UsuarioInfoModel
                                    ? (user.usuarioInfo as UsuarioInfoModel)
                                            .nome +
                                        " " +
                                        (user.usuarioInfo as UsuarioInfoModel)
                                            .sobreNome
                                    : (user.usuarioInfo
                                            as UsuarioInfoJuridicoModel)
                                        .nomeOrg,
                                image: user.usuarioInfo.urlFoto,
                              );
                              controller.changePageConversa();
                              Modular.to.pop();
                              Future.delayed(Duration(milliseconds: 200), () {
                                bool viewed = false;
                                Modular.to.pushNamed("/home/chat/$viewed",
                                    arguments: usuarioChat);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    //?-------------------------------------------
                    user != null
                        ? _listPets(user.usuarioInfo.id, size)
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
          height: size.height * 0.44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                  controller.animationDrawer.isShowDrawer ? 40 : 0),
            ),
          ),
          // Moldura
          child: Stack(
            children: <Widget>[
              Container(
                height: (size.height * 0.42) * 2 / 3,
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
                          SizedBox(height: size.height * 0.035),
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
                    if (user.usuarioInfo is UsuarioInfoJuridicoModel)
                      Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.055),
                            Padding(
                              padding: const EdgeInsets.only(right: 7.0),
                              child: Image.asset(
                                "assets/images/ong.png",
                                width: 70,
                                height: 70,
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
                            Container(
                              width: size.width * 0.5,
                              padding: const EdgeInsets.only(
                                  right: 16.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      user.usuarioInfo is UsuarioInfoModel
                                          ? (user.usuarioInfo
                                                  as UsuarioInfoModel)
                                              .nome
                                          : (user.usuarioInfo
                                                  as UsuarioInfoJuridicoModel)
                                              .nomeOrg,
                                      maxLines: 2,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        height: size.height * 0.0022,
                                        color: Colors.white,
                                        fontFamily: "Changa",
                                        fontSize: size.height * 0.03,
                                      ),
                                    ),
                                  ),
                                ],
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
                        user.usuarioInfo is UsuarioInfoModel
                            ? (user.usuarioInfo as UsuarioInfoModel)
                                .numeroTelefone
                            : (user.usuarioInfo as UsuarioInfoJuridicoModel)
                                .telefone1,
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
        width: 155,
        height: 155,
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
        child: user.usuarioInfo.urlFoto == "No Photo"
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
                  user.usuarioInfo.urlFoto,
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
            height: size.height * 0.0395,
            margin: EdgeInsets.only(
              top: size.height * 0.0055,
              bottom: size.height * 0.0085,
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
            height: size.height * 0.255,
            alignment: Alignment.center,
            child: FutureBuilder<List<PostAdocaoModel>>(
              future: controller.recuperarPets(
                this.user.usuarioInfo.id,
                this.user.usuarioInfo,
              ),
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
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 12,
                            ),
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 6.0),
                            itemBuilder: (_, int index) {
                              PostAdocaoModel pet = listPets[index];
                              return ImagePet(
                                size: size.height * 0.175,
                                urlImage: pet.petImages.imgPrincipal,
                                onTap: () async {
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
                                        postAdotation: pet,
                                        usuarioModel:
                                            controller.usuario ?? null,
                                      );
                                    },
                                  ).then((value) {
                                    if (value) {
                                      UsuarioChatModel usuarioChat =
                                          UsuarioChatModel(
                                        identifier: user.usuarioInfo.id,
                                        name: user.usuarioInfo
                                                is UsuarioInfoModel
                                            ? (user.usuarioInfo
                                                        as UsuarioInfoModel)
                                                    .nome +
                                                " " +
                                                (user.usuarioInfo
                                                        as UsuarioInfoModel)
                                                    .sobreNome
                                            : (user.usuarioInfo
                                                    as UsuarioInfoJuridicoModel)
                                                .nomeOrg,
                                        image: user.usuarioInfo.urlFoto,
                                      );
                                      controller.changePageConversa();
                                      Modular.to.pop();
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        bool viewed = false;
                                        Modular.to.pushNamed(
                                            "/home/chat/$viewed",
                                            arguments: usuarioChat);
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
