import 'package:flutter/material.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';

const String COLUMN_ID = "idProduto";
const String COLUMN_IDPETSHOP = "idPetshop";
const String COLUMN_CATEGORIA = "categoria";
const String COLUMN_NAMEPROD = "nomeProduto";
const String COLUMN_IMGPROD = "imagemProduto";
const String COLUMN_PRICE = "preco";
const String COLUMN_DESCONTO = "desconto";
const String COLUMN_ESTOQUE = "estoque";
const String COLUMN_DESCRICAO = "descricao";
const String COLUMN_DELIVERY = "entrega";
const String COLUMN_VALORKM = "valorKm";
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
  double _valorKm;
  String _dataRegistro;

  DateTime get data => DateTime.tryParse(this.dataRegistro);

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
    double valKm,
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
    this._valorKm = valKm;
    this._dataRegistro = data;
  }

  ProdutoModel.fromMap(Map map) {
    this.id = map[COLUMN_ID];
    this._idPetShop = map[COLUMN_IDPETSHOP];
    this._categoria = map[COLUMN_CATEGORIA];
    this._nameProd = map[COLUMN_NAMEPROD];
    this._imgProd =
        UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_IMGPROD];
    this._price = double.tryParse(map[COLUMN_PRICE].toString());
    this._desconto = double.tryParse(map[COLUMN_DESCONTO].toString());
    this._estoque = int.tryParse(map[COLUMN_ESTOQUE].toString());
    this._descricao = map[COLUMN_DESCRICAO];
    this._delivery = int.tryParse(map[COLUMN_DELIVERY].toString());
    this._valorKm = double.tryParse(map[COLUMN_VALORKM].toString());
    this._dataRegistro = map[COLUMN_DATAREGISTRO];

    this._nomeEmpresa = map[COLUMN_NOMEEMPRESA];
    this._endereco = map[COLUMN_ENDERECO];
    this._complemento = map[COLUMN_COMPLEMENTO];
    this.telefone = map[COLUMN_TELEFONE];
    this.telefone2 = map[COLUMN_TELEFONE2];
    this.imgShop =
        UsuarioRemoteRepository.URL + "/files/" + map[COLUMN_IMGSHOP];
    this.descricaoPetShop = map[COLUMN_DESCRICAOSHOP];
  }

  Map<String, dynamic> toMapRegistrer() {
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
      COLUMN_VALORKM: this.valorKm,
      COLUMN_DATAREGISTRO: this.dataRegistro,
    };
    return map;
  }

  Map<String, dynamic> toMapUpdate(){
    Map<String, dynamic> map = {
      COLUMN_ID: this.id,
      COLUMN_IDPETSHOP: this.idPetShop,
      COLUMN_CATEGORIA: this.categoria,
      COLUMN_NAMEPROD: this.nameProd,
      COLUMN_DESCRICAO: this.descricao,
      COLUMN_PRICE: this.price,
      COLUMN_DESCONTO: this.desconto,
      COLUMN_ESTOQUE: this.estoque,
      COLUMN_DELIVERY: this.delivery,
    };
    return map;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      COLUMN_ID: this.id,
      COLUMN_IDPETSHOP: this.idPetShop,
      COLUMN_CATEGORIA: this.categoria,
      COLUMN_NAMEPROD: this.nameProd,
      COLUMN_IMGPROD: this.imgProd,
      COLUMN_PRICE: this.price,
      COLUMN_DESCONTO: this.desconto,
      COLUMN_ESTOQUE: this.estoque,
      COLUMN_DESCRICAO: this.descricao,
      COLUMN_DELIVERY: this.delivery,
      COLUMN_VALORKM: this.valorKm,
      COLUMN_DATAREGISTRO: this.dataRegistro,
      COLUMN_NOMEEMPRESA: this.nomeEmpresa,
      COLUMN_ENDERECO: this.endereco,
      COLUMN_COMPLEMENTO: this.complemento,
      COLUMN_TELEFONE: this.telefone,
      COLUMN_TELEFONE2: this.telefone2,
      COLUMN_IMGSHOP: this.imgShop,
      COLUMN_DESCRICAOSHOP: this.descricaoPetShop,
    };
    return map;
  }

  static Map<String, int> toNumCaracteres() {
    Map<String, int> result = {
      "nameProd": 120,
      "price": 11,
      "desconto": 8,
      "valoKm": 9,
      "descricao": 215,
    };
    return result;
  }

  static List<String> categoriasAux = [
    "Mantimentos",
    "Rações",
    "Acessórios",
    "Embelezamento",
    "Tosa",
    "Perfumaria",
    "Brinquedos",
    "Outros",
  ];

  static List<DropdownMenuItem<String>> listCategoriasProd() {
    return ProdutoModel.categoriasAux.map((cat) {
      return DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
    }).toList();
  }

  static List<String> categorias = [
    "Todos",
    "Mantimentos",
    "Rações",
    "Acessórios",
    "Embelezamento",
    "Tosa",
    "Perfumaria",
    "Brinquedos",
    "Outros",
  ];

  static List<DropdownMenuItem<String>> listCategorias() {
    return ProdutoModel.categorias.map((cat) {
      return DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
    }).toList();
  }

  static List<Map<String, String>> listIconCategorias = [
    {"type": "icon", "title": "Todos", "img": ""},
    {"type": "image", "title": "Mantimentos", "img": "assets/images/categorias/mantimento.png"},
    {"type": "image", "title": "Rações", "img": "assets/images/categorias/racao.png"},
    {"type": "image", "title": "Acessórios", "img": "assets/images/categorias/acessorios.png"},
    {"type": "image", "title": "Tosa", "img": "assets/images/categorias/tosa.png"},
    {"type": "image", "title": "Perfumaria", "img": "assets/images/categorias/perfumaria.png"},
    {"type": "image", "title": "Brinquedos", "img": "assets/images/categorias/brinquedos.png"},
    {"type": "icon", "title": "Outros", "img": ""},
  ];

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

  double get valorKm => this._valorKm;
  set valorKm(double value) => this._valorKm = value;

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