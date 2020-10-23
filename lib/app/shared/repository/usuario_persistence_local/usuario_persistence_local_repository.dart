import 'package:shared_preferences/shared_preferences.dart';

class UsuarioPersistenceLocalRepository {
  // ----------------------------------------------------------------------
  static const String KEYLOGADO = "userLogado";
  static SharedPreferences preferences;
  static Future<void> getInstance() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setUserLogado(Map<String, dynamic> map) async {
    if(map["senha"] != null){
      await getInstance();
      String email = map["email"];
      String senha = map["senha"];
      String encrypted = map["encrypted"];

      List<String> user = [
        email,
        senha,
        encrypted,
      ];
      bool value = await preferences.setStringList(KEYLOGADO, user);
      if (value == true) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<Map<String, String>> getUserLogado() async {
    await getInstance();
    List<String> user = preferences.getStringList(KEYLOGADO);
    Map<String, String> map = {};
    if (user != null) {
      map["email"] = user[0];
      map["senha"] = user[1];
      map["encrypted"] = user[1];      
      return map;
    } else {
      return null;
    }
  }

  static Future<bool> removeUserLogado() async {
    await getInstance();
    bool value = await preferences.remove(KEYLOGADO);
    if (value == true) {
      return true;
    } else {
      return false;
    }
  }
}
