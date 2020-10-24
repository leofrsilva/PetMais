// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AuthController = BindInject(
  (i) => AuthController(i<AuthStore>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  final _$entrarAsyncAction = AsyncAction('_AuthControllerBase.entrar');

  @override
  Future<String> entrar({String email, String senha, String type}) {
    return _$entrarAsyncAction
        .run(() => super.entrar(email: email, senha: senha, type: type));
  }

  final _$cadastrarAsyncAction = AsyncAction('_AuthControllerBase.cadastrar');

  @override
  Future<String> cadastrar(
      UsuarioModel usuarioModel, File image, bool isLoading) {
    return _$cadastrarAsyncAction
        .run(() => super.cadastrar(usuarioModel, image, isLoading));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
