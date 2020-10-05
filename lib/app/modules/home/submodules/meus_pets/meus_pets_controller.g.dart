// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meus_pets_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $MeusPetsController = BindInject(
  (i) => MeusPetsController(i<HomeController>(), i<PetRemoteRepository>(),
      i<AdocaoRemoteRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeusPetsController on _MeusPetsControllerBase, Store {
  final _$selectedSexGroupAtom =
      Atom(name: '_MeusPetsControllerBase.selectedSexGroup');

  @override
  String get selectedSexGroup {
    _$selectedSexGroupAtom.reportRead();
    return super.selectedSexGroup;
  }

  @override
  set selectedSexGroup(String value) {
    _$selectedSexGroupAtom.reportWrite(value, super.selectedSexGroup, () {
      super.selectedSexGroup = value;
    });
  }

  final _$selectedEspGroupAtom =
      Atom(name: '_MeusPetsControllerBase.selectedEspGroup');

  @override
  String get selectedEspGroup {
    _$selectedEspGroupAtom.reportRead();
    return super.selectedEspGroup;
  }

  @override
  set selectedEspGroup(String value) {
    _$selectedEspGroupAtom.reportWrite(value, super.selectedEspGroup, () {
      super.selectedEspGroup = value;
    });
  }

  final _$_MeusPetsControllerBaseActionController =
      ActionController(name: '_MeusPetsControllerBase');

  @override
  dynamic setSelectedSexGroup(String value) {
    final _$actionInfo = _$_MeusPetsControllerBaseActionController.startAction(
        name: '_MeusPetsControllerBase.setSelectedSexGroup');
    try {
      return super.setSelectedSexGroup(value);
    } finally {
      _$_MeusPetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedEspGroup(String value) {
    final _$actionInfo = _$_MeusPetsControllerBaseActionController.startAction(
        name: '_MeusPetsControllerBase.setSelectedEspGroup');
    try {
      return super.setSelectedEspGroup(value);
    } finally {
      _$_MeusPetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedSexGroup: ${selectedSexGroup},
selectedEspGroup: ${selectedEspGroup}
    ''';
  }
}
