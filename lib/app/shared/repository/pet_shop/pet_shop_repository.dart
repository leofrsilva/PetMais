import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';

class PetShopRepository {
  static final PetShopRepository _petHelper = PetShopRepository._internal();

  factory PetShopRepository() {
    return _petHelper;
  }
  PetShopRepository._internal();

  Future<Map<String, dynamic>> registerPet(ProdutoModel prod) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/registrations/registroPet.php";
    FormData formData = FormData.fromMap(prod.toMap());
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
  Future<List<ProdutoModel>> listProdPetShop(
    {int idPetShop, 
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
          return listResults(response.data);
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
