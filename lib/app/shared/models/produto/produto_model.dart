class ProdutoModel {
  int _id;
  String _categoria;
  String _nameProd;
  String _imgProd;
  double _price;
  double _desconto;
  int _estoque;
  String _descricao;
  bool _delivery;

  ProdutoModel({
    int id,
    String cat,
    String name,
    String img,
    double price,
    double desconto,
    int estoque,
    String desc,
    bool delivery,
  }) {
    this.id = id;
    this.categoria = cat;
    this.nameProd = name;
    this.imgProd = img;
    this.price = price;
    this.desconto = desconto;
    this.estoque = estoque;
    this.descricao = desc;
    this.delivery = delivery;
  }

  int get id => this._id;
  set id(int value) => this._id = value;

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

  bool get delivery => this._delivery;
  set delivery(bool value) => this._delivery = value;
}
