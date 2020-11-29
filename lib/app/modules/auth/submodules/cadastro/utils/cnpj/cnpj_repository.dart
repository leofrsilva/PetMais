import 'package:dio/dio.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CnpjRepository {
  static Future<Map<String, dynamic>> searchCNPJ(
    String cnpg,
    BuildContext context,
  ) async {
    Dio http = Modular.get<Dio>();
    String url = "https://www.receitaws.com.br/v1/cnpj/$cnpg";
    Map<String, dynamic> org;
    try {
      Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data;
        if (result["status"] != "ERROR") {
          org = {
            "nome": result["nome"],
            "numero": result["numero"],
            "cep": result["cep"],
          };
          if (result["telefone"].toString().isNotEmpty) {
            List<String> listTel = result["telefone"].toString().split("/");
            org["tel1"] = listTel[0].toString().trim();
            if (listTel.length > 1) {
              if (listTel[1].isNotEmpty)
                org["tel2"] = listTel[1].toString().trim();
            }
          }
          if (result["atividade_principal"] != null) {
            (result["atividade_principal"] as List).forEach((element) {
              org["descricao"] = element["text"].toString();
            });
          }
        } else {
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 2000),
            message: "CNPJ não encontrado!",
          )..show(context);
        }
      } else {
        FlushbarHelper.createError(
          duration: Duration(milliseconds: 1500),
          message: "Erro na Conexão",
          title: "CNPJ",
        )..show(context);
      }
    } catch (e) {
      print(e);
      FlushbarHelper.createError(
        duration: Duration(milliseconds: 1500),
        message: "Erro na Conexão",
        title: "CNPJ",
      )..show(context);
    }
    return org;
  }

  static Future<bool> findCNPJ(
    String cnpg,
  ) async {
    Dio http = Modular.get<Dio>();
    String url = "https://www.receitaws.com.br/v1/cnpj/$cnpg";
    bool org;
    try {
      Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data;
        if (result["status"] != "ERROR") {
          org = true;
        } else {
          org = false;
        }
      }
    } catch (e) {
      print(e);
    }
    return org;
  }
}
