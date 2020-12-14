import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/submodules/produto/pages/update_produto/update_produto_page.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'produto_controller.dart';

class ProdutoPage extends StatefulWidget {
  final ProdutoModel produto;
  final int showPerfil;
  const ProdutoPage({this.produto, this.showPerfil});

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends ModularState<ProdutoPage, ProdutoController>
    with SingleTickerProviderStateMixin {
  //use 'controller' variable to access controller

  AnimationController animationController;

  Widget typeProd;
  ProdutoModel produto;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationController.addListener(() {
      setState(() {});
    });

    animationController.forward();

    this.produto = widget.produto;
    this.produto.imgProd = "http:" + this.produto.imgProd.split("http:").last;
    this.produto.imgShop = "http:" + this.produto.imgShop.split("http:").last;
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;

    if (controller.usuario.isPetShop) {
      typeProd = painelProdutoForShop();
    } else {
      typeProd = painelProduto(size);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height * 0.955,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                    Rect.fromLTWH(
                      0,
                      size.height,
                      size.width,
                      size.height * 0.955,
                    ),
                    size),
                end: RelativeRect.fromSize(
                    Rect.fromLTWH(
                      0,
                      0,
                      size.width,
                      size.height + 150,
                    ),
                    size),
              ).animate(CurvedAnimation(
                parent: animationController,
                curve: Curves.easeIn,
              )),
              child: typeProd,
            ),
          ],
        ),
      ),
    );
  }

  Widget painelProdutoForShop() {
    return UpdateProdutoPage(produtoModel: this.produto);
  }

  Widget painelProduto(Size size) {
    String tel = "";
    if (this.produto.telefone != null) {
      tel += this.produto.telefone;
    }
    if (this.produto.telefone2 != null) {
      if (this.produto.telefone != null) tel += "\n";
      tel += this.produto.telefone2;
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
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
                        color: DefaultColors.tertiary, size: 28),
                    onPressed: () {
                      Modular.to.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.315,
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.32,
                        width: size.width * 0.48,
                        margin: EdgeInsets.all(size.height * 0.01),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3,
                            ),
                          ],
                          image: DecorationImage(
                            image: NetworkImage(this.produto.imgProd),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.32,
                        width: size.width * 0.48,
                        padding: EdgeInsets.only(left: size.height * 0.0075),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    this.produto.categoria,
                                    maxLines: 1,
                                    style: TextStyle(
                                      height: size.height * 0.002,
                                      fontFamily: "Changa",
                                      color: DefaultColors.backgroundSmooth,
                                      fontSize: size.height * 0.035,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    this.produto.nameProd,
                                    maxLines: 1,
                                    style: TextStyle(
                                      height: size.height * 0.0015,
                                      fontFamily: "Changa",
                                      color: DefaultColors.background,
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.height * 0.04,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.015),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    this.produto.descricao,
                                    maxLines: 3,
                                    style: TextStyle(
                                      height: size.height * 0.0015,
                                      fontFamily: "Changa",
                                      color: DefaultColors.backgroundSmooth,
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.height * 0.0275,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.025),
                              child: Text(
                                "R\$ " +
                                    this
                                        .produto
                                        .price
                                        .toStringAsFixed(2)
                                        .replaceFirst(".", ","),
                                textAlign: this.produto.desconto != 0.0
                                    ? TextAlign.start
                                    : TextAlign.end,
                                style: TextStyle(
                                  height: size.height * 0.001,
                                  color: Colors.grey,
                                  fontFamily:
                                      'Changa', //GoogleFonts.montserrat().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.0275,
                                  decoration: this.produto.desconto != 0.0
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                            if (this.produto.desconto != 0.0)
                              //? Desconto
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.005),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "- " +
                                            this
                                                .produto
                                                .desconto
                                                .toStringAsFixed(2)
                                                .replaceFirst(".", ",") +
                                            "%",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          height: size.height * 0.001,

                                          color: DefaultColors.background,
                                          fontFamily:
                                              'Changa', //GoogleFonts.montserrat().fontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: size.height * 0.0275,
                                        ),
                                      ),
                                    ),
                                    if (this.produto.desconto != 0.0)
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height * 0.004),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "R\$" +
                                                (this.produto.price -
                                                        ((this
                                                                    .produto
                                                                    .desconto /
                                                                100) *
                                                            this.produto.price))
                                                    .toStringAsFixed(2)
                                                    .replaceFirst(".", ","),
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              height: size.height * 0.001,

                                              color: DefaultColors.secondary,
                                              fontFamily:
                                                  'Changa', //GoogleFonts.montserrat().fontFamily,
                                              fontWeight: FontWeight.w700,
                                              fontSize: size.height * 0.0275,
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
                //* Separção
                Container(
                  height: size.height * 0.065,
                  alignment: Alignment.center,
                  child: Text(
                    "Vendidos por",
                    style: TextStyle(
                      fontFamily: "Changa",
                      fontSize: size.height * 0.035,
                      fontWeight: FontWeight.w600,
                      color: DefaultColors.background,
                    ),
                  ),
                ),
                //* Info PetShop
                Container(
                  width: size.width,
                  height: size.height * 0.37,
                  child: Row(
                    children: [
                      //* Info
                      Container(
                        height: size.height * 0.34,
                        width: size.width * 0.5,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.0125),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    this.produto.endereco,
                                    maxLines: 2,
                                    style: TextStyle(
                                      height: size.height * 0.002,
                                      fontFamily: "Changa",
                                      color: DefaultColors.background,
                                      fontWeight: FontWeight.w700,
                                      fontSize: size.height * 0.025,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    tel,
                                    maxLines: 2,
                                    style: TextStyle(
                                      height: size.height * 0.002,
                                      fontFamily: "Changa",
                                      color: DefaultColors.background,
                                      fontSize: size.height * 0.025,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                            Container(
                              color: DefaultColors.backgroundSmooth,
                              padding: EdgeInsets.all(size.height * 0.01),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      this.produto.descricaoPetShop,
                                      maxLines: 4,
                                      style: TextStyle(
                                        height: size.height * 0.002,
                                        fontFamily: "Changa",
                                        color: DefaultColors.tertiary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.height * 0.025,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //* Nome Empresa | Imagem PetShop
                      Container(
                        height: size.height * 0.34,
                        width: size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              decoration: BoxDecoration(
                                color: DefaultColors.backgroundSmooth,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      this.produto.nomeEmpresa,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: size.height * 0.002,
                                        fontFamily: "Changa",
                                        color: Colors.white,
                                        fontSize: size.height * 0.028,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.showPerfil == 1) Modular.to.pop(3);
                              },
                              child: Container(
                                height: size.height * 0.2,
                                width: size.width * 0.425,
                                margin: EdgeInsets.all(size.height * 0.01),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 3,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(this.produto.imgShop),
                                    fit: BoxFit.cover,
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
                SizedBox(height: size.height * 0.015),
                Container(
                  height: size.height * 0.075,
                  width: size.width,
                  child: this.produto.delivery == 0
                      ? CustomButtonOutline(
                          width: size.width * 0.95,
                          text: "Gerar código de retirada",
                          corText: DefaultColors.tertiary,
                          decoration: BoxDecoration(
                            color: DefaultColors.background,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: DefaultColors.tertiary,
                              width: 2,
                            ),
                          ),
                          onPressed: () {
                            controller.gerarCodigoDeRetirada(
                                this.produto, size);
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButtonOutline(
                              width: size.width * 0.45,
                              text: "Fazer Pedido",
                              icon: Container(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.0085),
                                child: Image.asset(
                                  "assets/images/delivery.png",
                                  width: size.height * 0.04,
                                  height: size.height * 0.04,
                                ),
                              ),
                              fontsize: size.height * 0.02,
                              corText: DefaultColors.background,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: DefaultColors.background,
                                  width: 2,
                                ),
                              ),
                              onPressed: () {
                                controller.fazerPedido(this.produto, size);
                              },
                            ),
                            SizedBox(width: size.width * 0.025),
                            CustomButtonOutline(
                              width: size.width * 0.45,
                              text: "Código de retirada",
                              fontsize: size.height * 0.0185,
                              corText: DefaultColors.tertiary,
                              decoration: BoxDecoration(
                                color: DefaultColors.background,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: DefaultColors.tertiary,
                                  width: 2,
                                ),
                              ),
                              onPressed: () {
                                controller.gerarCodigoDeRetirada(
                                    this.produto, size);
                              },
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
