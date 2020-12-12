import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/pedido/pedido_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class PostPedidoPetShop extends StatelessWidget {
  final PedidoModel pedido;
  final double height;
  final Function onTap;

  PostPedidoPetShop(
    this.pedido,
    this.height,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Stack(
        children: [
          Container(
            height: height * 0.3,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: DefaultColors.tertiary,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(height * 0.02),
                      height: height * 0.18,
                      width: height * 0.18,
                      decoration: BoxDecoration(
                        color: DefaultColors.secondarySmooth,
                        image: DecorationImage(
                          image: NetworkImage(this.pedido.imagemProduto),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //* Nome do Produto
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  this.pedido.nomeProduto,
                                  maxLines: 1,
                                  style: TextStyle(
                                    height: height * 0.0015,
                                    fontFamily: "Changa",
                                    fontSize: height * 0.025,
                                    color: DefaultColors.background,
                                  ),
                                ),
                              )
                            ],
                          ),
                          //* Data do Pedido
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  this
                                      .pedido
                                      .formatarData(this.pedido.dataPedido),
                                  maxLines: 1,
                                  style: TextStyle(
                                    height: height * 0.0015,
                                    fontFamily: "Changa",
                                    fontSize: height * 0.025,
                                    color: Colors.black26,
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (this.pedido.tipo != "retirada")
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        "assets/images/delivery.png",
                                        width: height * 0.05,
                                        height: height * 0.05,
                                      )),
                                )
                              ],
                            ),
                          if (this.pedido.emProducao == 0)
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    this.pedido.tipo != "retirada"
                                        ? "Produto fora de Produção"
                                        : "\nProduto fora de Produção",
                                    maxLines: 3,
                                    style: TextStyle(
                                      height: height * 0.0015,
                                      fontFamily: "Changa",
                                      fontSize: height * 0.025,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(height * 0.02),
                      height: height * 0.18,
                      width: height * 0.20,
                      decoration: BoxDecoration(
                          // color: DefaultColors.secondarySmooth,
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: DefaultColors.background,
                            child: Row(
                              children: [
                                SizedBox(width: height * 0.005),
                                Expanded(
                                  child: Text(
                                    "Quantidade: " +
                                        this.pedido.quantidade.toString(),
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: "Changa",
                                      fontSize: height * 0.025,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(width: height * 0.005),
                              Expanded(
                                child: Text(
                                  this.pedido.tipo == "retirada"
                                      ? "Total: R\$" +
                                          this
                                              .pedido
                                              .total
                                              .toStringAsFixed(2)
                                              .replaceFirst(".", ",")
                                      : "Total: R\$" +
                                          this
                                              .pedido
                                              .valorEntrega
                                              .toStringAsFixed(2)
                                              .replaceFirst(".", ","),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    height: height * 0.0015,
                                    fontFamily: "Changa",
                                    fontSize: height * 0.025,
                                    fontWeight: FontWeight.w600,
                                    color: DefaultColors.backgroundSmooth,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (this.pedido.tipo == "retirada")
                            Container(
                              color: DefaultColors.backgroundSmooth,
                              height: height * 0.05,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      this.pedido.codigo.toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Changa",
                                        fontSize: height * 0.030,
                                        fontWeight: FontWeight.w600,
                                        color: DefaultColors.tertiary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (this.pedido.tipo != "retirada")
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(pedido.estado == "Entregue" ? 
                                   height * 0.004 : height * 0.003,),
                                   decoration: BoxDecoration(
                                    color: pedido.estado == "Cancelado" ? Colors.redAccent : DefaultColors.secondary,
                                    borderRadius: BorderRadius.circular(pedido.estado == "Entregue" ? 50 : 5),
                                   ),
                                    child: Text(
                                      this.pedido.estado,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // height: height * 0.0015,
                                        fontFamily: "Changa",
                                        fontSize: pedido.estado == "Entregue" ? height * 0.031 : height * 0.030,
                                        fontWeight: pedido.estado == "Entregue" ? FontWeight.w700 : FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: height * 0.075,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          this.pedido.tipo == "retirada"
                              ? "Local de Retirada: "
                              : "Local do Cliente: ",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: height * 0.0015,
                            color: DefaultColors.backgroundSmooth,
                            fontFamily: "Changa",
                            fontWeight: FontWeight.w700,
                            fontSize: height * 0.025,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          this.pedido.tipo == "retirada"
                              ? this.pedido.enderecoPetshop
                              : this.pedido.endereco,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: height * 0.0015,
                            color: DefaultColors.backgroundSmooth,
                            fontFamily: "Changa",
                            fontSize: height * 0.025,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (this.pedido.emProducao == 0)
            Container(
              height: height * 0.3,
              width: double.infinity,
              color: Colors.black12,
            ),
        ],
      ),
    );
  }
}
