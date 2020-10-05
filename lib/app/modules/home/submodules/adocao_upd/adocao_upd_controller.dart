import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmais/app/modules/home/submodules/add_adocao/models/adocao/adocao_model.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:image/image.dart' as Img;

part 'adocao_upd_controller.g.dart';

@Injectable()
class AdocaoUpdController = _AdocaoUpdControllerBase with _$AdocaoUpdController;

abstract class _AdocaoUpdControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final _picker = ImagePicker();
  AdocaoRemoteRepository _adocaoRemoteRepository;
  _AdocaoUpdControllerBase(this._adocaoRemoteRepository);

  void init(PostAdocaoModel postModel) {
    setPet(postModel);
    emailController = TextEditingController(
      text: this.pet.email,
    );
    phoneController = MaskedTextController(
      mask: "(00) 90000-0000",
      text: this.pet.numeroTelefone,
    );
    descricaoController = TextEditingController(
      text: this.pet.descricao,
    );
    focusTelefone = FocusNode();
    focusDescricao = FocusNode();
    setImage(ClipRRect(
      child: Image.network(
        this.pet.petImages.imgPrincipal,
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(20),
    ));
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController;
  MaskedTextController phoneController;
  TextEditingController descricaoController;

  FocusNode focusTelefone;
  FocusNode focusDescricao;

  //? -----------------------------------------------------------------------------
  //? Image Pet
  // @observable
  // String typeImg;

  // @action
  // setTypeImg(String value) => this.typeImg = value;

  // @observable
  // File tmpImage;

  // @action
  // setTmpImge(File value) => this.tmpImage = value;

  @observable
  Widget image;

  @action
  setImage(Widget value) => this.image = value;
  //? -----------------------------------------------------------------------------

  // Is Error
  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;

  // Pet Em Adoção
  @observable
  PostAdocaoModel pet;

  @action
  setPet(PostAdocaoModel value) => this.pet = value;

  // //? -----------------------------------------------------------------------
  // //? Imagem
  // void capturar(String op) async {
  //   PickedFile imageSelected;
  //   if (op == "camera") {
  //     imageSelected = await _picker.getImage(source: ImageSource.camera);
  //   } else if (op == "galeria") {
  //     imageSelected = await _picker.getImage(source: ImageSource.gallery);
  //   }
  //   if (imageSelected != null) {
  //     setImage(ClipRRect(
  //       child: Image.file(
  //         File(imageSelected.path),
  //         fit: BoxFit.cover,
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //     ));
  //     File auxImage = await _treatImage(File(imageSelected.path));
  //     setTmpImge(auxImage);
  //   }
  // }

  // Future<File> _treatImage(File fileImage) async {
  //   Directory tempDir = await getTemporaryDirectory();
  //   String path = tempDir.path;
  //   //? String title = _titleController.text;
  //   String id = this.pet.idDono.toString();
  //   String rand = DateTime.now().millisecondsSinceEpoch.toString();

  //   Img.Image image = Img.decodeImage(fileImage.readAsBytesSync());
  //   Img.Image smallerImg = Img.copyResize(image, width: 500);

  //   File compressImg = new File("$path/image_$id" + "_$rand.jpg")
  //     ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 10));
  //   // print(compressImg.toString());
  //   return compressImg;
  // }

  Future atualizar() async {
    if (formKey.currentState.validate()) {
      setError(false);
      String email = this.emailController.text.trim().toLowerCase();
      String phone = this.phoneController.text.trim();
      String desc = this.descricaoController.text.trim();
      AdocaoModel adocaoModel = AdocaoModel(
        idPet: this.pet.idPet,
        email: email,
        numeroTelefone: phone,
        dataRegistro: _formatarData(DateTime.now()),
        descricao: desc,
      );
      if (email != this.pet.email ||
          phone != this.pet.numeroTelefone ||
          desc != this.pet.descricao) {
        //* Start Loading
        this.showLoading();
        await this
            ._adocaoRemoteRepository
            .atualizarAdocao(adocaoModel)
            .then((Map<String, dynamic> result) {
          Modular.to.pop();
          if (result["Result"] == "Falha na Conexão") {
            //? Mensagem de Erro
            FlushbarHelper.createError(
              duration: Duration(milliseconds: 1500),
              message: "Erro na Conexão!",
            )..show(this.context);
          } else if (result["Result"] == "Register Update") {
            Modular.to.pop(adocaoModel);
            //? Mensagem de Erro
            FlushbarHelper.createSuccess(
              duration: Duration(milliseconds: 1500),
              message: "Atualizado com Sucesso!",
            )..show(this.context);
          } else {
            //? Dados do Login Incorreto
            FlushbarHelper.createInformation(
              duration: Duration(milliseconds: 1750),
              title: "Cadastro",
              message: "Não foi possivel atualizar a Adoção!",
            )..show(this.context);
          }
        });
      }
      else{
        Modular.to.pop(); 
      }

      // bool isImage = false;
      // if (tmpImage != null) {
      //   isImage = true;
      //   await this
      //       ._adocaoRemoteRepository
      //       .uploadImageAdocao(this.tmpImage)
      //       .then((Map<String, dynamic> result) {
      //     if (result["Result"] == "Falha no Envio") {
      //       Modular.to.pop();
      //       //? Mensagem de Erro
      //       FlushbarHelper.createError(
      //         duration: Duration(milliseconds: 1500),
      //         message: "Erro na Conexão!",
      //       )..show(this.context);
      //       return;
      //     }
      //   });
      // }

    }
  }

  //* Formatar Data
  String _formatarData(DateTime data) {
    initializeDateFormatting("pt_BR");
    //var formatter = DateFormat("d/M/y");
    var formatter = DateFormat.yMd("pt_BR");
    String dataFomatada = formatter.format(data);
    return dataFomatada;
  }

  void showLoading() {
    Modular.to.showDialog(builder: (_) {
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
                valueColor: AlwaysStoppedAnimation(DefaultColors.secondary),
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

  @override
  void dispose() {
    this.emailController.dispose();
    this.phoneController.dispose();
    this.descricaoController.dispose();
    this.focusTelefone.dispose();
    this.focusDescricao.dispose();
  }
}
