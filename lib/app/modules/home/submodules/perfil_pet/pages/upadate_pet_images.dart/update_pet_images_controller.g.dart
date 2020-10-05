// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_pet_images_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UpdatePetImagesController on _UpdatePetImagesControllerBase, Store {
  Computed<int> _$totalImgComputed;

  @override
  int get totalImg =>
      (_$totalImgComputed ??= Computed<int>(() => super.totalImg,
              name: '_UpdatePetImagesControllerBase.totalImg'))
          .value;
  Computed<List<dynamic>> _$listFileImgComputed;

  @override
  List<dynamic> get listFileImg => (_$listFileImgComputed ??=
          Computed<List<dynamic>>(() => super.listFileImg,
              name: '_UpdatePetImagesControllerBase.listFileImg'))
      .value;

  final _$listImagesAtom =
      Atom(name: '_UpdatePetImagesControllerBase.listImages');

  @override
  ObservableList<Map<String, dynamic>> get listImages {
    _$listImagesAtom.reportRead();
    return super.listImages;
  }

  @override
  set listImages(ObservableList<Map<String, dynamic>> value) {
    _$listImagesAtom.reportWrite(value, super.listImages, () {
      super.listImages = value;
    });
  }

  final _$_UpdatePetImagesControllerBaseActionController =
      ActionController(name: '_UpdatePetImagesControllerBase');

  @override
  dynamic addItem(Map<String, dynamic> value) {
    final _$actionInfo = _$_UpdatePetImagesControllerBaseActionController
        .startAction(name: '_UpdatePetImagesControllerBase.addItem');
    try {
      return super.addItem(value);
    } finally {
      _$_UpdatePetImagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeItem(Map<String, dynamic> value) {
    final _$actionInfo = _$_UpdatePetImagesControllerBaseActionController
        .startAction(name: '_UpdatePetImagesControllerBase.removeItem');
    try {
      return super.removeItem(value);
    } finally {
      _$_UpdatePetImagesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listImages: ${listImages},
totalImg: ${totalImg},
listFileImg: ${listFileImg}
    ''';
  }
}
