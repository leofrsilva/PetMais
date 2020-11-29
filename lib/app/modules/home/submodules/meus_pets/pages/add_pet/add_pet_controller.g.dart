// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_pet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddPetController on _AddPetControllerBase, Store {
  Computed<int> _$totalImgComputed;

  @override
  int get totalImg =>
      (_$totalImgComputed ??= Computed<int>(() => super.totalImg,
              name: '_AddPetControllerBase.totalImg'))
          .value;

  final _$isErrorAtom = Atom(name: '_AddPetControllerBase.isError');

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

  final _$forAdocaoAtom = Atom(name: '_AddPetControllerBase.forAdocao');

  @override
  bool get forAdocao {
    _$forAdocaoAtom.reportRead();
    return super.forAdocao;
  }

  @override
  set forAdocao(bool value) {
    _$forAdocaoAtom.reportWrite(value, super.forAdocao, () {
      super.forAdocao = value;
    });
  }

  final _$typeDataAtom = Atom(name: '_AddPetControllerBase.typeData');

  @override
  String get typeData {
    _$typeDataAtom.reportRead();
    return super.typeData;
  }

  @override
  set typeData(String value) {
    _$typeDataAtom.reportWrite(value, super.typeData, () {
      super.typeData = value;
    });
  }

  final _$valueSexoAtom = Atom(name: '_AddPetControllerBase.valueSexo');

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

  final _$listImagesAtom = Atom(name: '_AddPetControllerBase.listImages');

  @override
  ObservableList<File> get listImages {
    _$listImagesAtom.reportRead();
    return super.listImages;
  }

  @override
  set listImages(ObservableList<File> value) {
    _$listImagesAtom.reportWrite(value, super.listImages, () {
      super.listImages = value;
    });
  }

  final _$_AddPetControllerBaseActionController =
      ActionController(name: '_AddPetControllerBase');

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_AddPetControllerBaseActionController.startAction(
        name: '_AddPetControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_AddPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setForAdocao(bool value) {
    final _$actionInfo = _$_AddPetControllerBaseActionController.startAction(
        name: '_AddPetControllerBase.setForAdocao');
    try {
      return super.setForAdocao(value);
    } finally {
      _$_AddPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTypeData(String value) {
    final _$actionInfo = _$_AddPetControllerBaseActionController.startAction(
        name: '_AddPetControllerBase.setTypeData');
    try {
      return super.setTypeData(value);
    } finally {
      _$_AddPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSexo(String value) {
    final _$actionInfo = _$_AddPetControllerBaseActionController.startAction(
        name: '_AddPetControllerBase.setSexo');
    try {
      return super.setSexo(value);
    } finally {
      _$_AddPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addItem(File value) {
    final _$actionInfo = _$_AddPetControllerBaseActionController.startAction(
        name: '_AddPetControllerBase.addItem');
    try {
      return super.addItem(value);
    } finally {
      _$_AddPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeItem(File value) {
    final _$actionInfo = _$_AddPetControllerBaseActionController.startAction(
        name: '_AddPetControllerBase.removeItem');
    try {
      return super.removeItem(value);
    } finally {
      _$_AddPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isError: ${isError},
forAdocao: ${forAdocao},
typeData: ${typeData},
valueSexo: ${valueSexo},
listImages: ${listImages},
totalImg: ${totalImg}
    ''';
  }
}
