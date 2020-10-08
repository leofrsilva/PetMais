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
import 'package:petmais/app/modules/home/home_controller.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:image/image.dart' as Img;
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/repository/pet_remote/pet_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';

import 'models/adocao/adocao_model.dart';

part 'add_adocao_controller.g.dart';

@Injectable()
class AddAdocaoController = _AddAdocaoControllerBase with _$AddAdocaoController;

abstract class _AddAdocaoControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final _picker = ImagePicker();
  HomeController _homeController;
  PetRemoteRepository _petRemoteRepository;
  AdocaoRemoteRepository _adocaoRemoteRepository;
  _AddAdocaoControllerBase(this._homeController, this._petRemoteRepository,
      this._adocaoRemoteRepository) {
    emailController = TextEditingController(
      text: this.usuario.email,
    );
    phoneController = MaskedTextController(
      mask: "(00) 90000-0000",
      text: this.usuario.usuarioInfoModel.numeroTelefone,
    );
    descricaoController = TextEditingController();
    focusTelefone = FocusNode();
    focusDescricao = FocusNode();
  }

  UsuarioModel get usuario => this._homeController.auth.usuario;

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController;
  MaskedTextController phoneController;
  TextEditingController descricaoController;

  FocusNode focusTelefone;
  FocusNode focusDescricao;

  @observable
  String petIdSelect;

  @action
  setPetSelect(String value) => this.petIdSelect = value;

  // //? -----------------------------------------------------------------------------
  // //? Image Pet
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

  // Is Loading
  @observable
  bool isLoading = false;

  @action
  setLoading(bool value) => this.isLoading = value;

  // Pet Selecionado
  @observable
  PetModel pet;

  @action
  setPet(PetModel value) => this.pet = value;

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
  //     setTypeImg("File");
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

  Future<List<PetModel>> recuperarPets() async {
    return await this._petRemoteRepository.listPetsAdocao(
          this.usuario.usuarioInfoModel.id,
          paraDoacao: 0,
        );
  }

  Future addAdocao() async {
    if (formKey.currentState.validate()) {
      setError(false);
      String email = this.emailController.text.trim().toLowerCase();
      String phone = this.phoneController.text.trim();
      String desc = this.descricaoController.text.trim();
      AdocaoModel adocaoModel = AdocaoModel(
        idPet: this.pet.id,
        email: email,
        numeroTelefone: phone,
        dataRegistro: _formatarData(DateTime.now()),
        descricao: desc,
      );
      //* Start Loading
      this.showLoading();
      await this
          ._adocaoRemoteRepository
          .registerAdocao(adocaoModel)
          .then((Map<String, dynamic> result) {
        Modular.to.pop();
        if (result["Result"] == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else if (result["Result"] == "Registered") {
          Modular.to.pop(adocaoModel);
          //? Mensagem de Erro
          FlushbarHelper.createSuccess(
            duration: Duration(milliseconds: 1500),
            message: "Cadastrado com Sucesso!",
          )..show(this.context);
        } else {
          //? Dados do Login Incorreto
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1750),
            title: "Cadastro",
            message: "Não foi possivel Cadastrar a Adoção!",
          )..show(this.context);
        }
      });
    } else {
      setError(true);
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
