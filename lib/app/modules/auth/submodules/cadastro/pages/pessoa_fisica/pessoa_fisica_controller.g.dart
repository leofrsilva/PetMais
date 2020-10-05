// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_fisica_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PessoaFisicaController on _PessoaFisicaControllerBase, Store {
  final _$imageAtom = Atom(name: '_PessoaFisicaControllerBase.image');

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

  final _$isErrorAtom = Atom(name: '_PessoaFisicaControllerBase.isError');

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

  final _$_PessoaFisicaControllerBaseActionController =
      ActionController(name: '_PessoaFisicaControllerBase');

  @override
  dynamic setImage(File value) {
    final _$actionInfo = _$_PessoaFisicaControllerBaseActionController
        .startAction(name: '_PessoaFisicaControllerBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_PessoaFisicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_PessoaFisicaControllerBaseActionController
        .startAction(name: '_PessoaFisicaControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_PessoaFisicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
isError: ${isError}
    ''';
  }
}
