import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

import '../../pet_shop_controller.dart';

part 'meus_produtos_controller.g.dart';

@Injectable()
class MeusProdutosController = _MeusProdutosControllerBase
    with _$MeusProdutosController;

abstract class _MeusProdutosControllerBase with Store {
   PetShopController _petShopController;
  _MeusProdutosControllerBase(this._petShopController);

  UsuarioModel get usuario => this._petShopController.usuario;
}
