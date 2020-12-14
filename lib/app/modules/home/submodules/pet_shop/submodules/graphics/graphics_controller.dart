import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import '../../../../home_controller.dart';

part 'graphics_controller.g.dart';

@Injectable()
class GraphicsController = _GraphicsControllerBase with _$GraphicsController;

abstract class _GraphicsControllerBase with Store {
  HomeController _homeController;
  _GraphicsControllerBase(this._homeController);

  HomeController get home => this._homeController;
  UsuarioModel get usuario => this.home.auth.usuario;
  UsuarioInfoJuridicoModel get usuarioInfo =>
      (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel);
  AnimationDrawerController get animationDrawer => this.home.animationDrawer;

  Future<List<Map<String, dynamic>>> getTypesPedidos() async {
    final dio = Modular.get<Dio>();
    String link = "/functions/reports/typesPedidos.php";
    FormData formData =
        FormData.fromMap({"petshopId": this.usuario.usuarioInfo.id});

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        return listResults(response.data.trim());
      } else {
        return [
          {"Result": "Falha na Conexão"}
        ];
      }
    } catch (e) {
      print(e);
      return [
        {"Result": "Falha na Conexão"}
      ];
    }
  }

  Future<List<Map<String, dynamic>>> getQuantidadesPorEstado() async {
    final dio = Modular.get<Dio>();
    String link = "/functions/reports/quantEstado.php";
    FormData formData =
        FormData.fromMap({"petshopId": this.usuario.usuarioInfo.id});

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        return listResults(response.data.trim());
      } else {
        return [
          {"Result": "Falha na Conexão"}
        ];
      }
    } catch (e) {
      print(e);
      return [
        {"Result": "Falha na Conexão"}
      ];
    }
  }

  List<Map<String, dynamic>> listResults(String results) {
    List<Map<String, dynamic>> list = [];
    List<String> adocaosJosn = results.split("|");
    for (int i = 0; i < adocaosJosn.length - 1; i++) {
      list.add(json.decode(adocaosJosn[i]));
    }
    return list;
  }
}
