// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aba_adocao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AbaAdocaoController on _AbaAdocaoControllerBase, Store {
  final _$especieAtom = Atom(name: '_AbaAdocaoControllerBase.especie');

  @override
  String get especie {
    _$especieAtom.reportRead();
    return super.especie;
  }

  @override
  set especie(String value) {
    _$especieAtom.reportWrite(value, super.especie, () {
      super.especie = value;
    });
  }

  final _$isSearchAtom = Atom(name: '_AbaAdocaoControllerBase.isSearch');

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

  final _$recuperarAdocoesAsyncAction =
      AsyncAction('_AbaAdocaoControllerBase.recuperarAdocoes');

  @override
  Future<List<PostAdocaoModel>> recuperarAdocoes() {
    return _$recuperarAdocoesAsyncAction.run(() => super.recuperarAdocoes());
  }

  final _$_AbaAdocaoControllerBaseActionController =
      ActionController(name: '_AbaAdocaoControllerBase');

  @override
  dynamic setEspecie(String value) {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setEspecie');
    try {
      return super.setEspecie(value);
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowSearch() {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setShowSearch');
    try {
      return super.setShowSearch();
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCloseSearch() {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setCloseSearch');
    try {
      return super.setCloseSearch();
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
especie: ${especie},
isSearch: ${isSearch}
    ''';
  }
}
