import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
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

  void _getYearAnimal() {
    if (post.dataNascimento != null) {
      print(post.dataNascimento);
      String dataPost = "";
      List nums = post.dataNascimento.split("/");
      nums.reversed.forEach((n) {
        dataPost += n;
      });
      final dataNow = DateTime.now();
      final dataNasc = DateTime.parse(dataPost);
      int yearDiff = dataNow.year - dataNasc.year;
      int monthDiff = dataNow.month - dataNasc.month;
      int dayDiff = dataNow.day - dataNasc.day;
      String strYear = yearDiff == 0
          ? ""
          : yearDiff.abs() == 1
              ? "${yearDiff.abs()} Ano"
              : "${yearDiff.abs()} Anos";
      String strMonth = "";
      String strDay = "";

      if (monthDiff < 0) {
        if (dayDiff < 0) {
          strMonth = dataNow.month == 1
              ? "${dataNow.month} Mês"
              : "${dataNow.month} Meses";
          yearDiff = yearDiff - 1;
          strYear = yearDiff == 0
              ? ""
              : yearDiff == 1 ? "$yearDiff Ano" : "$yearDiff Anos";
        }
      } else if (monthDiff > 0) {
        strMonth = monthDiff == 1 ? "$monthDiff Mês" : "$monthDiff Meses";
        if (dayDiff < 0) {
          monthDiff = monthDiff - 1;
          strMonth = yearDiff == 0
              ? ""
              : monthDiff == 1 ? "$monthDiff Mês" : "$monthDiff Meses";
        }
      } else {
        if (dayDiff == 0) {
          strDay = "1 dia";
        } else if (dayDiff > 0) {
          strDay = "$dayDiff dias";
        }
      }

      this.idade = strYear + " " + strMonth + " " + strDay;

    } else {
      this.idade = "";
    }
  }

  PostAdocaoModel post;
  UsuarioModel usuario;
  String raca;
  String sexo;
  String idade;
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
    _getYearAnimal();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (widget.isUpd) {
      upd = IconButton(
        icon: Icon(Icons.edit, color: DefaultColors.primary),
        onPressed: () async {
          await Modular.to
              .pushNamed(
            "/home/adocaoUpd",
            arguments: post,
          )
              .then((dynamic adocaoModel) {
            if (adocaoModel != null && (adocaoModel is AdocaoModel)) {
              setState(() {
                post.email = adocaoModel.email;
                post.numeroTelefone = adocaoModel.numeroTelefone;
                post.descricao = adocaoModel.descricao;
              });
            }
          });
        },
      );
    }
    if (widget.isDelete) {
      delete = IconButton(
        icon: Icon(Icons.delete_outline, color: DefaultColors.primary),
        onPressed: widget.onPressedDel,
      );
    }

    if (usuario != null) {
      if (post.idDono != usuario.usuarioInfoModel.id) {
        btnEntrarEmContato = Align(
          alignment: Alignment.center,
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
      child: Column(
        children: [
          Container(
            height: size.height * 0.065,
            margin: EdgeInsets.only(bottom: size.height * 0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close,
                        color: DefaultColors.primary, size: 28),
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
          Container(
            width: size.width,
            height: size.height * 0.30,
            child: Carousel(
              autoplay: false,
              dotSize: 8,
              dotBgColor: Colors.transparent,
              dotColor: Colors.white,
              dotIncreasedColor: DefaultColors.primary,
              images: _getListaImagens(size),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            height: size.height * 0.555,
            child: SingleChildScrollView(
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
                      child: Text(
                          post.descricao.isEmpty ? "..." : post.descricao,
                          style: styleInf),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Divider(color: DefaultColors.primary, height: 3),
                  ),
                  _customContainer(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                              post.dataNascimento != null
                                  ? post.especie + "\n" + raca + "\n" + idade
                                  : post.especie + "\n" + raca,
                              style: styleInf),
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
                  SizedBox(height: size.height * 0.01),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
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
                  Container(
                    padding: EdgeInsets.only(
                        top: size.height * 0.04, bottom: size.height * 0.01),
                    width: size.width,
                    alignment: Alignment.center,
                    child: btnEntrarEmContato,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getListaImagens(Size size) {
    List<String> listUrlImage = post.petImages.listImages;
    return listUrlImage.where((url) => url != "No Photo").map((url) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 4.0, horizontal: size.height * 0.075),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: size.height * 0.25,
            width: size.height * 0.30,
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
