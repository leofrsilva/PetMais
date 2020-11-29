// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa_juridica_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PessoaJuridicaController on _PessoaJuridicaControllerBase, Store {
  final _$siglaEstadoAtom =
      Atom(name: '_PessoaJuridicaControllerBase.siglaEstado');

  @override
  String get siglaEstado {
    _$siglaEstadoAtom.reportRead();
    return super.siglaEstado;
  }

  @override
  set siglaEstado(String value) {
    _$siglaEstadoAtom.reportWrite(value, super.siglaEstado, () {
      super.siglaEstado = value;
    });
  }

  final _$typeJuridicoAtom =
      Atom(name: '_PessoaJuridicaControllerBase.typeJuridico');

  @override
  TypeJuridico get typeJuridico {
    _$typeJuridicoAtom.reportRead();
    return super.typeJuridico;
  }

  @override
  set typeJuridico(TypeJuridico value) {
    _$typeJuridicoAtom.reportWrite(value, super.typeJuridico, () {
      super.typeJuridico = value;
    });
  }

  final _$validationCNPJAtom =
      Atom(name: '_PessoaJuridicaControllerBase.validationCNPJ');

  @override
  bool get validationCNPJ {
    _$validationCNPJAtom.reportRead();
    return super.validationCNPJ;
  }

  @override
  set validationCNPJ(bool value) {
    _$validationCNPJAtom.reportWrite(value, super.validationCNPJ, () {
      super.validationCNPJ = value;
    });
  }

  final _$isErrorAtom = Atom(name: '_PessoaJuridicaControllerBase.isError');

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

  final _$imageAtom = Atom(name: '_PessoaJuridicaControllerBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$isCnpjValidAtom =
      Atom(name: '_PessoaJuridicaControllerBase.isCnpjValid');

  @override
  bool get isCnpjValid {
    _$isCnpjValidAtom.reportRead();
    return super.isCnpjValid;
  }

  @override
  set isCnpjValid(bool value) {
    _$isCnpjValidAtom.reportWrite(value, super.isCnpjValid, () {
      super.isCnpjValid = value;
    });
  }

  final _$_PessoaJuridicaControllerBaseActionController =
      ActionController(name: '_PessoaJuridicaControllerBase');

  @override
  void setSigleEstado(String value) {
    final _$actionInfo = _$_PessoaJuridicaControllerBaseActionController
        .startAction(name: '_PessoaJuridicaControllerBase.setSigleEstado');
    try {
      return super.setSigleEstado(value);
    } finally {
      _$_PessoaJuridicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTypeJuridico(TypeJuridico value) {
    final _$actionInfo = _$_PessoaJuridicaControllerBaseActionController
        .startAction(name: '_PessoaJuridicaControllerBase.setTypeJuridico');
    try {
      return super.setTypeJuridico(value);
    } finally {
      _$_PessoaJuridicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setValidationCNPJ(bool value) {
    final _$actionInfo = _$_PessoaJuridicaControllerBaseActionController
        .startAction(name: '_PessoaJuridicaControllerBase.setValidationCNPJ');
    try {
      return super.setValidationCNPJ(value);
    } finally {
      _$_PessoaJuridicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(bool value) {
    final _$actionInfo = _$_PessoaJuridicaControllerBaseActionController
        .startAction(name: '_PessoaJuridicaControllerBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$_PessoaJuridicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setImage(File value) {
    final _$actionInfo = _$_PessoaJuridicaControllerBaseActionController
        .startAction(name: '_PessoaJuridicaControllerBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_PessoaJuridicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsCnpjValid(bool value) {
    final _$actionInfo = _$_PessoaJuridicaControllerBaseActionController
        .startAction(name: '_PessoaJuridicaControllerBase.setIsCnpjValid');
    try {
      return super.setIsCnpjValid(value);
    } finally {
      _$_PessoaJuridicaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
siglaEstado: ${siglaEstado},
typeJuridico: ${typeJuridico},
validationCNPJ: ${validationCNPJ},
isError: ${isError},
image: ${image},
isCnpjValid: ${isCnpjValid}
    ''';
  }
}
