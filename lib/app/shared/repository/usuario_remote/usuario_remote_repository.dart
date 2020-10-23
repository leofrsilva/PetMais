import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

class UsuarioRemoteRepository {
  static const String URL =
      "http://app.petsmais.com"; //"http://petsmais.atwebpages.com";
  // static final String columnId = "id";
  // static final String columnNome = "nome";
  // static final String columnSobreNome = "sobreNome";
  // static final String columnEmail = "email";
  // static final String columnSenha = "senha";
  // static final String columnDataNascimento = "dataNascimento";
  // static final String columnUrlFoto = "urlFoto";
  // static final String columnNumeroTelefone = "numeroTelefone";

  static final UsuarioRemoteRepository _userHelper =
      UsuarioRemoteRepository._internal();

  factory UsuarioRemoteRepository() {
    return _userHelper;
  }

  UsuarioRemoteRepository._internal();

  Future<String> getKey() async {
    final dio = Modular.get<Dio>();
    String link = "/functions/getCrypto.php";
    
    try {
      Response response = await dio
          .get(link)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String result = response.data.trim();
        return result;
      } else {
        return "Falha na Conexão";
      }
    } catch (e) {
      print(e);
      return "Falha na Conexão";
    }
  }

  Future<Map<String, dynamic>> loginUser(String email, String senha, String type) async {
    final dio = Modular.get<Dio>();

    String link = "";
    if(type == "c"){
      link = "/functions/login_user.php";
    }
    else if(type == "j"){
      link = "/functions/login_user.php";
    }
    Map<String, dynamic> map = {
      "email": email,
      "senha": senha,
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

    // final r = RetryOptions(maxAttempts: 3);
    // http.Response response = await r
    //     .retry(
    //   () => http.post(link, body: map).timeout(Duration(seconds: 2)),
    //   retryIf: (e) => e is SocketException || e is TimeoutException,
    // ).catchError((e) {
    //   if (e is http.ClientException) {
    //     return null;
    //   }
    // });
  }

  Future<Map<String, dynamic>> checkEmail(String email, {bool loading}) async {
    final dio = Modular.get<Dio>();

    String link = "/functions/registrations/checkEmail.php";
    Map<String, dynamic> map = {"email": email};
    FormData formData = FormData.fromMap(map);

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

  Future<Map<String, dynamic>> recuperarSenha(String email, {bool loading}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/newPassGenerator.php";
    Map<String, dynamic> map = {"email": email};
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

  Future<Map<String, dynamic>> registerUser(
    UsuarioModel user, {
    bool loading,
  }) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/registrations/registro_user.php";
    FormData formData = FormData.fromMap(user.toMap());

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

  

  Future<String> updateUrlFotoUser(int id, String urlFoto) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/updates/updateUrlFotoUser.php";
    Map<String, dynamic> map = {"id": id.toString(), "urlFoto": urlFoto};
    FormData formData = FormData.fromMap(map);

     try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      // if (loading) Modular.to.pop();
      if (response.statusCode == 200) {
        return response.data.trim();
      } else {
        return "Falha na Conexão";
      }
    } catch (e) {
      print(e);
      // if (loading) Modular.to.pop();
      return "Falha na Conexão";
    }
  }

  Future<Map<String, dynamic>> updateUser(UsuarioModel user) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/updates/updateUser.php";
    FormData formData = FormData.fromMap(user.toMapUpdate());

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

  Future<Map<String, dynamic>> uploadImagePerfil(File image, bool loading, {String imgDepreciada}) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/uploads/uploadImagePerfil.php";
    // Uri uri = Uri.parse(image.path);
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
      Response response = await dio
          .post(link, data: file);     
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
    // Stream x = dio.
    // Stream stream = http.ByteStream(Stream.castFrom(image.openRead()));
    // int length = await image.length();
    // Uri uri = Uri.parse(link);
    // http.MultipartRequest request = http.MultipartRequest("POST", uri);
    // http.MultipartFile partFile = http.MultipartFile(
    //   "image",
    //   stream,
    //   length,
    //   filename: basename(image.path.split("/").last),
    // );
    // request.files.add(partFile);
    // http.StreamedResponse response = await request.send();
    // ////-------------------------------------------------------------
    // Map<String, dynamic> result;
    // if (response.statusCode == 200) {
    //   result = {"Result": "Enviado"};
    // } else {
    //   result = {"Result": "Falha no Envio"};
    // }
    // return result;
  }

  // Future<Map<String, dynamic>> uploadImageChat(File image) async {
  //   String link = URL + "/uploads/uploadImageChat.php";
  //   Stream stream = http.ByteStream(Stream.castFrom(image.openRead()));
  //   int length = await image.length();
  //   Uri uri = Uri.parse(link);
  //   http.MultipartRequest request = http.MultipartRequest("POST", uri);
  //   http.MultipartFile partFile = http.MultipartFile(
  //     "image",
  //     stream,
  //     length,
  //     filename: basename(image.path.split("/").last),
  //   );
  //   request.files.add(partFile);
  //   http.StreamedResponse response = await request.send();
  //   ////-------------------------------------------------------------
  //   Map<String, dynamic> result;
  //   if (response.statusCode == 200) {
  //     result = {"Result": "Enviado"};
  //   } else {
  //     result = {"Result": "Falha no Envio"};
  //   }
  //   return result;
  // }

  // Future<Uint8List> downloadImagePerfil(String path) async {
  //   String link = URL + "/downloads/downloadImage.php";
  //   Map<String, String> map = {"path": path};

  //   final r = RetryOptions(maxAttempts: 3);
  //   http.Response response = await r.retry(
  //     () => http.post(link, body: map).timeout(Duration(seconds: 2)),
  //     retryIf: (e) => e is SocketException || e is TimeoutException,
  //   );

  //   // .catchError((http.ClientException e){
  //   //   if(e is http.ClientException){
  //   //     print("Falha na Conexão!");
  //   //   }
  //   // });

  //   ////-------------------------------------------------------------
  //   if (response.body == "Arquivo não Encontrado!") {
  //     return null;
  //   } else {
  //     var result = base64.decode(response.body);
  //     return result;
  //   }
  // }

  // //* ----------------------------------------------------------------------
  // List<User> listResults(String results) {
  //   List<User> list = [];
  //   List<String> usersJosn = results.split("}");
  //   for (int i = 0; i < usersJosn.length - 1; i++) {
  //     usersJosn[i] = usersJosn[i] + "}";
  //     User usuario = User.fromMap(json.decode(usersJosn[i]));
  //     list.add(usuario);
  //   }
  //   return list;
  // }

  Future<List<UsuarioModel>> suggestionsUser(String nome) async {
    final dio = Modular.get<Dio>();
    String link = "/functions/suggestionsUser.php";
    Map<String, dynamic> map = {"nome": nome};
    FormData formData = FormData.fromMap(map);

    try {
      Response response = await dio
          .post(link, data: formData)
          .timeout(Duration(milliseconds: 10000));
      if (response.statusCode == 200) {
        String record = response.data.trimLeft();
        if (record == "Not Found User") {
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

    // String record = response.body.toString();
    // if (record == "Not Found User" || record == "No Instance Nome") {
    //   return null;
    // } else {
    //   return listResults(response.body);
    // }
  }

  //* ----------------------------------------------------------------------
  List<UsuarioModel> listResults(String results) {
    List<UsuarioModel> list = [];
    List<String> petsJosn = results.split("}");
    for (int i = 0; i < petsJosn.length - 1; i++) {
      petsJosn[i] = petsJosn[i] + "}";
      UsuarioModel usuario = UsuarioModel.fromMap(json.decode(petsJosn[i]));
      list.add(usuario);
    }
    return list;
  }
}
