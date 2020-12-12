// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UpdateProdutoController on _UpdateProdutoControllerBase, Store {
  final _$categoriaSelectAtom =
      Atom(name: '_UpdateProdutoControllerBase.categoriaSelect');

  @override
  String get categoriaSelect {
    _$categoriaSelectAtom.reportRead();
    return super.categoriaSelect;
  }

  @override
  set categoriaSelect(String value) {
    _$categoriaSelectAtom.reportWrite(value, super.categoriaSelect, () {
      super.categoriaSelect = value;
    });
  }

  final _$quantAtom = Atom(name: '_UpdateProdutoControllerBase.quant');

  @override
  double get quant {
    _$quantAtom.reportRead();
    return super.quant;
  }

  @override
  set quant(double value) {
    _$quantAtom.reportWrite(value, super.quant, () {
      super.quant = value;
    });
  }

  final _$isDeliveryAtom =
      Atom(name: '_UpdateProdutoControllerBase.isDelivery');

  @override
  bool get isDelivery {
    _$isDeliveryAtom.reportRead();
    return super.isDelivery;
  }

  @override
  set isDelivery(bool value) {
    _$isDeliveryAtom.reportWrite(value, super.isDelivery, () {
      super.isDelivery = value;
    });
  }

  final _$imageAtom = Atom(name: '_UpdateProdutoControllerBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_UpdateProdutoControllerBase.isError');

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  final _$_UpdateProdutoControllerBaseActionController =
      ActionController(name: '_UpdateProdutoControllerBase');

  @override
  dynamic setCategoriaSelect(String value) {
    final _$actionInfo = _$_UpdateProdutoControllerBaseActionController
        .startAction(name: '_UpdateProdutoControllerBase.setCategoriaSelect');
    try {
      return super.setCategoriaSelect(value);
    } finally {
      _$_UpdateProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQuantidade(double value) {
    final _$actionInfo = _$_UpdateProdutoControllerBaseActionController
        .startAction(name: '_UpdateProdutoControllerBase.setQuantidade');
    try {
      return super.setQuantidade(value);
    } finally {
      _$_UpdateProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsDelivery(bool value) {
    final _$actionInfo = _$_UpdateProdutoControllerBaseActionController
        .startAction(name: '_UpdateProdutoControllerBase.setIsDelivery');
    try {
      return super.setIsDelivery(value);
    } finally {
      _$_UpdateProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImage(File value) {
    final _$actionInfo = _$_UpdateProdutoControllerBaseActionController
        .startAction(name: '_UpdateProdutoControllerBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_UpdateProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_UpdateProdutoControllerBaseActionController
        .startAction(name: '_UpdateProdutoControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_UpdateProdutoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoriaSelect: ${categoriaSelect},
quant: ${quant},
isDelivery: ${isDelivery},
image: ${image},
isError: ${isError}
    ''';
  }
}
