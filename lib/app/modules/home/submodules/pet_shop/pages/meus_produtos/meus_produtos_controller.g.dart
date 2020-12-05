// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meus_produtos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeusProdutosController on _MeusProdutosControllerBase, Store {
  final _$categoriaSelectAtom =
      Atom(name: '_MeusProdutosControllerBase.categoriaSelect');

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

  final _$isSearchAtom = Atom(name: '_MeusProdutosControllerBase.isSearch');

  @override
  bool get isSearch {
    _$isSearchAtom.reportRead();
    return super.isSearch;
  }

  @override
  set isSearch(bool value) {
    _$isSearchAtom.reportWrite(value, super.isSearch, () {
      super.isSearch = value;
    });
  }

  final _$recuperarProdPetShopAsyncAction =
      AsyncAction('_MeusProdutosControllerBase.recuperarProdPetShop');

  @override
  Future<List<ProdutoModel>> recuperarProdPetShop() {
    return _$recuperarProdPetShopAsyncAction
        .run(() => super.recuperarProdPetShop());
  }

  final _$_MeusProdutosControllerBaseActionController =
      ActionController(name: '_MeusProdutosControllerBase');

  @override
  dynamic setCategoriaSelect(String value) {
    final _$actionInfo = _$_MeusProdutosControllerBaseActionController
        .startAction(name: '_MeusProdutosControllerBase.setCategoriaSelect');
    try {
      return super.setCategoriaSelect(value);
    } finally {
      _$_MeusProdutosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowSearch() {
    final _$actionInfo = _$_MeusProdutosControllerBaseActionController
        .startAction(name: '_MeusProdutosControllerBase.setShowSearch');
    try {
      return super.setShowSearch();
    } finally {
      _$_MeusProdutosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCloseSearch() {
    final _$actionInfo = _$_MeusProdutosControllerBaseActionController
        .startAction(name: '_MeusProdutosControllerBase.setCloseSearch');
    try {
      return super.setCloseSearch();
    } finally {
      _$_MeusProdutosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoriaSelect: ${categoriaSelect},
isSearch: ${isSearch}
    ''';
  }
}
