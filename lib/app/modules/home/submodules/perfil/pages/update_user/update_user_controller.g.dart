// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UpdateUserController on _UpdateUserControllerBase, Store {
  final _$isEmailValidAtom =
      Atom(name: '_UpdateUserControllerBase.isEmailValid');

  @override
  bool get isEmailValid {
    _$isEmailValidAtom.reportRead();
    return super.isEmailValid;
  }

  @override
  set isEmailValid(bool value) {
    _$isEmailValidAtom.reportWrite(value, super.isEmailValid, () {
      super.isEmailValid = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_UpdateUserControllerBase.isError');

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

  final _$_UpdateUserControllerBaseActionController =
      ActionController(name: '_UpdateUserControllerBase');

  @override
  dynamic setIsEmailValid(bool value) {
    final _$actionInfo = _$_UpdateUserControllerBaseActionController
        .startAction(name: '_UpdateUserControllerBase.setIsEmailValid');
    try {
      return super.setIsEmailValid(value);
    } finally {
      _$_UpdateUserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_UpdateUserControllerBaseActionController
        .startAction(name: '_UpdateUserControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_UpdateUserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEmailValid: ${isEmailValid},
isError: ${isError}
    ''';
  }
}
