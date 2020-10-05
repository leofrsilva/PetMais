// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_pet_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $PerfilPetController = BindInject(
  (i) => PerfilPetController(i<HomeController>(), i<PetRemoteRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilPetController on _PerfilPetControllerBase, Store {
  final _$petAtom = Atom(name: '_PerfilPetControllerBase.pet');

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

  final _$_PerfilPetControllerBaseActionController =
      ActionController(name: '_PerfilPetControllerBase');

  @override
  dynamic setPet(PetModel value) {
    final _$actionInfo = _$_PerfilPetControllerBaseActionController.startAction(
        name: '_PerfilPetControllerBase.setPet');
    try {
      return super.setPet(value);
    } finally {
      _$_PerfilPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPetImages(PetImagesModel value) {
    final _$actionInfo = _$_PerfilPetControllerBaseActionController.startAction(
        name: '_PerfilPetControllerBase.setPetImages');
    try {
      return super.setPetImages(value);
    } finally {
      _$_PerfilPetControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pet: ${pet}
    ''';
  }
}
