const String COLUMN_IDDESTINATARIO = "idDestinatario";
const String COLUMN_IDREMETENTE = "idRemetente";
const String COLUMN_NOME = "nome";
const String COLUMN_IMGUSER = "imgUser";
const String COLUMN_TYPE = "type";
const String COLUMN_MESSAGE = "message";
const String COLUMN_VIEWED = "viewed";

class ConversationModel {
  String _idRemetente;
  String _idDestinatario;
  String _nome;
  String _imgUser;
  String _type;
  String _message;
  bool _viewed;

  ConversationModel({
    String idRemetente,
    String idDestinatario,
    String nome,
    String imgUser,
    String type,
    String message,
    bool viewed,
  }) {
    this._idRemetente = idRemetente;
    this._idDestinatario = idDestinatario;
    this._nome = nome;
    this._imgUser = imgUser;
    this._type = type;
    this._message = message;
    this._viewed = viewed;
  }

  ConversationModel.fromMap(Map map) {
    this._idRemetente = map[COLUMN_IDREMETENTE];
    this._idDestinatario = map[COLUMN_IDDESTINATARIO];
    this._nome = map[COLUMN_NOME];
    this._imgUser = map[COLUMN_IMGUSER];
    this._type = map[COLUMN_TYPE];
    this._message = map[COLUMN_MESSAGE];
    this._viewed = map[COLUMN_VIEWED];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      COLUMN_IDREMETENTE: this.idRemetente,
      COLUMN_IDDESTINATARIO: this.idDestinatario,
      COLUMN_NOME: this.nome,
      COLUMN_IMGUSER: this.imgUser,
      COLUMN_TYPE: this.type,
      COLUMN_MESSAGE: this.message,
      COLUMN_VIEWED: this.viewed,
    };
    return map;
  }

  String get idRemetente => this._idRemetente;
  set idRemetente(String value) => this._idRemetente = value;

  String get idDestinatario => this._idDestinatario;
  set idDestinatario(String value) => this._idDestinatario = value;

  String get nome => this._nome;
  set nome(String value) => this._nome = value;

  String get imgUser => this._imgUser;
  set imgUser(String value) => this._imgUser = value;

  String get type => this._type;
  set type(String value) => this._type = value;

  String get message => this._message;
  set message(String value) => this._message = value;

  bool get viewed => this._viewed;
  set viewed(bool value) => this._viewed = value;
}
