// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SplashController = BindInject(
  (i) => SplashController(i<AuthStore>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SplashController on _SplashControllerBase, Store {
  final _$isErrorConnectionAtom =
      Atom(name: '_SplashControllerBase.isErrorConnection');

  @override
  bool get isErrorConnection {
    _$isErrorConnectionAtom.reportRead();
    return super.isErrorConnection;
  }

  @override
  set isErrorConnection(bool value) {
    _$isErrorConnectionAtom.reportWrite(value, super.isErrorConnection, () {
      super.isErrorConnection = value;
    });
  }

  final _$_SplashControllerBaseActionController =
      ActionController(name: '_SplashControllerBase');

  @override
  void setIsErrorConnection(bool value) {
    final _$actionInfo = _$_SplashControllerBaseActionController.startAction(
        name: '_SplashControllerBase.setIsErrorConnection');
    try {
      return super.setIsErrorConnection(value);
    } finally {
      _$_SplashControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isErrorConnection: ${isErrorConnection}
    ''';
  }
}
