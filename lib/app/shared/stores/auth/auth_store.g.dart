// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  Computed<bool> _$isLoggedComputed;

  @override
  bool get isLogged => (_$isLoggedComputed ??=
          Computed<bool>(() => super.isLogged, name: '_AuthStoreBase.isLogged'))
      .value;

  final _$usuarioAtom = Atom(name: '_AuthStoreBase.usuario');

  @override
  UsuarioModel get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(UsuarioModel value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  final _$usuarioChatAtom = Atom(name: '_AuthStoreBase.usuarioChat');

  @override
  UsuarioChatModel get usuarioChat {
    _$usuarioChatAtom.reportRead();
    return super.usuarioChat;
  }

  @override
  set usuarioChat(UsuarioChatModel value) {
    _$usuarioChatAtom.reportWrite(value, super.usuarioChat, () {
      super.usuarioChat = value;
    });
  }

  final _$cryptoAesAtom = Atom(name: '_AuthStoreBase.cryptoAes');

  @override
  CryptoAes get cryptoAes {
    _$cryptoAesAtom.reportRead();
    return super.cryptoAes;
  }

  @override
  set cryptoAes(CryptoAes value) {
    _$cryptoAesAtom.reportWrite(value, super.cryptoAes, () {
      super.cryptoAes = value;
    });
  }

  final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase');

  @override
  dynamic setUser(UsuarioModel value) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserChat(UsuarioChatModel value) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setUserChat');
    try {
      return super.setUserChat(value);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCryptoAes(CryptoAes value) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setCryptoAes');
    try {
      return super.setCryptoAes(value);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usuario: ${usuario},
usuarioChat: ${usuarioChat},
cryptoAes: ${cryptoAes},
isLogged: ${isLogged}
    ''';
  }
}
