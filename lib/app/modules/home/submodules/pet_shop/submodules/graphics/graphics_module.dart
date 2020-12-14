import 'graphics_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../home_controller.dart';
import 'pages/types_pedidos/types_pedidos_controller.dart';
import 'pages/quantidade_por_estado/quantidade_por_estado_controller.dart';

import 'graphics_page.dart';

class GraphicsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => GraphicsController(i.get<HomeController>())),
        Bind((i) => TypesPedidosController(i.get<GraphicsController>())),
        Bind((i) => QuantidadePorEstadoController(i.get<GraphicsController>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => GraphicsPage()),
      ];

  static Inject get to => Inject<GraphicsModule>.of();
}
