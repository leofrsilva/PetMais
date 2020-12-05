import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';

import '../../add_produto_controller.dart';

part 'dados_principais_controller.g.dart';

@Injectable()
class DadosPrincipaisController = _DadosPrincipaisControllerBase
    with _$DadosPrincipaisController;

abstract class _DadosPrincipaisControllerBase extends Disposable with Store {
  final _picker = ImagePicker();
  AddProdutoController _addProdutoController;
  _DadosPrincipaisControllerBase(this._addProdutoController) {
    nomeProdController = TextEditingController(
      text: this.addProd.produto?.nameProd ?? "",
    );
    descricaoController = TextEditingController(
      text: this.addProd.produto?.descricao?? "",
    );
    focusNomeProd.dispose();
    focusDescricao.dispose();
    this.categoriaSelect = "Todos";
  }

  AddProdutoController get addProd => this._addProdutoController;
  UsuarioModel get usuarioModel => this.addProd.usuario;

  TextEditingController nomeProdController;
  TextEditingController descricaoController;
  FocusNode focusNomeProd;
  FocusNode focusDescricao;

  final formKey = GlobalKey<FormState>();

  //* Categoria
  @observable
  String categoriaSelect;
  @action
  setCategoriaSelect(String value) => this.categoriaSelect = value;

  List<DropdownMenuItem<String>> listCategoria;

  //? -----------------------------------------------------------------------
  //? Imagem
  File compressedImage;
  setCompressedImage(File value) => this.compressedImage = value;

  @observable
  File image;
  @action
  setImage(File value) => this.image = value;

  
  //? -----------------------------------------------------------------------------

  // Is Error
  @observable
  bool isError = false;
  @action
  setError(bool value) => this.isError = value;

  void nextPage(){
    if(formKey.currentState.validate()){
      setError(false);
      this.addProd.nextPage();
    }
    else{
      setError(true);
    }
  }  

  @override
  void dispose() {
    this.nomeProdController.dispose();
    this.descricaoController.dispose();
    this.focusNomeProd.dispose();
    this.focusDescricao.dispose();
  }
}