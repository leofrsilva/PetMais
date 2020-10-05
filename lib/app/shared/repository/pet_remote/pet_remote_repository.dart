import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';

class PetRemoteRepository {
  static final PetRemoteRepository _petHelper = PetRemoteRepository._internal();

  factory PetRemoteRepository() {
    return _petHelper;
  }
  PetRemoteRepository._internal();

  Future<Map<String, dynamic>> registerPet(PetModel pet) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/registrations/registroPet.php";
    FormData formData = FormData.fromMap(pet.toMap());

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

    // final r = RetryOptions(maxAttempts: 3);
    // http.Response response = await r.retry(
    //   () => http.post(link, body: pet.toMap()).timeout(Duration(seconds: 2)),
    //   retryIf: (e) => e is SocketException || e is TimeoutException,
    // );

    // var result = await json.decode(response.body);
    // return result;
  }

  Future<Map<String, dynamic>> updatePet(PetModel pet) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/updates/updatePet.php";
    FormData formData = FormData.fromMap(pet.toMapUpdate());

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

  Future<Map<String, dynamic>> deletePet(int id) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/exclusions/deletePet.php";
    Map<String, dynamic> map = {
      "id": id.toString(),
    };
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

  //* Update de Pet Images
  Future<Map<String, dynamic>> updatePetImages(PetImagesModel pet) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/updates/updatePetImages.php";
    FormData formData = FormData.fromMap(pet.toMap());

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

  //* Upload de Image de Pet
  Future<Map<String, dynamic>> uploadImagePet(File image, bool loading) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/uploads/uploadImagePet.php";
    FormData file = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: image.path.split("/").last,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    try {
      Response response = await dio.post(link, data: file);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.data.trim());
        return result;
      } else {
        if (loading) Modular.to.pop();
        return {"Result": "Falha no Envio"};
      }
    } catch (e) {
      print(e);
      if (loading) Modular.to.pop();
      return {"Result": "Falha no Envio"};
    }
  }

  //* ----------------------------------------------------------------------
  List<PetModel> listResults(String results) {
    List<PetModel> list = [];
    List<String> petsJosn = results.split("|");
    for (int i = 0; i < petsJosn.length - 1; i++) {
      PetModel usuario = PetModel.fromMap(json.decode(petsJosn[i]));
      list.add(usuario);
    }
    return list;
  }

  //* Delete Image de Pet
  Future<Map<String, dynamic>> deleteImagePet(String urlImage) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/exclusions/deleteImagePet.php";
    FormData formData = FormData.fromMap({"img": urlImage});

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        return {"Result": "Delete Image in Serve remote"};
      } else {
        return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
      return {"Result": "Falha na Conexão"};
    }
  }

  //* Get Adoção
  Future<Map<String, dynamic>> getAdocao(
      {int idPet}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/getAdocao.php";
    Map<String, dynamic> map = {"idPet": idPet.toString()};
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String record = response.data.trimLeft();
        return json.decode(record.toString());        
      } else {
         return {"Result": "Falha na Conexão"};
      }
    } catch (e) {
      print(e);
       return {"Result": "Falha na Conexão"};
    }
  }

  Future<List<PetModel>> listPet(
      {int idDono,
      String agruparEsp,
      String agruparSex,
      bool paraAdocao}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listPets.php";
    Map<String, dynamic> map = {"idDono": idDono.toString()};
    if (agruparEsp.isNotEmpty && agruparEsp != "todos") {
      map["groupEsp"] = agruparEsp.toLowerCase();
    }
    if (agruparSex.isNotEmpty && agruparSex != "todos") {
      map["groupSex"] = agruparSex;
    }
    if (paraAdocao != null) {
      if (paraAdocao != false)
        map["paraAdocao"] = 1;
      else
        map["paraAdocao"] = 0;
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
          return listResults(response.data.toString().trim());
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
    // final r = RetryOptions(maxAttempts: 3);
    // http.Response response = await r.retry(
    //   () => http.post(link, body: map).timeout(Duration(seconds: 2)),
    //   retryIf: (e) => e is SocketException || e is TimeoutException,
    // );

    // String record = response.body.trimLeft();
    // if (record == "Not Found Pets" || record == "No Instance Id Dono") {
    //   return null;
    // } else {
    //   return listResults(record);
    // }
  }

  Future<List<PetModel>> listPetsAdocao(int idDono, {int paraDoacao}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listPets.php";
    Map<String, dynamic> map;
    if (paraDoacao != null) {
      map = {"idDono": idDono.toString(), "paraAdocao": paraDoacao.toString()};
    } else {
      map = {"idDono": idDono.toString()};
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
    // final r = RetryOptions(maxAttempts: 3);
    // http.Response response = await r.retry(
    //   () => http.post(link, body: map).timeout(Duration(seconds: 2)),
    //   retryIf: (e) => e is SocketException || e is TimeoutException,
    // );

    // String record = response.body.trimLeft();
    // if (record == "Not Found Pets" || record == "No Instance Id Dono") {
    //   return null;
    // } else {
    //   return listResults(record);
    // }
  }

  Future<List<PetModel>> listPetsEmAdocao(int idDono) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/listPetsAdocao.php";
    Map<String, dynamic> map = {"idDono": idDono.toString()};
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
    // final r = RetryOptions(maxAttempts: 3);
    // http.Response response = await r.retry(
    //   () => http.post(link, body: map).timeout(Duration(seconds: 2)),
    //   retryIf: (e) => e is SocketException || e is TimeoutException,
    // );

    // String record = response.body.trimLeft();
    // if (record == "Not Found Pets" || record == "No Instance Id Dono") {
    //   return null;
    // } else {
    //   return listResults(record);
    // }
  }
}
