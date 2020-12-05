import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

// ignore: must_be_immutable
class PostProduto extends StatelessWidget {
  Widget typeEntrega = Container();

  final double height;
  final double width;
  final ProdutoModel produtoModel;
  final Function onTap;

  PostProduto({
    this.height,
    this.width,
    this.produtoModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (this.produtoModel.delivery == 1) {
      this.typeEntrega = Expanded(
        child: Container(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/delivery.png",
              width: height * 0.05,
              height: height * 0.05,
            )),
      );
    } else {
      this.typeEntrega = Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  this.produtoModel.endereco,
                  maxLines: 2,
                  style: TextStyle(
                    height: height * 0.0015,
                    color: DefaultColors.secondarySmooth,
                    fontFamily: 'Changa', //GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: height * 0.02,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        height: height * 0.211,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: DefaultColors.backgroundSmooth,
              offset: Offset(3.5, 3.5),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: InkWell(
          onTap: this.onTap,
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              _imagePost(this.produtoModel.imgProd, this.height, this.width),
              SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.only(right: 8),
                width: width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            this.produtoModel.nameProd,
                            style: TextStyle(
                              height: height * 0.0015,

                              color: DefaultColors.secondary,
                              fontFamily:
                                  'Changa', //GoogleFonts.montserrat().fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.032,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "by: " + this.produtoModel.nomeEmpresa,
                            maxLines: 1,
                            style: TextStyle(
                              height: height * 0.0015,

                              color: DefaultColors.secondarySmooth,
                              fontFamily:
                                  'Changa', //GoogleFonts.montserrat().fontFamily,
                              fontWeight: FontWeight.w500,
                              fontSize: height * 0.028,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //? Is Delivery
                    this.typeEntrega,
                    //? Preço
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: Row(
                        mainAxisAlignment: this.produtoModel.desconto != 0.0
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.005),
                              child: Text(
                                "R\$ " + this.produtoModel.price.toString(),
                                textAlign: this.produtoModel.desconto != 0.0
                                    ? TextAlign.start
                                    : TextAlign.end,
                                style: TextStyle(
                                  height: height * 0.001,
                                  color: Colors.grey,
                                  fontFamily:
                                      'Changa', //GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: height * 0.0275,
                                  decoration: this.produtoModel.desconto != 0.0
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (this.produtoModel.desconto != 0.0)
                      //? Desconto
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.005),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "- " +
                                    this.produtoModel.desconto.toString() +
                                    "%",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  height: height * 0.001,

                                  color: DefaultColors.background,
                                  fontFamily:
                                      'Changa', //GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: height * 0.0275,
                                ),
                              ),
                            ),
                            if (this.produtoModel.desconto != 0.0)
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.004),
                                  child: Text(
                                    "  R\$" +
                                        (this.produtoModel.price -
                                                ((this.produtoModel.desconto /
                                                        100) *
                                                    this.produtoModel.price))
                                            .toString(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      height: height * 0.001,

                                      color: DefaultColors.secondary,
                                      fontFamily:
                                          'Changa', //GoogleFonts.montserrat().fontFamily,
                                      fontWeight: FontWeight.w700,
                                      fontSize: height * 0.0275,
                                    ),
                                  ),
                                ),
                              ),
                          ],
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

  Widget _imagePost(String img, double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        img,
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      ),
    );
  }
}
