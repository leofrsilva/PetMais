import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';

const String COLUMN_ID = "id";
const String COLUMN_NOME = "nome";
const String COLUMN_SOBRENOME = "sobreNome";
const String COLUMN_DATANASCIMENTO = "dataNascimento";
const String COLUMN_URLFOTO = "urlFoto";
const String COLUMN_NUMEROTELEFONE = "numeroTelefone";

class UsuarioInfoModel {
  int _id;
  String _nome;
  String _sobreNome;
  String _dataNascimento;
  String _urlFoto;
  String _numeroTelefone;

  UsuarioInfoModel({
    int identifier,
    String name,
    String surname,
    String data,
    String foto,
    String telefone,
  }) {
    this.id = identifier ?? 0;
    this.nome = name ?? "";
    this.sobreNome = surname ?? "";
    this.dataNascimento = data ?? "";
    this.urlFoto = foto ?? "";
    this.numeroTelefone = telefone ?? "";
  }

  UsuarioInfoModel.fromMap(Map map) {
    this.id = map[COLUMN_ID];
    this.nome = map[COLUMN_NOME];
    this.sobreNome = map[COLUMN_SOBRENOME];
    this.dataNascimento = map[COLUMN_DATANASCIMENTO];
    this.urlFoto = map[COLUMN_URLFOTO] == "No Photo"
        ? map[COLUMN_URLFOTO]
        : UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_URLFOTO];
    this.numeroTelefone = map[COLUMN_NUMEROTELEFONE];
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      COLUMN_NOME: 15,
      COLUMN_SOBRENOME: 50,
      COLUMN_DATANASCIMENTO: 10,
      COLUMN_URLFOTO: 150,
      COLUMN_NUMEROTELEFONE: 15,
    };
    return result;
  }

  int get id => this._id;
  set id(int value) => this._id = value;

  String get nome => this._nome;
  set nome(String value) => this._nome = value;

  String get sobreNome => this._sobreNome;
  set sobreNome(String value) => this._sobreNome = value;

  String get dataNascimento => this._dataNascimento;
  set dataNascimento(String value) => this._dataNascimento = value;

  String get urlFoto => this._urlFoto;
  set urlFoto(String value) => this._urlFoto = value;

  String get numeroTelefone => this._numeroTelefone;
  set numeroTelefone(String value) => this._numeroTelefone = value;
}
