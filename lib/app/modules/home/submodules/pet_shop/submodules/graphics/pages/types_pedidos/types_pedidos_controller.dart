import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:petmais/app/modules/home/submodules/pet_shop/submodules/graphics/widgets/Indicator.dart';
import '../../graphics_controller.dart';

part 'types_pedidos_controller.g.dart';

@Injectable()
class TypesPedidosController = _TypesPedidosControllerBase
    with _$TypesPedidosController;

abstract class _TypesPedidosControllerBase with Store {
  GraphicsController _graphicsController;
  _TypesPedidosControllerBase(this._graphicsController);

  @observable
  int touchedIndex;

  @action
  setTouchedIndex(int value) => this.touchedIndex = value;

  Future<List<Map<String, dynamic>>> getListTypesPedidos() async {
    return await _graphicsController.getTypesPedidos();
  }
}
