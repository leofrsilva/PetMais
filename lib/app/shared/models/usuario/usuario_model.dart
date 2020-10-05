import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';

const String COLUMN_EMAIL = "email";
const String COLUMN_SENHA = "senha";
const String COLUMN_TIPOUSUARIO = "tipoUsuario";

enum TypeUser {
  fisica,
  juridica,
}

class UsuarioModel {
  String _email;
  String _senha;
  String _typeUser;
  UsuarioInfoModel _usuarioInfoModel;

  UsuarioModel({String email, String senha, TypeUser type}) {
    this.email = email;
    this.senha = senha;
    this.typeUser = type ?? TypeUser.fisica;
  }

  UsuarioModel.fromMap(Map map) {
    this.email = map[COLUMN_EMAIL];
    this.senha = map[COLUMN_SENHA];
    this.typeUser = map[COLUMN_TIPOUSUARIO] == "fisica" ? TypeUser.fisica : TypeUser.juridica;
    this.usuarioInfoModel = UsuarioInfoModel.fromMap(map);
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      COLUMN_EMAIL: this._email,
      COLUMN_SENHA: this._senha,
      COLUMN_TIPOUSUARIO: this._typeUser,
      COLUMN_NOME: this.usuarioInfoModel.nome,
      COLUMN_SOBRENOME: this.usuarioInfoModel.sobreNome,
      COLUMN_DATANASCIMENTO: this.usuarioInfoModel.dataNascimento,
      COLUMN_NUMEROTELEFONE: this.usuarioInfoModel.numeroTelefone,
      COLUMN_URLFOTO: this.usuarioInfoModel.urlFoto,
    };
    return map;
  }

  Map<String, dynamic> toMapUpdate(){
    Map<String, dynamic> map = {
      COLUMN_EMAIL: this._email,
      COLUMN_ID: this.usuarioInfoModel.id,
      COLUMN_NOME: this.usuarioInfoModel.nome,
      COLUMN_SOBRENOME: this.usuarioInfoModel.sobreNome,
      COLUMN_DATANASCIMENTO: this.usuarioInfoModel.dataNascimento,
      COLUMN_NUMEROTELEFONE: this.usuarioInfoModel.numeroTelefone,
    };
    return map;
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      "email": 30,
      "senha": 10,
    };
    return result;
  }

  String get email => this._email;
  set email(String value) => this._email = value;

  String get senha => this._senha;
  set senha(String value) => this._senha = value;

  UsuarioInfoModel get usuarioInfoModel => this._usuarioInfoModel;
  set usuarioInfoModel(UsuarioInfoModel value) =>
      this._usuarioInfoModel = value;

  TypeUser get typeUser =>
      this._typeUser == "fisica" ? TypeUser.fisica : TypeUser.juridica;
  set typeUser(TypeUser value) => this._typeUser =
      (value == TypeUser.fisica ? "fisica" : "juridica");
}
