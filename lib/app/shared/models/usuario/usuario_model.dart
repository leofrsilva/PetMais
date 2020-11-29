import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';

import 'usuario_info_model.dart';

import 'usuario_info_juridico_model.dart';

const String COLUMN_EMAIL = "email";
const String COLUMN_SENHA = "senha";
const String COLUMN_TIPOUSUARIO = "tipoUsuario";

enum TypeUser {
  fisica,
  juridica,
}

class UsuarioModel {
  String _email;
  String _senha;
  String _typeUser;
  dynamic _usuarioInfo;

  UsuarioModel({String email, String senha, TypeUser type}) {
    this.email = email;
    this.senha = senha;
    this.typeUser = type ?? TypeUser.fisica;
  }

  UsuarioModel.fromMap(Map map) {
    this.email = map[COLUMN_EMAIL];
    this.senha = map[COLUMN_SENHA];
    this.typeUser = map[COLUMN_TIPOUSUARIO] == "fisica"
        ? TypeUser.fisica
        : TypeUser.juridica;
    this.usuarioInfo = map[COLUMN_TIPOUSUARIO] == "fisica"
        ? UsuarioInfoModel.fromMap(map)
        : UsuarioInfoJuridicoModel.fromMap(map);
  }

  Map<String, dynamic> toMapFisico() {
    Map<String, dynamic> map = {
      COLUMN_EMAIL: this._email,
      COLUMN_SENHA: this._senha,
      COLUMN_TIPOUSUARIO: this._typeUser,
      COLUMN_NOME: (this.usuarioInfo as UsuarioInfoModel).nome,
      COLUMN_SOBRENOME: (this.usuarioInfo as UsuarioInfoModel).sobreNome,
      COLUMN_DATANASCIMENTO:
          (this.usuarioInfo as UsuarioInfoModel).dataNascimento,
      COLUMN_NUMEROTELEFONE:
          (this.usuarioInfo as UsuarioInfoModel).numeroTelefone,
      COLUMN_URLFOTO: this.usuarioInfo.urlFoto,
    };
    return map;
  }

  Map<String, dynamic> toMapJuridico() {
    Map<String, dynamic> map = {
      COLUMN_EMAIL: this._email,
      COLUMN_SENHA: this._senha,
      COLUMN_TIPOUSUARIO: this._typeUser,
      COLUMN_CNPJ: (this.usuarioInfo as UsuarioInfoJuridicoModel).cnpj,
      COLUMN_NOMEORG: (this.usuarioInfo as UsuarioInfoJuridicoModel).nomeOrg,
      COLUMN_TELEFONE1:
          (this.usuarioInfo as UsuarioInfoJuridicoModel).telefone1,
      COLUMN_TELEFONE2:
          (this.usuarioInfo as UsuarioInfoJuridicoModel).telefone2,
      COLUMN_DESCRICAO:
          (this.usuarioInfo as UsuarioInfoJuridicoModel).descricao,
      COLUMN_TYPEJURIDICO:
          (this.usuarioInfo as UsuarioInfoJuridicoModel).typeJuridico ==
                  TypeJuridico.ong
              ? "ong"
              : "shop",
      COLUMN_FOTOURL: (this.usuarioInfo as UsuarioInfoJuridicoModel).urlFoto,
    };
    map.addAll((this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.toMap());
    return map;
  }

  Map<String, dynamic> toMapUpdateFisico() {
    Map<String, dynamic> map = {
      COLUMN_EMAIL: this._email,
      COLUMN_IDF: (this.usuarioInfo as UsuarioInfoModel).id,
      COLUMN_NOME: (this.usuarioInfo as UsuarioInfoModel).nome,
      COLUMN_SOBRENOME: (this.usuarioInfo as UsuarioInfoModel).sobreNome,
      COLUMN_DATANASCIMENTO:
          (this.usuarioInfo as UsuarioInfoModel).dataNascimento,
      COLUMN_NUMEROTELEFONE:
          (this.usuarioInfo as UsuarioInfoModel).numeroTelefone,
    };
    return map;
  }

  Map<String, dynamic> toMapUpdateJuridico() {
    Map<String, dynamic> map = {
      COLUMN_EMAIL: this.email,
      COLUMN_IDJ: (this.usuarioInfo as UsuarioInfoJuridicoModel).id,
      COLUMN_NOMEORG: (this.usuarioInfo as UsuarioInfoJuridicoModel).nomeOrg,
      COLUMN_TELEFONE1: (this.usuarioInfo as UsuarioInfoJuridicoModel).telefone1,
      COLUMN_TELEFONE2: (this.usuarioInfo as UsuarioInfoJuridicoModel).telefone2,
      COLUMN_CIDADE: (this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.cidade,
      COLUMN_ESTADO: (this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.estado ,
      COLUMN_FOTOURL: (this.usuarioInfo as UsuarioInfoJuridicoModel).urlFoto,
      COLUMN_DESCRICAO: (this.usuarioInfo as UsuarioInfoJuridicoModel).descricao,
      COLUMN_TYPEJURIDICO: (this.usuarioInfo as UsuarioInfoJuridicoModel).typeJuridico,
      COLUMN_RUA: (this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.rua,
      COLUMN_NUMERO: (this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.numero,
      COLUMN_BAIRRO: (this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.bairro,
      COLUMN_CEP: (this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.cep,
      COLUMN_COMPLEMENTO: (this.usuarioInfo as UsuarioInfoJuridicoModel).endereco.complemento,
    };
    return map;
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      "email": 30,
      "senha": 10,
    };
    return result;
  }

  void reset() {
    this.email = null;
    this.senha = null;
    this.typeUser = null;
    this.usuarioInfo = null;
  }

  String get email => this._email;
  set email(String value) => this._email = value;

  String get senha => this._senha;
  set senha(String value) => this._senha = value;

  dynamic get usuarioInfo => this._usuarioInfo;
  set usuarioInfo(dynamic value) => this._usuarioInfo = value;

  TypeUser get typeUser =>
      this._typeUser == "fisica" ? TypeUser.fisica : TypeUser.juridica;
  set typeUser(TypeUser value) =>
      this._typeUser = (value == TypeUser.fisica ? "fisica" : "juridica");
}
