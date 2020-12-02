import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';

class AdocaoRemoteRepository {
  static final AdocaoRemoteRepository _adocaoHelper =
      AdocaoRemoteRepository._internal();

  factory AdocaoRemoteRepository() {
    return _adocaoHelper;
  }
  AdocaoRemoteRepository._internal();

  Future<Map<String, dynamic>> registerAdocao(AdocaoModel adocao) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/registrations/registroAdocao.php";
    FormData formData = FormData.fromMap(adocao.toMap());

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

  Future<Map<String, dynamic>> uploadImageAdocao(File image) async {
    final dio = Modular.get<Dio>();
    String link = "/uploads/uploadImageAdocao.php";

    Map<String, dynamic> map = {
      "image": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split("/").last,
        contentType: MediaType('image', 'jpeg'),
      ),
    };
    FormData file = FormData.fromMap(map);

    try {
      Response response = await dio.post(link, data: file);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        return {"Result": "Falha no Envio"};
      }
    } catch (e) {
      print(e);
      return {"Result": "Falha no Envio"};
    }
  }

  Future<List<PostAdocaoModel>> listAdocoes(int id,
      {String especie, String raca}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listAdocao.php";

    Map<String, dynamic> map = {};
    if (id != 0) {
      map["id"] = id;
    }
    if (raca != null && raca.isNotEmpty) {
      map["raca"] = raca;
    }
    if (especie != null && especie.isNotEmpty) {
      map["especie"] = especie;
    }
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String record = response.data.trimLeft();
        if (record == "Not Found Pets") {
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

  Future<List<PostAdocaoModel>> listOngAdocoes(int id,
      {String especie, String raca}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listOngAllAdocao.php";

    Map<String, dynamic> map = {};
    if (id != 0) {
      map["id"] = id;
    }
    if (raca != null && raca.isNotEmpty) {
      map["raca"] = raca;
    }
    if (especie != null && especie.isNotEmpty) {
      map["especie"] = especie;
    }
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String record = response.data.trimLeft();
        if (record == "Not Found Pets") {
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

  DateTime convertStringForDate(String textData) {
    List<String> listNumData = textData.split("/");
    String data = "";
    for (var item in listNumData.reversed) {
      data = data + item;
    }
    final result = DateTime.tryParse(data);
    return result;
  }
  Future<List<PostAdocaoModel>> listAllAdocoes(int id,
      {String especie, String raca, bool ong}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listAllAdocao.php";

    Map<String, dynamic> map = {};
    if (id != 0) {
      map["id"] = id;
    }
    if (raca != null && raca.isNotEmpty) {
       if(raca == "SRD")
        raca = "SRD (Sem Raça Definida)";
      map["raca"] = raca;
    }
    if (especie != null && especie.isNotEmpty && especie != "Todos") {     
      map["especie"] = especie;
    }
    if (ong != null && ong == true) {     
      map["ong"] = ong;
    }
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String record = response.data.trim();
        if (record == "Not Found Pets") {
          return [];
        } else {
          List<PostAdocaoModel> adocoes = listResults(response.data);
          adocoes.sort((a, b)
              // => a.length.compareTo(b.length)
              =>
              convertStringForDate(a.dataRegistro)
                  .compareTo(convertStringForDate(b.dataRegistro)));
          return adocoes.reversed.toList();

        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  List<PostAdocaoModel> listResults(String results) {
    List<PostAdocaoModel> list = [];
    List<String> adocaosJosn = results.split("|");
    for (int i = 0; i < adocaosJosn.length - 1; i++) {
      PostAdocaoModel post =
          PostAdocaoModel.fromMap(json.decode(adocaosJosn[i]));
      list.add(post);
    }
    return list;
  }

  Future<Map<String, dynamic>> atualizarAdocao(AdocaoModel adocao) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/updates/updateAdocao.php";
    FormData formData = FormData.fromMap(adocao.toMap());

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

  Future<Map<String, dynamic>> deleteAdocao(int id) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/exclusions/deleteAdocao.php";
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
    // final r = RetryOptions(maxAttempts: 5);
    // http.Response response = await r.retry(
    //   () => http.post(link, body: map).timeout(Duration(seconds: 2)),
    //   retryIf: (e) => e is SocketException || e is TimeoutException,
    // );
    // var result = await json.decode(response.body);
    // return result;
  }
}
