import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';

const String COLUMN_ID = "id";
const String COLUMN_IDDONO = "idDono";
const String COLUMN_NOME = "nome";
const String COLUMN_ESPECIE = "especie";
const String COLUMN_RACA = "raca";
const String COLUMN_SEXO = "sexo";
const String COLUMN_DATANASCIMENTO = "dataNascimento";
const String COLUMN_ESTADO = "estado";

class PetModel {
  int _id;
  int _idDono;
  String _nome;
  String _especie;
  String _raca;
  String _sexo;
  String _dataNascimento;
  PetImagesModel _petImages;
  int _estado;

  PetModel({
    int id,
    int idDono,
    String nome,
    String especie,
    String raca,
    String sexo,
    String dataNascimento,
    int estado,
    PetImagesModel petImages,
  }) {
    this._id = id;
    this._idDono = idDono;
    this._nome = nome;
    this._especie = especie;
    this._raca = raca;
    this._sexo = sexo;
    this._dataNascimento = dataNascimento;
    this._estado = estado;
    this._petImages = petImages;
  }

  PetModel.fromMap(Map map) {
    this.id = map[COLUMN_ID];
    this.idDono = map[COLUMN_IDDONO];
    this.nome = map[COLUMN_NOME];
    this.especie = map[COLUMN_ESPECIE];
    this.raca = map[COLUMN_RACA];
    this.sexo = map[COLUMN_SEXO];
    this.dataNascimento = map[COLUMN_DATANASCIMENTO];
    this.petImages = PetImagesModel.fromMap(map["petImages"]);
    this.estado = int.tryParse(map[COLUMN_ESTADO]);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      COLUMN_IDDONO: this.idDono,
      COLUMN_NOME: this.nome,
      COLUMN_ESPECIE: this.especie,
      COLUMN_RACA: this.raca ?? "Null",
      COLUMN_SEXO: this.sexo,
      COLUMN_DATANASCIMENTO: this.dataNascimento ?? "Null",
      COLUMN_ESTADO: this.estado,
    };
    map.addAll(this.petImages.toMap());
    return map;
  }

  Map<String, dynamic> toMapUpdate() {
    Map<String, dynamic> map = {
      COLUMN_ID: this.id,
      COLUMN_IDDONO: this.idDono,
      COLUMN_NOME: this.nome,
      COLUMN_ESPECIE: this.especie,
      COLUMN_RACA: this.raca,
      COLUMN_SEXO: this.sexo,
      COLUMN_DATANASCIMENTO: this.dataNascimento,
    };
    return map;
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      "nome": 15,
      "especie": 15,
      "raca": 30,
      "data": 10,
    };
    return result;
  }

  static List<String> dogs = [
    "OUTRO",
    "VIRA_LATA",
    "PUB",
    "MALTÊS",
    "SHIH TZU",
    "SPITZ ALEMÃO",
    "BULDOGUE",
    "PIT BULL",
    "DACHSHUND",
    "PASTOR-ALEMÃO",
    "BASSET",
    "SCHNAUZER",
    "POODLE",
    "ROTTWEILER",
    "LABRADOR",
    "PINSCHER",
    "LHASA APSO",
    "GOLDEN RETRIEVER",
    "YORKSHIRE",
    "BODER COLLIE",
    "BEAGLE",
  ];

  static List<String> cats = [
    "OUTRO",
    "VIRA_LATA",
    "PERSA",
    "Siamês",
    "HIMALAIA",
    "MAIN COON",
    "ANGORÁ",
    "SIBERIANO",
    "SPHYNX",
    "RAGDOLL",
    "BRITISH SHORTHAIR",
  ];

  static List<DropdownMenuItem<String>> listDogs() {
    return PetModel.dogs.map((racaDog) {
      return DropdownMenuItem(
        child: Text(racaDog),
        value: racaDog,
      );
    }).toList();
  }

  static List<DropdownMenuItem<String>> listCats() {
    return PetModel.cats.map((racaCat) {
      return DropdownMenuItem(
        child: Text(racaCat),
        value: racaCat,
      );
    }).toList();
  }

  int get id => this._id;
  set id(int value) => this._id = value;

  int get idDono => this._idDono;
  set idDono(int value) => this._idDono = value;

  String get nome => this._nome;
  set nome(String value) => this._nome = value;

  String get especie => this._especie;
  set especie(String value) => this._especie = value;

  String get raca => this._raca;
  set raca(String value) => this._raca = value;

  String get sexo => this._sexo;
  set sexo(String value) => this._sexo = value;

  String get dataNascimento => this._dataNascimento;
  set dataNascimento(String value) => this._dataNascimento = value;

  PetImagesModel get petImages => this._petImages;
  set petImages(PetImagesModel value) => this._petImages = value;

  int get estado => this._estado;
  set estado(int value) => this._estado = value;
}
