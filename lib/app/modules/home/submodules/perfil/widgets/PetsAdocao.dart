import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class PetsAdocao extends StatelessWidget {
  final PostAdocaoModel adocaoModel;
  final double height;
  final Size size;

  const PetsAdocao({
    this.adocaoModel,
    this.size,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: this.height,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(size.height * 0.035),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          adocaoModel.nome,
                          maxLines: 1,
                          style: TextStyle(
                            height: size.height * 0.002,
                            color: DefaultColors.secondary,
                            fontFamily: "Changa",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          adocaoModel.especie,
                          maxLines: 1,
                          style: TextStyle(
                            height: size.height * 0.002,
                            color: DefaultColors.background,
                            fontFamily: "Changa",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          adocaoModel.raca,
                          maxLines: 2,
                          style: TextStyle(
                            height: size.height * 0.002,
                            color: DefaultColors.secondary,
                            fontFamily: "Changa",
                            fontSize: size.height * 0.025,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                       Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      adocaoModel.especie == "Cachorro"
                          ? FontAwesomeIcons.dog
                          : FontAwesomeIcons.cat,
                          color: DefaultColors.background,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                      Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(
                          adocaoModel.sexo == "M"
                              ? FontAwesomeIcons.mars
                              : FontAwesomeIcons.venus,
                              color: DefaultColors.background,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: size.height * 0.248,
                width: size.height * 0.248,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: NetworkImage(adocaoModel.petImages.imgPrincipal),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: DefaultColors.secondary,
                      blurRadius: 1,
                      offset: Offset(2, 2),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
