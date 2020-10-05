import 'package:cloud_firestore/cloud_firestore.dart';

const COLUMN_IDUSUARIO = "idUsuario";
const COLUMN_TYPE = "type";
const COLUMN_MESSAGE = "message";
const COLUMN_DATA = "data";

class MessageModel {
  String _idUsuario;
  String _type;
  String _message;
  Timestamp _data;

  MessageModel({
    String idUsuario,
    String type,
    String message,
    Timestamp data,
  }) {
    this._idUsuario = idUsuario;
    this._type = type;
    this._message = message;
    this._data = data;
  }

  MessageModel.fromJson(Map<String, dynamic> map) {
    this._idUsuario = map[COLUMN_IDUSUARIO];
    this._type = map[COLUMN_TYPE];
    this._message = map[COLUMN_MESSAGE];
    this._data = map[COLUMN_DATA];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      COLUMN_IDUSUARIO: this.idUsuario,
      COLUMN_TYPE: this.type,
      COLUMN_MESSAGE: this.message,
      COLUMN_DATA: this.data,
    };
    return map;
  }

  String get idUsuario => this._idUsuario;
  set idUsuario(String value) => this._idUsuario = value;

  String get type => this._type;
  set type(String value) => this._type = value;

  String get message => this._message;
  set message(String value) => this._message = value;

  Timestamp get data => this._data;
  set data(Timestamp value) => this._data = value;

//   MessageModel({
//     int id,
//     int idUser,
//     int idRoom,
//     String type,
//     String text,
//     bool viewed,
//     DateTime datetime,
//   }) {
//     this.id = id;
//     this.idUser = idUser;
//     this.idRoom = idRoom;
//     this.type = type;
//     this.text = text;
//     this.viewed = viewed;
//     this.datetime = datetime;
//   }

//   MessageModel.fromJson(Map json) {
//     this.id = json[COLUMN_ID];
//     this.idUser = json[COLUMN_IDUSER];
//     this.idRoom = json[COLUMN_IDROOM];
//     this.type = json[COLUMN_TYPE];
//     this.text = json[COLUMN_TEXT];
//     this.viewed = json[COLUMN_VIEWED];
//     this.datetime = json[COLUMN_DATETIME];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       COLUMN_IDUSER: this.idUser,
//       COLUMN_IDROOM: this.idRoom,
//       COLUMN_TYPE: this.type,
//       COLUMN_TEXT: this.text,
//       COLUMN_VIEWED: this.viewed,
//       COLUMN_DATETIME: this.datetime,
//     };
//   }

//   int get id => this._id;
//   set id(int value) => this._id = value;

//   int get idUser => this._idUser;
//   set idUser(int value) => this._idUser = value;

//   int get idRoom => this._idRoom;
//   set idRoom(int value) => this._idRoom = value;

//   String get type => this._type;
//   set type(String value) => this._type = value;

//   String get text => this._text;
//   set text(String value) => this._text = value;

//   bool get viewed => this._viewed;
//   set viewed(bool value) => this._viewed = value;

//   DateTime get datetime => this._datetime;
//   set datetime(DateTime value) => this._datetime = value;
}
