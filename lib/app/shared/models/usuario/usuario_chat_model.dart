const String COLUMN_ID = "id";
const String COLUMN_NAME = "name";
const String COLUMN_IMAGE = "image";
const String COLUMN_STATUS = "status";

class UsuarioChatModel {
  int _id;
  String _name;
  String _image;
  bool _status;

  UsuarioChatModel({int identifier, String name, String image, bool status}) {
    this.id = identifier;
    this.name = name;
    this.image = image;
    this.status = status;
  }

  UsuarioChatModel.fromMap(Map map) {
    this.id = map[COLUMN_ID];
    this.name = map[COLUMN_NAME];
    this.image = map[COLUMN_IMAGE];
    this.status = map[COLUMN_STATUS];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      COLUMN_ID: this.id,
      COLUMN_NAME: this.name,
      COLUMN_IMAGE: this.image,
      COLUMN_STATUS: this.status,
    };
    return map;
  }

  int get id => this._id;
  set id(int value) => this._id = value;

  String get name => this._name;
  set name(String value) => this._name = value;

  String get image => this._image;
  set image(String value) => this._image = value;

  bool get status => this._status;
  set status(bool value) => this._status = value;
}
