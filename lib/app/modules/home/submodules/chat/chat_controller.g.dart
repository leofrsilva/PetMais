// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ChatController = BindInject(
  (i) => ChatController(i<AuthStore>(), i<FirestoreChatRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_ChatControllerBase.isLoading');

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

  final _$isSelectedImageAtom =
      Atom(name: '_ChatControllerBase.isSelectedImage');

  @override
  bool get isSelectedImage {
    _$isSelectedImageAtom.reportRead();
    return super.isSelectedImage;
  }

  @override
  set isSelectedImage(bool value) {
    _$isSelectedImageAtom.reportWrite(value, super.isSelectedImage, () {
      super.isSelectedImage = value;
    });
  }

  final _$_ChatControllerBaseActionController =
      ActionController(name: '_ChatControllerBase');

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedImage(bool value) {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.setSelectedImage');
    try {
      return super.setSelectedImage(value);
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isSelectedImage: ${isSelectedImage}
    ''';
  }
}
