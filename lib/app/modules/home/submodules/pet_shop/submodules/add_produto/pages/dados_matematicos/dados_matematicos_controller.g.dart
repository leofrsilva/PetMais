// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_matematicos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DadosMatematicosController on _DadosMatematicosControllerBase, Store {
  final _$isDeliveryAtom =
      Atom(name: '_DadosMatematicosControllerBase.isDelivery');

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

  final _$isErrorAtom = Atom(name: '_DadosMatematicosControllerBase.isError');

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

  final _$_DadosMatematicosControllerBaseActionController =
      ActionController(name: '_DadosMatematicosControllerBase');

  @override
  dynamic setIsDelivery(bool value) {
    final _$actionInfo = _$_DadosMatematicosControllerBaseActionController
        .startAction(name: '_DadosMatematicosControllerBase.setIsDelivery');
    try {
      return super.setIsDelivery(value);
    } finally {
      _$_DadosMatematicosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_DadosMatematicosControllerBaseActionController
        .startAction(name: '_DadosMatematicosControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_DadosMatematicosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDelivery: ${isDelivery},
isError: ${isError}
    ''';
  }
}
