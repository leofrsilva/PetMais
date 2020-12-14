import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'graphics_controller.dart';
import 'pages/types_pedidos/types_pedidos_page.dart';
import 'pages/quantidade_por_estado/quantidade_por_estado_page.dart';

class GraphicsPage extends StatefulWidget {
  final String title;
  const GraphicsPage({Key key, this.title = "Graphics"}) : super(key: key);

  @override
  _GraphicsPageState createState() => _GraphicsPageState();
}

class _GraphicsPageState
    extends ModularState<GraphicsPage, GraphicsController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                        controller.animationDrawer.isShowDrawer ? 40 : 0)),
          child: Container(
                    height: size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              controller.animationDrawer.isShowDrawer ? 40 : 0)),
                    ),
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              TypesPedidosPage(),
              QuantidadePorEstadoPage(),
            ],
          ),
        ),
    );
  }
}
