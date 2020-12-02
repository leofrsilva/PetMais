import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

part 'add_produto_controller.g.dart';

@Injectable()
class AddProdutoController = _AddProdutoControllerBase
    with _$AddProdutoController;

abstract class _AddProdutoControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final _picker = ImagePicker();
  HomeController _homeController;
  _AddProdutoControllerBase(this._homeController);

  UsuarioModel get usuario => this._homeController.auth.usuario;

  @override
  void dispose() {

  }
}
