import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';

import '../../add_produto_controller.dart';

part 'dados_principais_controller.g.dart';

@Injectable()
class DadosPrincipaisController = _DadosPrincipaisControllerBase
    with _$DadosPrincipaisController;

abstract class _DadosPrincipaisControllerBase extends Disposable with Store {
  final _picker = ImagePicker();
  AddProdutoController _addProdutoController;
  _DadosPrincipaisControllerBase(this._addProdutoController) {
    this.listCategoria = ProdutoModel.listCategoriasProd();
    this.nomeProdController = TextEditingController(
      text: this.addProd.produto?.nameProd ?? "",
    );
    this.descricaoController = TextEditingController(
      text: this.addProd.produto?.descricao ?? "",
    );
    this.focusNomeProd = FocusNode();
    this.focusDescricao = FocusNode();
    this.categoriaSelect = ProdutoModel.categoriasAux[0];
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

  void capturar(String op) async {
    PickedFile imageSelected;
    if (op == "camera") {
      imageSelected = await _picker.getImage(source: ImageSource.camera);
    } else if (op == "galeria") {
      imageSelected = await _picker.getImage(source: ImageSource.gallery);
    }
    if (imageSelected != null) {
      File img = File(imageSelected.path);
      File auxImage = await ImageCropper.cropImage(
          sourcePath: img.path,
          // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 95,
          cropStyle: CropStyle.circle,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Recortar',
            toolbarColor: DefaultColors.primary,
            toolbarWidgetColor: Colors.grey,
            activeControlsWidgetColor: Colors.grey,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (auxImage != null) {
        await _treatImage(auxImage).then((File imgFile) {
          setImage(imgFile);
          setCompressedImage(imgFile);
        });
      }
    }
  }

  Future<File> _treatImage(File fileImage) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = tempDir.path;
    //? String title = _titleController.text;

    String codeImg = DateTime.now().microsecondsSinceEpoch.toString();

    // Img.Image image = Img.decodeImage(fileImage.readAsBytesSync());
    // Img.Image smallerImg = Img.copyResize(image, width: 500);

    // File compressImg = new File("$path/image_$emailUser.jpg")
    //   ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 10));
    File compressImg = new File("$path/image_$codeImg.jpg")
      ..writeAsBytesSync(fileImage.readAsBytesSync().toList());
    return compressImg;
  }
  //? -----------------------------------------------------------------------------

  // Is Error
  @observable
  bool isError = false;
  @action
  setError(bool value) => this.isError = value;

  void nextPage() {
    if (formKey.currentState.validate()) {
      setError(false);
      String img = "images/produtos/" + this.compressedImage.path.split("/").last;
      this.addProd.setDadosPrincipais(
        cat: this.categoriaSelect,
        nome: this.nomeProdController.text.trim(),
        desc: this.descricaoController.text.trim(),
        url: img,
      );
      this.addProd.setImage(this.compressedImage);
      this.addProd.nextPage();
    } else {
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
