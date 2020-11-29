// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_adocao_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddAdocaoController on _AddAdocaoControllerBase, Store {
  final _$petIdSelectAtom = Atom(name: '_AddAdocaoControllerBase.petIdSelect');

  @override
  String get petIdSelect {
    _$petIdSelectAtom.reportRead();
    return super.petIdSelect;
  }

  @override
  set petIdSelect(String value) {
    _$petIdSelectAtom.reportWrite(value, super.petIdSelect, () {
      super.petIdSelect = value;
    });
  }

  final _$imageAtom = Atom(name: '_AddAdocaoControllerBase.image');

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

  final _$isErrorAtom = Atom(name: '_AddAdocaoControllerBase.isError');

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

  final _$isLoadingAtom = Atom(name: '_AddAdocaoControllerBase.isLoading');

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

  final _$petAtom = Atom(name: '_AddAdocaoControllerBase.pet');

  @override
  PetModel get pet {
    _$petAtom.reportRead();
    return super.pet;
  }

  @override
  set pet(PetModel value) {
    _$petAtom.reportWrite(value, super.pet, () {
      super.pet = value;
    });
  }

  final _$_AddAdocaoControllerBaseActionController =
      ActionController(name: '_AddAdocaoControllerBase');

  @override
  dynamic setPetSelect(String value) {
    final _$actionInfo = _$_AddAdocaoControllerBaseActionController.startAction(
        name: '_AddAdocaoControllerBase.setPetSelect');
    try {
      return super.setPetSelect(value);
    } finally {
      _$_AddAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImage(Widget value) {
    final _$actionInfo = _$_AddAdocaoControllerBaseActionController.startAction(
        name: '_AddAdocaoControllerBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_AddAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_AddAdocaoControllerBaseActionController.startAction(
        name: '_AddAdocaoControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_AddAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_AddAdocaoControllerBaseActionController.startAction(
        name: '_AddAdocaoControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_AddAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPet(PetModel value) {
    final _$actionInfo = _$_AddAdocaoControllerBaseActionController.startAction(
        name: '_AddAdocaoControllerBase.setPet');
    try {
      return super.setPet(value);
    } finally {
      _$_AddAdocaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
petIdSelect: ${petIdSelect},
image: ${image},
isError: ${isError},
isLoading: ${isLoading},
pet: ${pet}
    ''';
  }
}
