// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aba_adocao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AbaAdocaoController on _AbaAdocaoControllerBase, Store {
  final _$isDogAtom = Atom(name: '_AbaAdocaoControllerBase.isDog');

  @override
  bool get isDog {
    _$isDogAtom.reportRead();
    return super.isDog;
  }

  @override
  set isDog(bool value) {
    _$isDogAtom.reportWrite(value, super.isDog, () {
      super.isDog = value;
    });
  }

  final _$isCatAtom = Atom(name: '_AbaAdocaoControllerBase.isCat');

  @override
  bool get isCat {
    _$isCatAtom.reportRead();
    return super.isCat;
  }

  @override
  set isCat(bool value) {
    _$isCatAtom.reportWrite(value, super.isCat, () {
      super.isCat = value;
    });
  }

  final _$isUpKeyBoardAtom =
      Atom(name: '_AbaAdocaoControllerBase.isUpKeyBoard');

  @override
  bool get isUpKeyBoard {
    _$isUpKeyBoardAtom.reportRead();
    return super.isUpKeyBoard;
  }

  @override
  set isUpKeyBoard(bool value) {
    _$isUpKeyBoardAtom.reportWrite(value, super.isUpKeyBoard, () {
      super.isUpKeyBoard = value;
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
  dynamic setIsDog(bool value) {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setIsDog');
    try {
      return super.setIsDog(value);
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsCat(bool value) {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setIsCat');
    try {
      return super.setIsCat(value);
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUpKeyBoard() {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setUpKeyBoard');
    try {
      return super.setUpKeyBoard();
    } finally {
      _$_AbaAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDownKeyBoard() {
    final _$actionInfo = _$_AbaAdocaoControllerBaseActionController.startAction(
        name: '_AbaAdocaoControllerBase.setDownKeyBoard');
    try {
      return super.setDownKeyBoard();
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
isDog: ${isDog},
isCat: ${isCat},
isUpKeyBoard: ${isUpKeyBoard},
isSearch: ${isSearch},
isOnlyONG: ${isOnlyONG}
    ''';
  }
}
