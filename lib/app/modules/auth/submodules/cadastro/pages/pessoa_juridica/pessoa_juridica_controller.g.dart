// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_juridica_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PessoaJuridicaController on _PessoaJuridicaControllerBase, Store {
  final _$isErrorAtom = Atom(name: '_PessoaJuridicaControllerBase.isError');

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

  final _$_PessoaJuridicaControllerBaseActionController =
      ActionController(name: '_PessoaJuridicaControllerBase');

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_PessoaJuridicaControllerBaseActionController
        .startAction(name: '_PessoaJuridicaControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_PessoaJuridicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isError: ${isError}
    ''';
  }
}
