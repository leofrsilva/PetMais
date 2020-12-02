import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

import '../../pet_shop_controller.dart';

part 'pedidos_controller.g.dart';

@Injectable()
class PedidosController = _PedidosControllerBase with _$PedidosController;

abstract class _PedidosControllerBase with Store {
  PetShopController _petShopController;
  _PedidosControllerBase(this._petShopController);

  UsuarioModel get usuario => this._petShopController.usuario;
}
