// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_principais_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DadosPrincipaisController on _DadosPrincipaisControllerBase, Store {
  final _$categoriaSelectAtom =
      Atom(name: '_DadosPrincipaisControllerBase.categoriaSelect');

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

  final _$imageAtom = Atom(name: '_DadosPrincipaisControllerBase.image');

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

  final _$isErrorAtom = Atom(name: '_DadosPrincipaisControllerBase.isError');

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

  final _$_DadosPrincipaisControllerBaseActionController =
      ActionController(name: '_DadosPrincipaisControllerBase');

  @override
  dynamic setCategoriaSelect(String value) {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setCategoriaSelect');
    try {
      return super.setCategoriaSelect(value);
    } finally {
      _$_DadosPrincipaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImage(File value) {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_DadosPrincipaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_DadosPrincipaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoriaSelect: ${categoriaSelect},
image: ${image},
isError: ${isError}
    ''';
  }
}
