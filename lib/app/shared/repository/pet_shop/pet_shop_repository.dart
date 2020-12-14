import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/pedido/pedido_model.dart';

class PetShopRepository {
  static final PetShopRepository _petHelper = PetShopRepository._internal();

  factory PetShopRepository() {
    return _petHelper;
  }
  PetShopRepository._internal();

  //* Cadastro de Produto
  Future<Map<String, dynamic>> registerProduto(
    ProdutoModel prod, {
    bool loading,
  }) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/registrations/registroProduto.php";
    print(prod.toMapRegistrer());
    FormData formData = FormData.fromMap(prod.toMapRegistrer());

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (loading) Modular.to.pop();
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
      if (loading) Modular.to.pop();
      return {"Result": "Falha na Conexão"};
    }
  }

  //* Update de Produto
  Future<Map<String, dynamic>> updateProduto(ProdutoModel prod) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/updates/updateProduto.php";
    FormData formData = FormData.fromMap(prod.toMapUpdate());

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
      return {"Result": "Falha na Conexão"};
    }
  }

  //* Delete Imagem
  Future<Map<String, dynamic>> deleteProduto(int id) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/exclusions/deleteProduto.php";
    Map<String, dynamic> map = {"id": id.toString()};
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
      return {"Result": "Falha na Conexão"};
    }
  }

  //* Upload de Image do Produto
  Future<Map<String, dynamic>> uploadImageProduto(File image, bool loading,
      {String imgDepreciada}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/uploads/uploadImagemProduto.php";
    Map<String, dynamic> map = {
      "imgDepreciada": imgDepreciada,
      "image": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split("/").last,
        contentType: MediaType('image', 'jpeg'),
      ),
    };
    FormData file = FormData.fromMap(map);

    try {
      Response response = await dio.post(link, data: file);
      if (loading) Modular.to.pop();
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha no Envio"};
      }
    } catch (e) {
      print(e);
      if (loading) Modular.to.pop();
      return {"Result": "Falha no Envio"};
    }
  }

  //* ----------------------------------------------------------------------
  List<ProdutoModel> listResults(String results) {
    List<ProdutoModel> list = [];
    List<String> petsJosn = results.split("|");
    for (int i = 0; i < petsJosn.length - 1; i++) {
      ProdutoModel usuario = ProdutoModel.fromMap(json.decode(petsJosn[i]));
      list.add(usuario);
    }
    return list;
  }

  //* List Produtos PetShop
  Future<List<ProdutoModel>> listProdPetShop({
    int idPetShop,
    String categoria,
    String nameProd,
    String namePetShop,
  }) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listProdutos.php";
    Map<String, dynamic> map = {};
    if (idPetShop != null && idPetShop != 0) {
      map["petshopId"] = idPetShop;
    }
    if (categoria != null && categoria.isNotEmpty) {
      map["categoria"] = categoria.trim();
    }
    if (nameProd != null && nameProd.isNotEmpty) {
      map["nomeProduto"] = nameProd.trim();
    }
    if (namePetShop != null && namePetShop.isNotEmpty) {
      map["petshop"] = namePetShop.trim();
    }
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String record = response.data.trimLeft();
        if (record == "Not Found Produtos") {
          return [];
        } else {
          List<ProdutoModel> prods = listResults(response.data);
          prods.sort((a, b) {
            return DateTime.tryParse(a.dataRegistro)
                .compareTo(DateTime.tryParse(b.dataRegistro));
          });
          return prods.reversed.toList();
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //* List Pedidos PetShop
  Future<List<PedidoModel>> listPedidos({
    int idPetShop,
    int idUserComum,
  }) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listPedidos.php";
    Map<String, dynamic> map = {};
    if (idPetShop != null && idPetShop != 0) {
      map["petshopId"] = idPetShop;
    } else if (idUserComum != null && idUserComum != 0) {
      map["idUserComum"] = idUserComum;
    }
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String record = response.data.trimLeft();
        if (record == "Not Found Pedidos") {
          return [];
        } else {
          List<PedidoModel> pedidos = listResultsPedidos(response.data);
          pedidos.sort((a, b) => DateTime.tryParse(a.dataPedido)
              .compareTo(DateTime.tryParse(b.dataPedido)));
          return pedidos.reversed.toList();
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //* -------------------------------------------------------------
  List<PedidoModel> listResultsPedidos(String results) {
    List<PedidoModel> list = [];
    List<String> pedidosJosn = results.split("|");
    for (int i = 0; i < pedidosJosn.length - 1; i++) {
      PedidoModel usuario = PedidoModel.fromMap(json.decode(pedidosJosn[i]));
      list.add(usuario);
    }
    return list;
  }

  //* Pedido com retirada por código
  Future<Map<String, dynamic>> pedidoPorRetiradaDeCodigo(
      PedidoModel pedido) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/registrations/registroPedidoRetirada.php";
    FormData formData = FormData.fromMap(pedido.toMapNotEntrega());

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
      return {"Result": "Falha na Conexão"};
    }
  }

  //* Calcular Frete
  Future<Map<String, dynamic>> cacularFrete(Map<String, dynamic> map) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/getDistancePrice.php";
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
      return {"Result": "Falha na Conexão"};
    }
  }

  //* Pedido com Entrega
  Future<Map<String, dynamic>> pedidoPorEntrega(PedidoModel pedido) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/registrations/registroPedidoEntrega.php";
    FormData formData = FormData.fromMap(pedido.toMapEntrega());

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
      return {"Result": "Falha na Conexão"};
    }
  }

  //* -----------------------------------------
  //* Change Status
  Future<String> changeStatus(int id, String status) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/updates/updateEstadoPedido.php";
    Map<String, dynamic> map = {
      "id": id,
      "estado": status,
    };
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result["Result"];
      } else {
        return "Falha na Conexão";
      }
    } catch (e) {
      print(e);
      return "Falha na Conexão";
    }
  }

  //* Enviar Reporte
  Future<String> sendReport({
    int idUser,
    int idPetshop,
    String nomeUser,
    String message,
  }) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/reports/sendReport.php";
    FormData formData = FormData.fromMap({
      "idUser": idUser,
      "idPetshop": idPetshop,
      "nomeUser": nomeUser,
      "message": message,
    });

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result["Result"];
      } else {
        return "Falha na Conexão";
      }
    } catch (e) {
      print(e);
      return "Falha na Conexão";
    }
  }
}
