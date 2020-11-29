import 'dart:convert';

import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

const String COLUMN_TYPEUSER = "typeUser";
const String COLUMN_IDDONO = "idDono";
const String COLUMN_IDPET = "idPet";
const String COLUMN_NOMEDONO = "nomeDono";
const String COLUMN_IMGDONO = "imgDono";
const String COLUMN_DESCRICAO = "descricao";
const String COLUMN_URLIMAGE = "urlImage";
const String COLUMN_NOME = "nome";
const String COLUMN_ESPECIE = "especie";
const String COLUMN_RACA = "raca";
const String COLUMN_SEXO = "sexo";
const String COLUMN_DATANASCIMENTO = "dataNascimento";
const String COLUMN_EMAIL = "email";
const String COLUMN_NUMEROTELEFONE = "numeroTelefone";
const String COLUMN_DATAREGISTRO = "dataRegistro";
const String COLUMN_PETIMAGES = "petImages";

class PostAdocaoModel {
  int _idDono;
  int _idPet;
  String _nomeDono;
  String _imgDono;
  String _descricao;
  String _nome;
  String _especie;
  String _raca;
  String _sexo;
  String _dataNascimento;
  String _email;
  String _numeroTelefone;
  String _dataRegistro;
  PetImagesModel _petImages;
  TypeUser _typeUser;

  PostAdocaoModel({
    TypeUser type,
    int idDono,
    int idPet,
    String nomeDono,
    String imgDono,
    String nome,
    String especie,
    String raca,
    String sexo,
    String dataNascimento,
    String email,
    String numeroTelefone,
    String dataRegistro,
    String descricao,
    PetImagesModel petImages,
  }) {
    this._idDono = idDono;
    this._idPet = idPet;
    this._nomeDono = nomeDono;
    this._imgDono = imgDono;
    this._nome = nome;
    this._especie = especie;
    this._raca = raca;
    this._sexo = sexo;
    this._dataNascimento = dataNascimento;
    this._email = email;
    this._numeroTelefone = numeroTelefone;
    this._dataRegistro = dataRegistro;
    this._descricao = descricao;
    this._petImages = petImages;
    this._typeUser = type;
  }

  PostAdocaoModel.fromMap(Map map) {
    this._typeUser = map[COLUMN_TYPEUSER].toString() == 'c'
        ? TypeUser.fisica
        : TypeUser.juridica;
    this._idDono = map[COLUMN_IDDONO];
    this._idPet = map[COLUMN_IDPET];
    this._nomeDono = map[COLUMN_NOMEDONO];
    this._imgDono = map[COLUMN_IMGDONO];
    this._nome = map[COLUMN_NOME];
    this._especie = map[
        COLUMN_ESPECIE]; //utf8.decode(map[COLUMN_ESPECIE].toString().codeUnits);
    this._raca =
        map[COLUMN_RACA]; //utf8.decode(map[COLUMN_RACA].toString().codeUnits);
    this._sexo = map[COLUMN_SEXO];
    this._dataNascimento = map[COLUMN_DATANASCIMENTO];
    this._email = map[COLUMN_EMAIL];
    this._numeroTelefone = map[COLUMN_NUMEROTELEFONE];
    this._dataRegistro = map[COLUMN_DATAREGISTRO];
    this._descricao = map[
        COLUMN_DESCRICAO]; //utf8.decode(map[COLUMN_DESCRICAO].toString().codeUnits);
    this._petImages = PetImagesModel.fromMap(map["petImages"]);
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      COLUMN_NOME: 15,
      COLUMN_NOMEDONO: 15,
      COLUMN_ESPECIE: 15,
      COLUMN_RACA: 10,
      COLUMN_SEXO: 1,
      COLUMN_EMAIL: 30,
      COLUMN_DATAREGISTRO: 10,
      COLUMN_DATANASCIMENTO: 10,
      COLUMN_NUMEROTELEFONE: 15,
      COLUMN_DESCRICAO: 250,
      COLUMN_URLIMAGE: 150,
    };
    return result;
  }

  TypeUser get typeUser => this._typeUser;
  set typeUser(TypeUser value) => this._typeUser = value;

  int get idDono => this._idDono;
  int get idPet => this._idPet;
  String get nomeDono => this._nomeDono;
  String get imgDono => this._imgDono;

  String get descricao => this._descricao;
  set descricao(String value) => this._descricao = value;

  PetImagesModel get petImages => this._petImages;
  String get nome => this._nome;
  String get especie => this._especie;
  String get raca => this._raca;
  String get sexo => this._sexo;
  String get dataNascimento => this._dataNascimento;

  String get email => this._email;
  set email(String value) => this._email = value;

  String get numeroTelefone => this._numeroTelefone;
  set numeroTelefone(String value) => this._numeroTelefone = value;

  String get dataRegistro => this._dataRegistro;
}
