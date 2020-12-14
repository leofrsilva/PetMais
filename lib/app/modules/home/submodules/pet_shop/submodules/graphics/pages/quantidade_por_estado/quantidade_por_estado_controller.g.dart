// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quantidade_por_estado_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuantidadePorEstadoController
    on _QuantidadePorEstadoControllerBase, Store {
  final _$touchedIndexAtom =
      Atom(name: '_QuantidadePorEstadoControllerBase.touchedIndex');

  @override
  int get touchedIndex {
    _$touchedIndexAtom.reportRead();
    return super.touchedIndex;
  }

  @override
  set touchedIndex(int value) {
    _$touchedIndexAtom.reportWrite(value, super.touchedIndex, () {
      super.touchedIndex = value;
    });
  }

  final _$_QuantidadePorEstadoControllerBaseActionController =
      ActionController(name: '_QuantidadePorEstadoControllerBase');

  @override
  dynamic setTouchedIndex(int value) {
    final _$actionInfo =
        _$_QuantidadePorEstadoControllerBaseActionController.startAction(
            name: '_QuantidadePorEstadoControllerBase.setTouchedIndex');
    try {
      return super.setTouchedIndex(value);
    } finally {
      _$_QuantidadePorEstadoControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
touchedIndex: ${touchedIndex}
    ''';
  }
}
