import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../graphics_controller.dart';


part 'quantidade_por_estado_controller.g.dart';

@Injectable()
class QuantidadePorEstadoController = _QuantidadePorEstadoControllerBase
    with _$QuantidadePorEstadoController;

abstract class _QuantidadePorEstadoControllerBase with Store {
  GraphicsController _graphicsController;
  _QuantidadePorEstadoControllerBase(this._graphicsController);

  @observable
  int touchedIndex;

  @action
  setTouchedIndex(int value) => this.touchedIndex = value;

  Future<List<Map<String, dynamic>>> getListQuantEstados() async {
    return await _graphicsController.getQuantidadesPorEstado();
  }
}
