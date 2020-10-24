// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_comum_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginComumController on _LoginComumControllerBase, Store {
  final _$isVisibleBackgroundAtom =
      Atom(name: '_LoginComumControllerBase.isVisibleBackground');

  @override
  bool get isVisibleBackground {
    _$isVisibleBackgroundAtom.reportRead();
    return super.isVisibleBackground;
  }

  @override
  set isVisibleBackground(bool value) {
    _$isVisibleBackgroundAtom.reportWrite(value, super.isVisibleBackground, () {
      super.isVisibleBackground = value;
    });
  }

  final _$obscureTextAtom = Atom(name: '_LoginComumControllerBase.obscureText');

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_LoginComumControllerBase.isError');

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

  final _$isLoadingAtom = Atom(name: '_LoginComumControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$logarAsyncAction = AsyncAction('_LoginComumControllerBase.logar');

  @override
  Future<dynamic> logar() {
    return _$logarAsyncAction.run(() => super.logar());
  }

  final _$_LoginComumControllerBaseActionController =
      ActionController(name: '_LoginComumControllerBase');

  @override
  dynamic setIsVisibleBackground(bool value) {
    final _$actionInfo = _$_LoginComumControllerBaseActionController
        .startAction(name: '_LoginComumControllerBase.setIsVisibleBackground');
    try {
      return super.setIsVisibleBackground(value);
    } finally {
      _$_LoginComumControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setObscureText(bool value) {
    final _$actionInfo = _$_LoginComumControllerBaseActionController
        .startAction(name: '_LoginComumControllerBase.setObscureText');
    try {
      return super.setObscureText(value);
    } finally {
      _$_LoginComumControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_LoginComumControllerBaseActionController
        .startAction(name: '_LoginComumControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_LoginComumControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_LoginComumControllerBaseActionController
        .startAction(name: '_LoginComumControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_LoginComumControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isVisibleBackground: ${isVisibleBackground},
obscureText: ${obscureText},
isError: ${isError},
isLoading: ${isLoading}
    ''';
  }
}
