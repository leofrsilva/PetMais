const String COLUMN_ID = "id";
const String COLUMN_IDPET = "idPet";
const String COLUMN_EMAIL = "email";
const String COLUMN_NUMEROTELEFONE = "numeroTelefone";
const String COLUMN_DATAREGISTRO = "dataRegistro";
const String COLUMN_DESCRICAO = "descricao";

class AdocaoModel {
  int _id;
  int _idPet;
  String _email;
  String _numeroTelefone;
  String _dataRegistro;
  String _descricao;

  AdocaoModel({
    int id,
    int idPet,
    String email,
    String numeroTelefone,
    String dataRegistro,
    String descricao,
    String urlImage,
  }) {
    this.id = id;
    this.idPet = idPet;
    this.email = email;
    this.numeroTelefone = numeroTelefone;
    this.dataRegistro = dataRegistro;
    this.descricao = descricao;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      COLUMN_IDPET: this.idPet.toString(),
      COLUMN_EMAIL: this.email,
      COLUMN_NUMEROTELEFONE: this.numeroTelefone,
      COLUMN_DATAREGISTRO: this.dataRegistro,
      COLUMN_DESCRICAO: this.descricao,
    };
    return map;
  }

  int get id => this._id;
  set id(int value) => this._id = value;

  int get idPet => this._idPet;
  set idPet(int value) => this._idPet = value;

  String get email => this._email;
  set email(String value) => this._email = value;

  String get numeroTelefone => this._numeroTelefone;
  set numeroTelefone(String value) => this._numeroTelefone = value;

  String get dataRegistro => this._dataRegistro;
  set dataRegistro(String value) => this._dataRegistro = value;

  String get descricao => this._descricao;
  set descricao(String value) => this._descricao = value;
}
