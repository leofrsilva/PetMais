import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

class PostAdotation extends StatelessWidget {
  final Function onTap;
  final PostAdocaoModel postAdotationModel;

  PostAdotation({
    this.onTap,
    this.postAdotationModel,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String sexo = postAdotationModel.sexo == "M" ? "Macho" : "Fêmea";
    return Material(
      child: Container(
        height: size.height * 0.211,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DefaultColors.primarySmooth,
              offset: Offset(3.5, 3.5),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: InkWell(
          onTap: this.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: <Widget>[
              _imagePost(postAdotationModel.petImages.imgPrincipal),
              SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.only(right: 8),
                width: size.width - 194,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            postAdotationModel.nome,
                            style: kLabelTitleStyle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            postAdotationModel.raca != "null"
                                ? postAdotationModel.especie +
                                    " - " + 
                                    postAdotationModel.raca +
                                    "\n" +
                                    sexo
                                : postAdotationModel.especie + " | " + sexo,
                            style: TextStyle(
                              fontSize: 12,
                              color: DefaultColors.secondarySmooth,
                              fontFamily: "Changa",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            postAdotationModel.descricao,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black26,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Text(
                        postAdotationModel.dataRegistro,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "RussoOne",
                          color: DefaultColors.secondarySmooth,
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
    );
  }

  Widget _imagePost(String url) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: DefaultColors.others.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
