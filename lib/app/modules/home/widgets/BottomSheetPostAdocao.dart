import 'package:flutter/material.dart';
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
                          height: 50,
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
              height: usuario != null
                  ? size.height * 0.8 - (size.height * 0.4 + 50)
                  : size.height * 0.4,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(post.nome, style: styleInf),
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      Expanded(
                          child: Text(
                              post.especie + " - " + raca + " | " + sexo,
                              style: styleInf)),
                    ]),
                    post.dataNascimento != null
                        ? Row(children: <Widget>[
                            Expanded(
                              child: Text(post.dataNascimento, style: styleInf),
                            ),
                          ])
                        : Container(),
                    Divider(),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(post.descricao, style: styleInf),
                      ),
                    ]),
                    Divider(),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(post.numeroTelefone, style: styleInf),
                      ),
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(post.email, style: styleInf),
                      ),
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text("Data de publicação: " + post.dataRegistro,
                            style: styleInf),
                      ),
                    ]),
                  ],
                ),
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
      return Container(
        margin: const EdgeInsets.all(8.0),
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      );
    }).toList();
  }
}
