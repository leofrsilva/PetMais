import 'dart:core';
import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';

enum TypeJuridico {
  ong,
  petshop,
}

const String COLUMN_IDJ = "id";
const String COLUMN_CNPJ = "cnpj";
const String COLUMN_NOMEORG = "nomeEmpresa";
const String COLUMN_FOTOURL = "fotoURL";
const String COLUMN_TELEFONE1 = "telefone";
const String COLUMN_TELEFONE2 = "telefone2";
const String COLUMN_DESCRICAO = "descricao";
const String COLUMN_TYPEJURIDICO = "tipo";

class UsuarioInfoJuridicoModel {
  String _urlFoto;
  int _id;
  String _cnpj;
  String _nomeOrg;
  String _telefone1;
  String _telefone2;
  String _descricao;
  DadosEnderecoModel _endereco;
  TypeJuridico _typeJuridico;

  UsuarioInfoJuridicoModel({
    String urlFoto,
    int identifier,
    String cnpj,
    String nome,
    String tel1,
    String tel2,
    String desc,
    DadosEnderecoModel endereco,
    TypeJuridico type,
  }) {
    this.id = identifier ?? 0;
    this._urlFoto = urlFoto;
    this._cnpj = cnpj;
    this._nomeOrg = nome;
    this._telefone1 = tel1;
    this._telefone2 = tel2;
    this._descricao = desc;
    this._endereco = endereco;
    this._typeJuridico = type;
  }

  UsuarioInfoJuridicoModel.fromMap(Map map) {
    this.id = int.tryParse(map[COLUMN_IDJ].toString());
    this._urlFoto = map[COLUMN_FOTOURL] == "No Photo"
        ? map[COLUMN_FOTOURL]
        : UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_FOTOURL];
    this._cnpj = map[COLUMN_CNPJ];
    this._nomeOrg = map[COLUMN_NOMEORG];
    this._telefone1 = map[COLUMN_TELEFONE1];
    this._telefone2 = map[COLUMN_TELEFONE2];
    this._descricao = map[COLUMN_DESCRICAO];
    this._typeJuridico = map[COLUMN_TYPEJURIDICO] == "ong"
        ? TypeJuridico.ong
        : TypeJuridico.petshop;
    this.endereco = DadosEnderecoModel.fromMap(map);
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      COLUMN_CNPJ: 18,
      COLUMN_NOMEORG: 50,
      COLUMN_FOTOURL: 150,
      COLUMN_TELEFONE1: 14,
      COLUMN_TELEFONE2: 14,
      COLUMN_DESCRICAO: 215,
    };
    return result;
  }

  String get formatterCnpj {
    String newCnpj = "";
    for (int i = 0; i < this.cnpj.length; i++) {
      if ([1, 4].contains(i)) {
        newCnpj += this.cnpj[i] + ".";
      } else if (i == 7) {
        newCnpj += this.cnpj[i] + "/";
      } else if (i == 11) {
        newCnpj += this.cnpj[i] + "-";
      } else {
        newCnpj += this.cnpj[i];
      }
    }
    return newCnpj;
  }

  String get urlFoto => this._urlFoto;
  set urlFoto(String value) => this._urlFoto = value;

  int get id => this._id;
  set id(int value) => this._id = value;

  String get cnpj => this._cnpj;
  String get formCnpj => this.formatterCnpj;
  set cnpj(String value) => this._cnpj = value;

  String get nomeOrg => this._nomeOrg;
  set nomeOrg(String value) => this._nomeOrg = value;

  String get telefone1 => this._telefone1;
  set telefone1(String value) => this._telefone1 = value;

  String get telefone2 => this._telefone2;
  set telefone2(String value) => this._telefone2 = value;

  String get descricao => this._descricao;
  set descricao(String value) => this._descricao = value;

  DadosEnderecoModel get endereco => this._endereco;
  set endereco(DadosEnderecoModel value) => this._endereco = value;

  TypeJuridico get typeJuridico => this._typeJuridico;
  set typeJuridico(TypeJuridico value) => this._typeJuridico = value;
}
