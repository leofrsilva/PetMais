// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_menu_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DrawerMenuController on _DrawerMenuControllerBase, Store {
  final _$isSairAtom = Atom(name: '_DrawerMenuControllerBase.isSair');

  @override
  bool get isSair {
    _$isSairAtom.reportRead();
    return super.isSair;
  }

  @override
  set isSair(bool value) {
    _$isSairAtom.reportWrite(value, super.isSair, () {
      super.isSair = value;
    });
  }

  final _$_DrawerMenuControllerBaseActionController =
      ActionController(name: '_DrawerMenuControllerBase');

  @override
  dynamic setSair(bool value) {
    final _$actionInfo = _$_DrawerMenuControllerBaseActionController
        .startAction(name: '_DrawerMenuControllerBase.setSair');
    try {
      return super.setSair(value);
    } finally {
      _$_DrawerMenuControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSair: ${isSair}
    ''';
  }
}
