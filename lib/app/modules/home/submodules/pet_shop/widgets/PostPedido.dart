import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/pedido/pedido_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class PostPedido extends StatelessWidget {
  final PedidoModel pedido;
  final double height;
  final Function onTap;

  PostPedido(
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
            height: height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: DefaultColors.tertiary,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(height * 0.02),
                  height: height * 0.12,
                  width: height * 0.12,
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
                      //* Endereço
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              this.pedido.tipo == "retirada"
                                  ? this.pedido.enderecoPetshop
                                  : "by: " + this.pedido.nomePetshop,
                              maxLines: 3,
                              style: TextStyle(
                                height: height * 0.0015,
                                fontFamily: "Changa",
                                fontSize: height * 0.0225,
                                color: DefaultColors.backgroundSmooth,
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
                              this.pedido.formatarData(this.pedido.dataPedido),
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(height * 0.02),
                  height: height * 0.14,
                  width: height * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //* Preço Total
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "R\$" +
                                  this
                                      .pedido
                                      .total
                                      .toStringAsFixed(2)
                                      .replaceFirst(".", ","),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: height * 0.0015,
                                fontFamily: "Changa",
                                fontSize: height * 0.030,
                                fontWeight: FontWeight.w600,
                                color: DefaultColors.backgroundSmooth,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //* Código de Retirada
                      if (this.pedido.tipo == "retirada")
                        Container(
                          height: height * 0.05,
                          width: height * 0.15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: DefaultColors.backgroundSmooth,
                            borderRadius: BorderRadius.circular(5),
                          ),
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
                      //* Estado de Entreda
                      if (this.pedido.tipo != "retirada")
                      
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                this.pedido.estado,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: height * 0.0015,
                                  fontFamily: "Changa",
                                  fontSize: pedido.estado == "Entregue"
                                      ? height * 0.031
                                      : height * 0.030,
                                  fontWeight: pedido.estado == "Entregue"
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: pedido.estado == "Cancelado"
                                      ? Colors.redAccent
                                      : DefaultColors.secondary,
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
          ),
          if (this.pedido.emProducao == 0)
            Container(
              height: height * 0.15,
              // width: double.finite,
              width: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Text(
                "Produto Excluido",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Changa",
                  color: Colors.redAccent,
                  fontSize: height * 0.04,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
