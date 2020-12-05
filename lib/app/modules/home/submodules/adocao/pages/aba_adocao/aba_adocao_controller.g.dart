// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aba_adocao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AbaAdocaoController on _AbaAdocaoControllerBase, Store {
  final _$especieSelectAtom =
      Atom(name: '_AbaAdocaoControllerBase.especieSelect');

  @override
  String get especieSelect {
    _$especieSelectAtom.reportRead();
    return super.especieSelect;
  }

  @override
  set especieSelect(String value) {
    _$especieSelectAtom.reportWrite(value, super.especieSelect, () {
      super.especieSelect = value;
    });
  }

  final _$racaSelectAtom = Atom(name: '_AbaAdocaoControllerBase.racaSelect');

  @override
  String get racaSelect {
    _$racaSelectAtom.reportRead();
    return super.racaSelect;
  }

  @override
  set racaSelect(String value) {
    _$racaSelectAtom.reportWrite(value, super.racaSelect, () {
      super.racaSelect = value;
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

  final _$isOnlyONGAtom = Atom(name: '_AbaAdocaoControllerBase.isOnlyONG');

  @override
  bool get isOnlyONG {
    _$isOnlyONGAtom.reportRead();
    return super.isOnlyONG;
  }

  @override
  set isOnlyONG(bool value) {
    _$isOnlyONGAtom.reportWrite(value, super.isOnlyONG, () {
      super.isOnlyONG = value;
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
  dynamic setEspecieSelect(String value) {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setEspecieSelect');
    try {
      return super.setEspecieSelect(value);
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRacaSelect(String value) {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setRacaSelect');
    try {
      return super.setRacaSelect(value);
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
  dynamic setIsOnlyONG(bool value) {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setIsOnlyONG');
    try {
      return super.setIsOnlyONG(value);
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
especieSelect: ${especieSelect},
racaSelect: ${racaSelect},
isSearch: ${isSearch},
isOnlyONG: ${isOnlyONG}
    ''';
  }
}
