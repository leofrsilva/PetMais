import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/modules/home/widgets/carousel/carousel_pro.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';

class BottomSheetPostAdocao extends StatefulWidget {
  final PostAdocaoModel postAdotation;
  final UsuarioModel usuarioModel;
  final bool isUpd;
  final bool isDelete;
  final Function onPressedUpd;
  final Function onPressedDel;
  BottomSheetPostAdocao({
    this.postAdotation,
    this.usuarioModel,
    this.isUpd = false,
    this.isDelete = false,
    this.onPressedUpd,
    this.onPressedDel,
  });

  @override
  _BottomSheetPostAdocaoState createState() => _BottomSheetPostAdocaoState();
}

class _BottomSheetPostAdocaoState extends State<BottomSheetPostAdocao> {
  final TextStyle styleInf = TextStyle(
    color: DefaultColors.secondarySmooth,
    fontFamily: "Changa",
    fontSize: 16,
  );

  final TextStyle styleInfAux = TextStyle(
    color: Colors.white,
    fontFamily: "Changa",
    fontSize: 16,
  );

  PostAdocaoModel post;
  UsuarioModel usuario;
  String raca;
  String sexo;
  Widget upd = Container();
  Widget delete = Container();
  Widget btnEntrarEmContato = Container();

  @override
  void initState() {
    super.initState();
    post = widget.postAdotation;
    usuario = widget.usuarioModel ?? null;
    raca = post.raca != null ? post.raca : " Raça não Informada";
    sexo = post.sexo == "M" ? "Macho" : "Fêmea";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (widget.isUpd) {
      upd = IconButton(
        icon: Icon(Icons.edit, color: Colors.white),
        onPressed: widget.onPressedUpd,
      );
    }
    if (widget.isDelete) {
      delete = IconButton(
        icon: Icon(Icons.delete_outline, color: Colors.white),
        onPressed: widget.onPressedDel,
      );
    }

    if (usuario != null) {
      if (post.idDono != usuario.usuarioInfoModel.id) {
        btnEntrarEmContato = Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomButton(
            text: "ENTRAR EM CONTATO",
            corText: Colors.white,
            elevation: 0.0,
            width: size.width * 0.75,
            decoration: kDecorationContainerGradient,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        );
      }
    }

    return Container(
      height: size.height * 0.955,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: size.height * 0.07,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            post.nome,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w500,
                              fontFamily: "OpenSans",
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.black26),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              this.upd,
                              this.delete,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.4,
              child: Carousel(
                autoplay: false,
                dotSize: 8,
                dotBgColor: Colors.transparent,
                dotColor: Colors.white,
                dotIncreasedColor: DefaultColors.primary,
                images: _getListaImagens(),
              ),
            ),
            Container(
              // height: usuario != null
              //     ? size.height * 0.8 - (size.height * 0.4 + 50)
              //     : size.height * 0.4,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          post.nome,
                          style: TextStyle(
                            color: DefaultColors.secondary,
                            fontSize: 18,
                            fontFamily: "RussoOne",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: Text(post.descricao, style: styleInf),
                    ),
                  ]),
                  Divider(color: DefaultColors.primary, height: 3),
                  _customContainer(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child:
                              Text(post.especie + "\n" + raca, style: styleInf),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(
                            sexo == "Macho"
                                ? FontAwesomeIcons.mars
                                : FontAwesomeIcons.venus,
                            color: DefaultColors.secondary,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  post.dataNascimento != null
                      ? Row(children: <Widget>[
                          Expanded(
                            child: Text(post.dataNascimento, style: styleInf),
                          ),
                        ])
                      : Container(),
                  Divider(color: DefaultColors.primary, height: 3),
                  //* Info Contato Dono
                  _customContainer(
                    child: Column(
                      children: [
                        Row(children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 6.0),
                            child: Icon(
                              FontAwesomeIcons.phoneSquare,
                              color: DefaultColors.secondary,
                              size: 22,
                            ),
                          ),
                          Expanded(
                            child: Text(post.numeroTelefone, style: styleInf),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4.0, right: 6.0),
                            child: Icon(
                              FontAwesomeIcons.at,
                              color: DefaultColors.secondary,
                              size: 22,
                            ),
                          ),
                          Expanded(
                            child: Text(post.email, style: styleInf),
                          ),
                        ]),
                        Row(children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                post.dataRegistro,
                                textAlign: TextAlign.end,
                                style: styleInf,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            btnEntrarEmContato,
          ],
        ),
      ),
    );
  }

  List<Widget> _getListaImagens() {
    List<String> listUrlImage = post.petImages.listImages;
    return listUrlImage.where((url) => url != "No Photo").map((url) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _customContainer({Widget child}) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        top: 4.0,
        bottom: 4.0,
      ),
      decoration: BoxDecoration(
        color: DefaultColors.secondarySmooth.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
