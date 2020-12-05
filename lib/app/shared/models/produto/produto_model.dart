import 'package:flutter/material.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';

const String COLUMN_ID = "idproduto";
const String COLUMN_IDPETSHOP = "idpetshop";
const String COLUMN_CATEGORIA = "categoria";
const String COLUMN_NAMEPROD = "nomeProduto";
const String COLUMN_IMGPROD = "imagemProduto";
const String COLUMN_PRICE = "preco";
const String COLUMN_DESCONTO = "desconto";
const String COLUMN_ESTOQUE = "estoque";
const String COLUMN_DESCRICAO = "descricao";
const String COLUMN_DELIVERY = "entrega";
const String COLUMN_DATAREGISTRO = "dataRegistro";

const String COLUMN_NOMEEMPRESA = "nomePetshop";
const String COLUMN_ENDERECO = "endereco";
const String COLUMN_COMPLEMENTO = "complemento";

const String COLUMN_TELEFONE = "telefonePetshop";
const String COLUMN_TELEFONE2 = "segundoTelefonePetshop";
const String COLUMN_IMGSHOP = "imagemPetshop";
const String COLUMN_DESCRICAOSHOP = "petshopDescricao";

class ProdutoModel {
  int _id;
  int _idPetShop;
  String _categoria;
  String _nameProd;
  String _imgProd;
  double _price;
  double _desconto;
  int _estoque;
  String _descricao;
  int _delivery;
  String _dataRegistro;

  String _nomeEmpresa;
  String _endereco;
  String _complemento;
  String _telefone;
  String _telefone2;
  String _imgShop;
  String _descricaoPetShop;

  ProdutoModel({
    int id,
    int idPetShop,
    String cat,
    String name,
    String img,
    double price,
    double desconto,
    int estoque,
    String desc,
    int delivery,
    String data,
  }) {
    this._id = id;
    this._idPetShop = idPetShop;
    this._categoria = cat;
    this._nameProd = name;
    this._imgProd = img;
    this._price = price;
    this._desconto = desconto;
    this._estoque = estoque;
    this._descricao = desc;
    this._delivery = delivery;
    this._dataRegistro = data;
  }

  ProdutoModel.fromMap(Map map) {
    this.id = map[COLUMN_ID];
    this._idPetShop = map[COLUMN_IDPETSHOP];
    this._categoria = map[COLUMN_CATEGORIA];
    this._nameProd =  map[COLUMN_NAMEPROD];
    this._imgProd = UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_IMGPROD];
    this._price = double.tryParse(map[COLUMN_PRICE].toString());
    this._desconto = double.tryParse(map[COLUMN_DESCONTO].toString());
    this._estoque = int.tryParse(map[COLUMN_ESTOQUE].toString());
    this._descricao = map[COLUMN_DESCRICAO];
    this._delivery = int.tryParse(map[COLUMN_DELIVERY].toString());
    this._dataRegistro = map[COLUMN_DATAREGISTRO];

    this._nomeEmpresa = map[COLUMN_NOMEEMPRESA];
    this._endereco = map[COLUMN_ENDERECO];
    this._complemento = map[COLUMN_COMPLEMENTO];
    this.telefone = map[COLUMN_TELEFONE];
    this.telefone2 = map[COLUMN_TELEFONE2];
    this.imgShop = UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_IMGSHOP];
    this.descricaoPetShop = map[COLUMN_DESCRICAOSHOP];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      COLUMN_IDPETSHOP: this.idPetShop,
      COLUMN_CATEGORIA: this.categoria,
      COLUMN_NAMEPROD: this.nameProd,
      COLUMN_IMGPROD: this.imgProd,
      COLUMN_PRICE: this.price,
      COLUMN_DESCONTO: this.desconto,
      COLUMN_ESTOQUE: this.estoque,
      COLUMN_DESCRICAO: this.descricao,
      COLUMN_DELIVERY: this.delivery,
    };
    return map;
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      "nameProd": 120,
      "price": 10,
      "desconto": 10,
      "descricao": 215,
    };
    return result;
  }

  static List<String> categorias = [
    "Todos",
    "Alimentação",
    "Acessórios",
    "Serviço de Embelezamento",
    "Tosa",
    "Perfumaria",
    "Brinquedos",
  ];

  static List<DropdownMenuItem<String>> listCategorias() {
    return ProdutoModel.categorias.map((cat) {
      return DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
    }).toList();
  }

  int get id => this._id;
  set id(int value) => this._id = value;

  int get idPetShop => this._idPetShop;
  set idPetShop(int value) => this._idPetShop = value;

  String get categoria => this._categoria;
  set categoria(String value) => this._categoria = value;

  String get nameProd => this._nameProd;
  set nameProd(String value) => this._nameProd = value;

  String get imgProd => this._imgProd;
  set imgProd(String value) => this._imgProd = value;

  double get price => this._price;
  set price(double value) => this._price = value;

  double get desconto => this._desconto;
  set desconto(double value) => this._desconto = value;

  int get estoque => this._estoque;
  set estoque(int value) => this._estoque = value;

  String get descricao => this._descricao;
  set descricao(String value) => this._descricao = value;

  int get delivery => this._delivery;
  set delivery(int value) => this._delivery = value;

  String get dataRegistro => this._dataRegistro;
  set dataRegistro(String value) => this._dataRegistro = value;

  //*------------------------------------------------------------------
  String get nomeEmpresa => this._nomeEmpresa;
  set nomeEmpresa(String value) => this._nomeEmpresa = value;

  String get endereco => this._endereco;
  set endereco(String value) => this._endereco = value;

  String get complemento => this._complemento;
  set complemento(String value) => this._complemento = value;

  String get telefone => this._telefone;
  set telefone(String value) => this._telefone = value;

  String get telefone2 => this._telefone2;
  set telefone2(String value) => this._telefone2 = value;

  String get imgShop => this._imgShop;
  set imgShop(String value) => this._imgShop = value;

  String get descricaoPetShop => this._descricaoPetShop;
  set descricaoPetShop(String value) => this._descricaoPetShop = value;
}
