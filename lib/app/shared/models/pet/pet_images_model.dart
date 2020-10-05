import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';

const String COLUMN_ID = "id";
const String COLUMN_IMGPRINCIPALURL = "imgPrincipalURL";
const String COLUMN_IMGSECUNDARIAURL = "imgSecundariaURL";
const String COLUMN_IMGTERCIARIAURL = "imgTerciariaURL";

class PetImagesModel {
  int _idPet;
  String _imgPrincipal;
  String _imgSecundario;
  String _imgTerciaria;

  PetImagesModel({int idPet, String imgP, String imgS, String imgT}) {
    this._idPet = idPet;
    this.imgPrincipal = imgP;
    this.imgSecundario = imgS;
    this.imgTerciaria = imgT;
  }

  PetImagesModel.fromMap(Map map) {
    this.idPet = map[COLUMN_ID];
    this.imgPrincipal = map[COLUMN_IMGPRINCIPALURL] == "No Photo"
        ? map[COLUMN_IMGPRINCIPALURL]
        : UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_IMGPRINCIPALURL];
    this.imgSecundario = map[COLUMN_IMGSECUNDARIAURL] == "No Photo"
        ? map[COLUMN_IMGSECUNDARIAURL]
        : UsuarioRemoteRepository.URL +
            "/files/" +
            map[COLUMN_IMGSECUNDARIAURL];
    this.imgTerciaria = map[COLUMN_IMGTERCIARIAURL] == "No Photo"
        ? map[COLUMN_IMGTERCIARIAURL]
        : UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_IMGTERCIARIAURL];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      COLUMN_ID: this.idPet,
      COLUMN_IMGPRINCIPALURL: this.imgPrincipal,
      COLUMN_IMGSECUNDARIAURL: this.imgSecundario,
      COLUMN_IMGTERCIARIAURL: this.imgTerciaria,
    };
    return map;
  }

  List<String> get listImages => <String>[
        this.imgPrincipal,
        this.imgSecundario,
        this.imgTerciaria,
      ];

  int get idPet => this._idPet;
  set idPet(int value) => this._idPet = value;

  String get imgPrincipal => this._imgPrincipal;
  set imgPrincipal(String value) => this._imgPrincipal = value;

  String get imgSecundario => this._imgSecundario;
  set imgSecundario(String value) => this._imgSecundario = value;

  String get imgTerciaria => this._imgTerciaria;
  set imgTerciaria(String value) => this._imgTerciaria = value;
}
