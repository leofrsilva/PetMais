// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animation_drawer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AnimationDrawerController on _AnimationDrawerControllerBase, Store {
  final _$xOffsetAtom = Atom(name: '_AnimationDrawerControllerBase.xOffset');

  @override
  double get xOffset {
    _$xOffsetAtom.reportRead();
    return super.xOffset;
  }

  @override
  set xOffset(double value) {
    _$xOffsetAtom.reportWrite(value, super.xOffset, () {
      super.xOffset = value;
    });
  }

  final _$yOffsetAtom = Atom(name: '_AnimationDrawerControllerBase.yOffset');

  @override
  double get yOffset {
    _$yOffsetAtom.reportRead();
    return super.yOffset;
  }

  @override
  set yOffset(double value) {
    _$yOffsetAtom.reportWrite(value, super.yOffset, () {
      super.yOffset = value;
    });
  }

  final _$scaleFactorAtom =
      Atom(name: '_AnimationDrawerControllerBase.scaleFactor');

  @override
  double get scaleFactor {
    _$scaleFactorAtom.reportRead();
    return super.scaleFactor;
  }

  @override
  set scaleFactor(double value) {
    _$scaleFactorAtom.reportWrite(value, super.scaleFactor, () {
      super.scaleFactor = value;
    });
  }

  final _$isShowDrawerAtom =
      Atom(name: '_AnimationDrawerControllerBase.isShowDrawer');

  @override
  bool get isShowDrawer {
    _$isShowDrawerAtom.reportRead();
    return super.isShowDrawer;
  }

  @override
  set isShowDrawer(bool value) {
    _$isShowDrawerAtom.reportWrite(value, super.isShowDrawer, () {
      super.isShowDrawer = value;
    });
  }

  final _$_AnimationDrawerControllerBaseActionController =
      ActionController(name: '_AnimationDrawerControllerBase');

  @override
  void openDrawer() {
    final _$actionInfo = _$_AnimationDrawerControllerBaseActionController
        .startAction(name: '_AnimationDrawerControllerBase.openDrawer');
    try {
      return super.openDrawer();
    } finally {
      _$_AnimationDrawerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void closeDrawer() {
    final _$actionInfo = _$_AnimationDrawerControllerBaseActionController
        .startAction(name: '_AnimationDrawerControllerBase.closeDrawer');
    try {
      return super.closeDrawer();
    } finally {
      _$_AnimationDrawerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
xOffset: ${xOffset},
yOffset: ${yOffset},
scaleFactor: ${scaleFactor},
isShowDrawer: ${isShowDrawer}
    ''';
  }
}
