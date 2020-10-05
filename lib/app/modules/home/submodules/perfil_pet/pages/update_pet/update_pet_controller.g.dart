// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_pet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UpdatePetController on _UpdatePetControllerBase, Store {
  final _$isErrorAtom = Atom(name: '_UpdatePetControllerBase.isError');

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

  final _$valueSexoAtom = Atom(name: '_UpdatePetControllerBase.valueSexo');

  @override
  String get valueSexo {
    _$valueSexoAtom.reportRead();
    return super.valueSexo;
  }

  @override
  set valueSexo(String value) {
    _$valueSexoAtom.reportWrite(value, super.valueSexo, () {
      super.valueSexo = value;
    });
  }

  final _$_UpdatePetControllerBaseActionController =
      ActionController(name: '_UpdatePetControllerBase');

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_UpdatePetControllerBaseActionController.startAction(
        name: '_UpdatePetControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_UpdatePetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSexo(String value) {
    final _$actionInfo = _$_UpdatePetControllerBaseActionController.startAction(
        name: '_UpdatePetControllerBase.setSexo');
    try {
      return super.setSexo(value);
    } finally {
      _$_UpdatePetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isError: ${isError},
valueSexo: ${valueSexo}
    ''';
  }
}
