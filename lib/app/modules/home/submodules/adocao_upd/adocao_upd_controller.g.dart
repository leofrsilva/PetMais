// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adocao_upd_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdocaoUpdController on _AdocaoUpdControllerBase, Store {
  final _$imageAtom = Atom(name: '_AdocaoUpdControllerBase.image');

  @override
  Widget get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(Widget value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_AdocaoUpdControllerBase.isError');

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

  final _$petAtom = Atom(name: '_AdocaoUpdControllerBase.pet');

  @override
  PostAdocaoModel get pet {
    _$petAtom.reportRead();
    return super.pet;
  }

  @override
  set pet(PostAdocaoModel value) {
    _$petAtom.reportWrite(value, super.pet, () {
      super.pet = value;
    });
  }

  final _$_AdocaoUpdControllerBaseActionController =
      ActionController(name: '_AdocaoUpdControllerBase');

  @override
  dynamic setImage(Widget value) {
    final _$actionInfo = _$_AdocaoUpdControllerBaseActionController.startAction(
        name: '_AdocaoUpdControllerBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_AdocaoUpdControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_AdocaoUpdControllerBaseActionController.startAction(
        name: '_AdocaoUpdControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_AdocaoUpdControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPet(PostAdocaoModel value) {
    final _$actionInfo = _$_AdocaoUpdControllerBaseActionController.startAction(
        name: '_AdocaoUpdControllerBase.setPet');
    try {
      return super.setPet(value);
    } finally {
      _$_AdocaoUpdControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
isError: ${isError},
pet: ${pet}
    ''';
  }
}
