import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';

const String COLUMN_ID = "id";
const String COLUMN_QUANTIDADE = "quantidade";
const String COLUMN_TOTAL = "total";
const String COLUMN_VALORENTREGA = "valor_entrega";
const String COLUMN_TIPO = "tipo";
const String COLUMN_CODIGO = "codigo";
const String COLUMN_DATAPEDIDO = "data_pedido";
const String COLUMN_DATAENTREGA = "data_entrega";
const String COLUMN_ENDERECO = "endereco";
const String COLUMN_COMPLEMENTO = "complemento";
const String COLUMN_ESTADO = "estado";
const String COLUMN_IDUSERCOMUM = "idUserComum";
const String COLUMN_IDPRODUTO = "idProduto";

const String COLUMN_NOMEPROD = "nomeProduto";
const String COLUMN_IMGPROD = "imagemProduto";
const String COLUMN_IDPETSHOP = "idPetshop";
const String COLUMN_NOMEPETSHOP = "nomePetshop";
const String COLUMN_ENDERECOPETSHOP = "enderecoPetshop";
const String COLUMN_EMPRODUCAO = "emProducao";

class PedidoModel {
  int _id;
  int _quantidade;
  double _total;
  double _valorEntrega;
  String _tipo;
  String _codigo;
  String _dataPedido;
  String _dataEntrega;
  String _endereco;
  String _complemento;
  String _estado;
  int _idUserComum;
  int _idProduto;
  String _nomeProduto;
  String _imagemProduto;
  int _idPetshop;
  String _nomePetshop;
  String _enderecoPetshop;
  int _emProducao;

  DateTime get datePed => DateTime.tryParse(this.dataPedido);
  DateTime get dateEnt => DateTime.tryParse(this.dataEntrega);

  String formatarData(String data) {
    initializeDateFormatting("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    //var formatter = DateFormat("d/M/y");
    var formatter = DateFormat.yMd("pt_BR");

    String dataFomatada = formatter.format(dataConvertida);
    return dataFomatada;
  }

  PedidoModel(
      {int id,
      int quantidade,
      double total,
      double valEntrega,
      String tipo,
      String codigo,
      String dataPedido,
      String dataEntrega,
      String endereco,
      String comp,
      String estado,
      int idUserComum,
      int idProduto}) {
    this._id = id;
    this._quantidade = quantidade;
    this._total = total;
    this._valorEntrega = valEntrega;
    this._tipo = tipo;
    this._codigo = codigo;
    this._dataPedido = dataPedido;
    this._dataEntrega = dataEntrega;
    this._endereco = endereco;
    this._complemento = comp;
    this._estado = estado;
    this._idUserComum = idUserComum;
    this._idProduto = idProduto;
  }

  int get id => _id;
  set id(int value) => this._id = value;

  int get quantidade => _quantidade;
  set quantidade(int value) => this._quantidade = value;

  double get total => _total;
  set total(double value) => this._total = value;

  double get valorEntrega => _valorEntrega;
  set valorEntrega(double value) => this._valorEntrega = value;

  String get tipo => _tipo;
  set tipo(String value) => this._tipo = value;

  String get codigo => _codigo;
  set codigo(String value) => this._codigo = value;

  String get dataPedido => _dataPedido;
  set dataPedido(String value) => this._dataPedido = value;

  String get dataEntrega => _dataEntrega;
  set dataEntrega(String value) => this._dataEntrega = value;

  String get endereco => _endereco;
  set endereco(String value) => this._endereco = value;

  String get complemento => _complemento;
  set complemento(String value) => this._complemento = value;

  String get estado => _estado;
  set estado(String value) => this._estado = value;

  int get idUserComum => _idUserComum;
  set idUserComum(int value) => this._idUserComum = value;

  int get idProduto => _idProduto;
  set idProduto(int value) => this._idProduto = value;

  int get idPetshop => _idPetshop;
  set idPetshop(int value) => this._idPetshop = value;

  String get nomePetshop => _nomePetshop;
  set nomePetshop(String value) => this._nomePetshop = value;

  String get nomeProduto => _nomeProduto;
  set nomeProduto(String value) => this._nomeProduto = value;

  String get imagemProduto => _imagemProduto;
  set imagemProduto(String value) => this._imagemProduto = value;

  String get enderecoPetshop => _enderecoPetshop;
  set enderecoPetshop(String value) => this._enderecoPetshop = value;

  int get emProducao => _emProducao;
  set emProducao(int value) => this._emProducao = value;

  PedidoModel.fromMap(Map<String, dynamic> json) {
    _id = json[COLUMN_ID];
    _quantidade = json[COLUMN_QUANTIDADE];
    _total = double.tryParse(json[COLUMN_TOTAL].toString());
    _valorEntrega = double.tryParse(json[COLUMN_VALORENTREGA].toString());
    _tipo = json[COLUMN_TIPO];
    _codigo = json[COLUMN_CODIGO];
    _dataPedido = json[COLUMN_DATAPEDIDO];
    _dataEntrega = json[COLUMN_DATAENTREGA];
    _endereco = json[COLUMN_ENDERECO];
    _complemento = json[COLUMN_COMPLEMENTO];
    _estado = json[COLUMN_ESTADO];
    _idUserComum = json[COLUMN_IDUSERCOMUM];
    _idProduto = json[COLUMN_IDPRODUTO];
    _nomeProduto = json[COLUMN_NOMEPROD];
    _imagemProduto = UsuarioRemoteRepository.URL + "/files/" + json[COLUMN_IMGPROD];
    _idPetshop = json[COLUMN_IDPETSHOP];
    _nomePetshop = json[COLUMN_NOMEPETSHOP];
    _enderecoPetshop = json[COLUMN_ENDERECOPETSHOP];
    _emProducao = int.tryParse(json[COLUMN_EMPRODUCAO]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[COLUMN_ID] = this._id;
    data[COLUMN_QUANTIDADE] = this._quantidade;
    data[COLUMN_TOTAL] = this._total;
    data[COLUMN_TIPO] = this._tipo;
    data[COLUMN_CODIGO] = this._codigo;
    data[COLUMN_DATAPEDIDO] = this._dataPedido;
    data[COLUMN_DATAENTREGA] = this._dataEntrega;
    data[COLUMN_ENDERECO] = this._endereco;
    data[COLUMN_ESTADO] = this._estado;
    data[COLUMN_IDUSERCOMUM] = this._idUserComum;
    data[COLUMN_IDPRODUTO] = this._idProduto;
    data[COLUMN_NOMEPROD] = this.nomeProduto;
    data[COLUMN_IMGPROD] = this.imagemProduto;
    data[COLUMN_IDPETSHOP] = this.idPetshop;
    data[COLUMN_NOMEPETSHOP] = this.nomePetshop;
    return data;
  }

  Map<String, dynamic> toMapNotEntrega() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[COLUMN_QUANTIDADE] = this._quantidade;
    data[COLUMN_TOTAL] = this._total;
    data[COLUMN_TIPO] = this._tipo;
    data[COLUMN_DATAPEDIDO] = this._dataPedido;
    data[COLUMN_IDUSERCOMUM] = this._idUserComum;
    data[COLUMN_IDPRODUTO] = this._idProduto;
    return data;
  }
  Map<String, dynamic> toMapEntrega() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[COLUMN_QUANTIDADE] = this._quantidade;
    data[COLUMN_TOTAL] = this._total;
    data[COLUMN_VALORENTREGA] = this._valorEntrega;
    data[COLUMN_TIPO] = this._tipo;
    data[COLUMN_DATAPEDIDO] = this._dataPedido;
    data[COLUMN_ENDERECO] = this._endereco;
    data[COLUMN_COMPLEMENTO] = this._complemento;
    data[COLUMN_IDUSERCOMUM] = this._idUserComum;
    data[COLUMN_IDPRODUTO] = this._idProduto;
    return data;
  }
}
