import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/widgets/PostPedido.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/widgets/PostPedidoPetShop.dart';
import 'package:petmais/app/shared/models/pedido/pedido_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'pedidos_controller.dart';

class PedidosPage extends StatefulWidget {
  final String title;
  const PedidosPage({Key key, this.title = "Pedidos"}) : super(key: key);

  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends ModularState<PedidosPage, PedidosController> {
  //use 'controller' variable to access controller

  Future<void> onRefreshPed() async {
    setState(() {
      controller.recuperarPedidos();
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    controller.setUpdatePedidos(this.onRefreshPed);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: DefaultColors.secondary,
      body: Observer(builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
                controller.animationDrawer.isShowDrawer ? 40 : 0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                    controller.animationDrawer.isShowDrawer ? 40 : 0),
              ),
            ),
            child: FutureBuilder(
              future: controller.recuperarPedidos(),
              builder: (context, snapshot) {
                Widget defaultWidget;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  defaultWidget = Container(
                    height: size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            DefaultColors.background),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    List<PedidoModel> ped = snapshot.data;
                    if (ped.length > 0) {
                      defaultWidget = Observer(builder: (context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              controller.animationDrawer.isShowDrawer ? 40 : 0,
                            ),
                          ),
                          child: Container(
                            height: size.height,
                            padding: EdgeInsets.only(top: size.height * 0.0193),
                            child: RefreshIndicator(
                              color: DefaultColors.background,
                              onRefresh: this.onRefreshPed,
                              child: ScrollConfiguration(
                                behavior: NoGlowBehavior(),
                                child: ListView(
                                  children: ped.map((pedido) {
                                    if (controller.usuario.isPetShop) {
                                      return PostPedidoPetShop(
                                        pedido,
                                        size.height,
                                        () {
                                          controller.showPedidoForPetshop(
                                              pedido, size);
                                        },
                                      );
                                    } else {
                                      return PostPedido(pedido, size.height,
                                          () {
                                        controller.showPedido(
                                              pedido, size);
                                      },);
                                    }
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    } else {
                      defaultWidget = Container(
                        height: size.height,
                        child: Center(
                          child: Text(
                            "Nenhum pedido declarado :(",
                            style: TextStyle(
                              color: DefaultColors.background,
                              fontSize: 16,
                              fontFamily: "Changa",
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    defaultWidget = Container(
                      height: size.height,
                      child: Center(
                        child: Text(
                          "Erro na Conexão",
                          style: TextStyle(
                            color: DefaultColors.error,
                            fontSize: 16,
                            fontFamily: "Changa",
                          ),
                        ),
                      ),
                    );
                  }
                }
                return defaultWidget;
              },
            ),
          ),
        );
      }),
    );
  }
}
