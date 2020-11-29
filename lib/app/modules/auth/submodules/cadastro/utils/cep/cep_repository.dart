import 'package:dio/dio.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';

class CepRepository {
  static Future<DadosEnderecoModel> searchCEP(
    String cep,
    BuildContext context,
  ) async {
    Dio http = Modular.get<Dio>();
    String url = "https://viacep.com.br/ws/$cep/json/";
    DadosEnderecoModel adress;
    try {
      Response response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> result = response.data;
        if (result.containsKey("erro") == false) {
          adress = DadosEnderecoModel(
            cep: result["cep"],
            rua: result["logradouro"],
            bairro: result["bairro"],
            cidade: result["localidade"],
            estado: result["uf"],
          );
        } else {          
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 2000),
            message: "CEP não encontrado!",
          )..show(context);
        }
      } else {
        FlushbarHelper.createError(
          duration: Duration(milliseconds: 1500),
          message: "Erro na Conexão",
          title: "CEP",
        )..show(context);
      }
    } catch (e) {
      print(e);
      FlushbarHelper.createError(
          duration: Duration(milliseconds: 1500),
          message: "Erro na Conexão",
          title: "CEP",
        )..show(context);
    }
    return adress;
  }

  // static Future<bool> validCEP(
  //   String cep,
  //   BuildContext context,
  //   bool isLoading,
  // ) async {
  //   Dio http = Modular.get<Dio>();
  //   String url = "https://viacep.com.br/ws/$cep/json/";
  //   try {
  //     Response response = await http.get(url);
  //     //* Stop Loading
  //     if(isLoading) Modular.to.pop();

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> result = response.data;
  //       return !result.containsKey("erro");
  //     } else {
  //       FlushbarHelper.createError(
  //         duration: Duration(milliseconds: 1500),
  //         message: "Erro na Conexão",
  //         title: "CEP",
  //       )..show(context);
  //       return null;
  //     }
  //   } catch (e) {
  //     print(e);
  //     if(isLoading) Modular.to.pop();
  //     FlushbarHelper.createError(
  //         duration: Duration(milliseconds: 1500),
  //         message: "Erro na Conexão",
  //         title: "CEP",
  //       )..show(context);
  //     return null;
  //   }
  // }
}