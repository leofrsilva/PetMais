import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/repository/pet_shop/pet_shop_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

import '../../produto_controller.dart';

part 'update_produto_controller.g.dart';

@Injectable()
class UpdateProdutoController = _UpdateProdutoControllerBase
    with _$UpdateProdutoController;

abstract class _UpdateProdutoControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext value) => this.context = value;

  final _picker = ImagePicker();
  // ignore: unused_field
  ProdutoController _addProdutoController;
  _UpdateProdutoControllerBase(this._addProdutoController) {
    this.listCategoria = ProdutoModel.listCategoriasProd();
    this.nomeProdController = TextEditingController();
    this.descricaoController = TextEditingController();
    this.focusNomeProd = FocusNode();
    this.focusDescricao = FocusNode();
    this.precoController = MoneyMaskedTextController(
      leftSymbol: 'R\$ ',
    );
    this.descontoController = MoneyMaskedTextController(
      rightSymbol: ' %',
    );
    this.focusPreco = FocusNode();
    this.focusDesconto = FocusNode();
    this.setQuantidade(1);
  }

  ProdutoModel _produtoModel;
  set produtoModel(ProdutoModel value) => this._produtoModel = value;

  TextEditingController nomeProdController;
  TextEditingController descricaoController;
  FocusNode focusNomeProd;
  FocusNode focusDescricao;

  MoneyMaskedTextController precoController;
  MoneyMaskedTextController descontoController;

  FocusNode focusPreco;
  FocusNode focusDesconto;

  final formKey = GlobalKey<FormState>();

  //* Categoria
  @observable
  String categoriaSelect;
  @action
  setCategoriaSelect(String value) => this.categoriaSelect = value;

  List<DropdownMenuItem<String>> listCategoria;

  //* Quantidade
  @observable
  double quant = 0;
  @action
  setQuantidade(double value) => this.quant = value;

  //* Is Delivery
  @observable
  bool isDelivery = true;
  @action
  setIsDelivery(bool value) => this.isDelivery = value;

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
        this.sendImg();
      }
    }
  }

  Future<File> _treatImage(File fileImage) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = tempDir.path;
    //? String title = _titleController.text;

    String codeImg = this._produtoModel.imgProd.split("/").last;

    // Img.Image image = Img.decodeImage(fileImage.readAsBytesSync());
    // Img.Image smallerImg = Img.copyResize(image, width: 500);

    // File compressImg = new File("$path/image_$emailUser.jpg")
    //   ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 10));
    File compressImg = new File("$path/$codeImg")
      ..writeAsBytesSync(fileImage.readAsBytesSync().toList());
    return compressImg;
  }
  //? -----------------------------------------------------------------------------

  // Is Error
  @observable
  bool isError = false;
  @action
  setError(bool value) => this.isError = value;

  //? Upload Image
  Future sendImg() async {
    final petShopRepository = PetShopRepository();
    if (this.compressedImage != null) {
      //* Start Loading
      this.showLoading();
      await petShopRepository
          .uploadImageProduto(this.compressedImage, false)
          .then((Map<String, dynamic> result) {
        //* Hide Loading
        this.hideLoading();
        if (result["Result"] == "Falha no Envio" ||
            result["Result"] == "Not Send") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro ao Enviar Imagem!",
          )..show(this.context);
          return;
        } else if (result["Result"] == "Send") {
          //? Mensagem de Sucesso
          FlushbarHelper.createSuccess(
            duration: Duration(milliseconds: 1500),
            message: "Imagem Atualizada com Sucesso!",
          )..show(this.context);
          return;
        }
      });
    }
  }

  //? Atualizar
  Future salvar() async {
    if (this.formKey.currentState.validate()) {
      final petShopRepository = PetShopRepository();
      this.setError(false);
      double preco = double.tryParse(this
          .precoController
          .text
          .replaceAll(",", ".")
          .trim()
          .toString()
          .replaceAll("R\$", ""));
      double desconto = double.tryParse(this
          .descontoController
          .text
          .replaceAll(",", ".")
          .trim()
          .toString()
          .replaceAll("%", ""));
      int quantidade = this.quant.toInt();
      int delivery = this.isDelivery ? 1 : 0;
      if (this.nomeProdController.text.trim() != this._produtoModel.nameProd ||
          this.categoriaSelect.trim() != this._produtoModel.categoria ||
          this.descricaoController.text.trim() !=
              this._produtoModel.descricao ||
          preco != this._produtoModel.price ||
          desconto != this._produtoModel.desconto ||
          quantidade != this._produtoModel.estoque ||
          delivery != this._produtoModel.delivery) {
        ProdutoModel produto = ProdutoModel(
          id: this._produtoModel.id,
          idPetShop: this._produtoModel.idPetShop,
          cat: this.categoriaSelect.trim(),
          name: this.nomeProdController.text.trim(),
          desc: this.descricaoController.text.trim(),
          price: preco,
          desconto: desconto,
          estoque: quantidade,
          delivery: delivery,
        );
        //* Show Loading
        this.showLoading();
        await petShopRepository
            .updateProduto(produto)
            .then((Map<String, dynamic> result) {
          //* Hide Loagind
          this.hideLoading();
          if (result["Result"] == "Falha na Conexão") {
            //? Mensagem de Erro
            FlushbarHelper.createError(
              duration: Duration(milliseconds: 1500),
              message: "Erro na Conexão!",
            )..show(this.context);
          } else if (result["Result"] == "Not Found Register") {
            //? Dados da Atualização Incorreto
            FlushbarHelper.createInformation(
              duration: Duration(milliseconds: 1750),
              title: "Atualização",
              message: "Algum dado está Incorreto!",
            )..show(this.context);
          } else if (result["Result"] == "Register Update") {
            //? Sair do Update Produto e  Confirma Atualização
            if (this.compressedImage != null) {
              Modular.to.pop(2);
            } else {
              Modular.to.pop(1);
            }
          } else {
            //? Mensagem de Falha na Atualização
            FlushbarHelper.createError(
              duration: Duration(milliseconds: 1500),
              message: "Falha na atualização dos Dados!",
            )..show(this.context);
          }
        });
      } else {
        if (this.compressedImage != null) {
          Modular.to.pop(2);
        } else {
          Modular.to.pop(0);
        }
      }
    } else {
      this.setError(true);
    }
  }

  //* Delete Produto
  Future delete() async {
    bool result = await Modular.to.showDialog(
        barrierDismissible: false,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            child: Center(
              child: Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Confimar exclusão do Produto?",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Changa",
                        color: DefaultColors.secondary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            "Não",
                            style: kFlatButtonStyle,
                          ),
                          onPressed: () {
                            Modular.to.pop(false);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Sim",
                            style: kFlatButtonStyle,
                          ),
                          onPressed: () {
                            Modular.to.pop(true);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    if (result == true) {
      final petShopRepository = PetShopRepository();
      //* Show Loading
      this.showLoading();
      await petShopRepository
          .deleteProduto(this._produtoModel.id)
          .then((Map<String, dynamic> result) {
        //* Hide Loading
        this.hideLoading();
        if (result["Result"] == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else if (result["Result"] == "Not Found Register" ||
            result["Result"] == "No Instantiated") {
          //? Problema na Exclusão
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1500),
            message: "Não foi possivel executar a Exclusão!",
          )..show(this.context);
        } else if (result["Result"] == "Delete Register") {
          Modular.to.pop(1);
        }
      });
    }
  }

  showLoading() {
    Modular.to.showDialog(
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(DefaultColors.secondary),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Carregando ...",
                    style: TextStyle(
                      color: DefaultColors.secondary,
                      fontFamily: "Changa",
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  hideLoading() {
    Modular.to.pop();
  }

  @override
  void dispose() {
    this.nomeProdController.dispose();
    this.descricaoController.dispose();
    this.focusNomeProd.dispose();
    this.focusDescricao.dispose();

    this.precoController.dispose();
    this.descontoController.dispose();
    this.focusPreco.dispose();
    this.focusDesconto.dispose();
  }
}
