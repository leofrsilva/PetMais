const String COLUMN_CEP = "cep";
const String COLUMN_RUA = "rua";
const String COLUMN_NUMERO = "numero";
const String COLUMN_COMPLEMENTO = "complemento";
const String COLUMN_BAIRRO = "bairro";
const String COLUMN_CIDADE = "cidade";
const String COLUMN_ESTADO = "estado";

class DadosEnderecoModel {
  String _cep;
  String _rua;
  String _numero;
  String _complemento;
  String _bairro;
  String _cidade;
  String _estado;

  DadosEnderecoModel({
    String cep,
    String rua,
    String numero,
    String comp,
    String bairro,
    String cidade,
    String estado,
  }) {
    this.cep = cep;
    this.rua = rua;
    this.numero = numero;
    this.complemento = comp;
    this.bairro = bairro;
    this.cidade = cidade;
    this.estado = estado;
  }

  DadosEnderecoModel.fromMap(Map map) {
    this.cep = map[COLUMN_CEP];
    this.rua = map[COLUMN_RUA];
    this.numero = map[COLUMN_NUMERO];
    this.complemento = map[COLUMN_COMPLEMENTO];
    this.bairro = map[COLUMN_BAIRRO];
    this.cidade = map[COLUMN_CIDADE];
    this.estado = map[COLUMN_ESTADO];
  }

  Map<String, String> toMap() {
    Map<String, String> map = {
      COLUMN_CEP: this.cep,
      COLUMN_RUA: this.rua,
      COLUMN_NUMERO: this.numero,
      COLUMN_COMPLEMENTO: this.complemento,
      COLUMN_BAIRRO: this.bairro,
      COLUMN_CIDADE: this.cidade,
      COLUMN_ESTADO: this.estado,
    };
    return map;
  }

  String toLogadouro() {
    return this.rua +
        ", " +
        this.numero +
        " " +
        this.bairro +
        ", " +
        this.cidade;
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      "cep": 9,
      "rua": 60,
      "numero": 4,
      "complemento": 15,
      "bairro": 30,
      "cidade": 30,
      "estado": 2,
    };
    return result;
  }

  String get cep => this._cep;
  set cep(String value) => this._cep = value;

  String get rua => this._rua;
  set rua(String value) => this._rua = value;

  String get numero => this._numero;
  set numero(String value) => this._numero = value;

  String get complemento => this._complemento;
  set complemento(String value) => this._complemento = value;

  String get bairro => this._bairro;
  set bairro(String value) => this._bairro = value;

  String get cidade => this._cidade;
  set cidade(String value) => this._cidade = value;

  String get estado => this._estado;
  set estado(String value) => this._estado = value;
}
