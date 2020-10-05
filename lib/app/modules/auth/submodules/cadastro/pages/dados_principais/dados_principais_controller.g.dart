// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_principais_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DadosPrincipaisController on _DadosPrincipaisControllerBase, Store {
  final _$isEmailValidAtom =
      Atom(name: '_DadosPrincipaisControllerBase.isEmailValid');

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

  final _$obscureTextAtom =
      Atom(name: '_DadosPrincipaisControllerBase.obscureText');

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

  final _$obscureTextConfAtom =
      Atom(name: '_DadosPrincipaisControllerBase.obscureTextConf');

  @override
  bool get obscureTextConf {
    _$obscureTextConfAtom.reportRead();
    return super.obscureTextConf;
  }

  @override
  set obscureTextConf(bool value) {
    _$obscureTextConfAtom.reportWrite(value, super.obscureTextConf, () {
      super.obscureTextConf = value;
    });
  }

  final _$typeUserAtom = Atom(name: '_DadosPrincipaisControllerBase.typeUser');

  @override
  TypeUser get typeUser {
    _$typeUserAtom.reportRead();
    return super.typeUser;
  }

  @override
  set typeUser(TypeUser value) {
    _$typeUserAtom.reportWrite(value, super.typeUser, () {
      super.typeUser = value;
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

  final _$isLoadingAtom =
      Atom(name: '_DadosPrincipaisControllerBase.isLoading');

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

  final _$_DadosPrincipaisControllerBaseActionController =
      ActionController(name: '_DadosPrincipaisControllerBase');

  @override
  dynamic setIsEmailValid(bool value) {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setIsEmailValid');
    try {
      return super.setIsEmailValid(value);
    } finally {
      _$_DadosPrincipaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setObscureText() {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setObscureText');
    try {
      return super.setObscureText();
    } finally {
      _$_DadosPrincipaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setObscureTextConf() {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setObscureTextConf');
    try {
      return super.setObscureTextConf();
    } finally {
      _$_DadosPrincipaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTypeUser(TypeUser type) {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setTypeUser');
    try {
      return super.setTypeUser(type);
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
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_DadosPrincipaisControllerBaseActionController
        .startAction(name: '_DadosPrincipaisControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_DadosPrincipaisControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEmailValid: ${isEmailValid},
obscureText: ${obscureText},
obscureTextConf: ${obscureTextConf},
typeUser: ${typeUser},
isError: ${isError},
isLoading: ${isLoading}
    ''';
  }
}
