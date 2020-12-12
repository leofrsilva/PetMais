import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

// ignore: must_be_immutable
class PostProdutoPetShop extends StatelessWidget {
  final double height;
  final double width;
  final ProdutoModel produtoModel;
  final Function onTap;

  PostProdutoPetShop({
    this.height,
    this.width,
    this.produtoModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height * 0.255,
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
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: _imagePost(
                    this.produtoModel.imgProd, this.height, this.width),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  width: width * 0.55,
                  height: height * 0.211,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      //? Nome do Produto
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
                      //? Categoria
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              this.produtoModel.categoria,
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
                      //? Quantidade
                      Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(vertical:  height * 0.0075),
                        decoration: BoxDecoration(
                          color: DefaultColors.backgroundSmooth,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                " Quantidade: " +
                                    this.produtoModel.estoque.toString(),
                                maxLines: 1,
                                style: TextStyle(
                                  height: height * 0.003,
                                  color: Colors.white,
                                  fontFamily:
                                      'Changa', //GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontSize: height * 0.0245,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //? Preço
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.005),
                                child: Text(
                                  "R\$ " + this.produtoModel.price.toStringAsFixed(2).replaceFirst(".", ","),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    height: height * 0.0015,
                                    color: DefaultColors.background,
                                    fontFamily:
                                        'Changa', //GoogleFonts.montserrat().fontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.0275,
                                    decoration:
                                        this.produtoModel.desconto != 0.0
                                            ? TextDecoration.lineThrough
                                            : null,
                                  ),
                                ),
                              ),
                            ),
                            if (this.produtoModel.desconto != 0.0)
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.005),
                                  child: Text(
                                    "R\$" +
                                        (this.produtoModel.price -
                                                ((this.produtoModel.desconto /
                                                        100) *
                                                    this.produtoModel.price))
                                            .toStringAsFixed(2).replaceFirst(".", ","),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      height: height * 0.0015,
                                      color: DefaultColors.background,
                                      fontFamily:
                                          'Changa', //GoogleFonts.montserrat().fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: height * 0.0275,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      //? Desconto
                      Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(vertical:  height * 0.0075),
                        decoration: BoxDecoration(
                          color: DefaultColors.backgroundSmooth,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Desconto: " +
                                    this.produtoModel.desconto.toStringAsFixed(2).replaceFirst(".", ",") +
                                    "%",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  height: height * 0.003,

                                  color: Colors.white,
                                  fontFamily:
                                      'Changa', //GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: height * 0.0245,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   // padding: EdgeInsets.symmetric(vertical:  height * 0.0075),
                      //   decoration: BoxDecoration(
                      //     color: DefaultColors.background,
                      //     borderRadius: BorderRadius.only(
                      //       topRight: Radius.circular(20),
                      //       bottomRight: Radius.circular(20),
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: <Widget>[
                      //       Expanded(
                      //         child: Text(
                      //           "Desconto: " +
                      //               this.produtoModel. +
                      //               "%",
                      //           textAlign: TextAlign.start,
                      //           style: TextStyle(
                      //             height: height * 0.003,

                      //             color: Colors.white,
                      //             fontFamily:
                      //                 'Changa', //GoogleFonts.montserrat().fontFamily,
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: height * 0.0245,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: width * 0.55,
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(bottom: height * 0.005),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        this.produtoModel.delivery == 1
                            ? Icons.check_box
                            : Icons.block,
                        color: DefaultColors.secondarySmooth,
                      ),
                      Text(
                        " Delivery",
                        style: TextStyle(
                          height: height * 0.0025,

                          color: DefaultColors.background,
                          fontFamily:
                              'Changa', //GoogleFonts.montserrat().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: height * 0.032,
                        ),
                      ),
                    ],
                  ),
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
        width: width * 0.35,
        height: width * 0.35,
      ),
    );
  }
}
