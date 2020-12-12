import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petmais/app/modules/auth/submodules/cadastro/utils/cep/cep_repository.dart';
import 'package:petmais/app/modules/auth/submodules/cadastro/utils/cnpj/cnpj_repository.dart';
import 'package:petmais/app/modules/auth/submodules/cadastro/utils/estados/estados_repository.dart';
import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import '../../cadastro_controller.dart';

part 'pessoa_juridica_controller.g.dart';

class PessoaJuridicaController = _PessoaJuridicaControllerBase
    with _$PessoaJuridicaController;

abstract class _PessoaJuridicaControllerBase extends Disposable with Store {
  BuildContext context;
  void setContext(BuildContext contx) => this.context = contx;

  final CadastroController cadastroController;
  _PessoaJuridicaControllerBase(this.cadastroController) {
    this.cnpjController = MaskedTextController(
      mask: "00.000.000/0000-00",
    );
    this.tel1Controller = MaskedTextController(
      mask: "(00) 000000000",
    );
    this.tel2Controller = MaskedTextController(
      mask: "(00) 000000000",
    );
    this.nomeOrgController = TextEditingController();
    this.descricaoController = TextEditingController();
    this.cepController = MaskedTextController(
      text: this.cadastroController.dadosEndereco.cep,
      mask: "00000-000",
    );
    this.ruaController = TextEditingController(
      text: this.cadastroController.dadosEndereco.rua,
    );
    this.numeroController = TextEditingController(
      text: this.cadastroController.dadosEndereco.numero,
    );
    this.compController = TextEditingController(
      text: this.cadastroController.dadosEndereco.complemento,
    );
    this.bairroController = TextEditingController(
      text: this.cadastroController.dadosEndereco.bairro,
    );
    this.cidadeController = TextEditingController(
      text: this.cadastroController.dadosEndereco.cidade,
    );
    // this.siglaEstado = this.cadastroController.dadosEndereco.estado.isNotEmpty
    //     ? this.cadastroController.dadosEndereco.estado
    //     : EstadosRepository.estados[0];
    this.focusCep = FocusNode();
    this.focusRua = FocusNode();
    this.focusNumero = FocusNode();
    this.focusComp = FocusNode();
    this.focusBairro = FocusNode();
    this.focusCidade = FocusNode();
    this.focusNomeOrg = FocusNode();
    this.focusTel1 = FocusNode();
    this.focusTel2 = FocusNode();
    this.focusDescricao = FocusNode();
  }

  final _picker = ImagePicker();
  MaskedTextController cnpjController;
  TextEditingController nomeOrgController;
  MaskedTextController tel1Controller;
  MaskedTextController tel2Controller;
  TextEditingController descricaoController;

  MaskedTextController cepController;
  TextEditingController ruaController;
  TextEditingController numeroController;
  TextEditingController compController;
  TextEditingController bairroController;
  TextEditingController cidadeController;

  FocusNode focusNomeOrg;
  FocusNode focusTel1;
  FocusNode focusTel2;
  FocusNode focusDescricao;

  FocusNode focusCep;
  FocusNode focusRua;
  FocusNode focusNumero;
  FocusNode focusComp;
  FocusNode focusBairro;
  FocusNode focusCidade;

  @observable
  String siglaEstado;

  @action
  void setSigleEstado(String value) => this.siglaEstado = value;

  List<DropdownMenuItem<String>> get getUF =>
      EstadosRepository.getEstadosAbrv();

  @observable
  TypeJuridico typeJuridico = TypeJuridico.ong;

  @action
  void setTypeJuridico(TypeJuridico value) => this.typeJuridico = value;

  List<DropdownMenuItem<TypeJuridico>> get listTypeJuridico {
    return TypeJuridico.values.map((value) {
      String item = value.toString().split(".").last;
      return DropdownMenuItem(
        child: Text(item.toUpperCase()),
        value: value,
      );
    }).toList();
  }

  //* Formatar CNPJ
  String formatterCNPJ(String cn) {
    String cnpj = cn.replaceAll(".", "");
    cnpj = cnpj.replaceFirst("/", "");
    cnpj = cnpj.replaceFirst("-", "");
    return cnpj;
  }

  //* Formatar Telefone
  String formatterPhone(String phon) {
    if (phon.length == 14) {
      return phon.replaceRange(9, 10, phon.substring(9, 10) + "-");
    } else if (phon.length == 13) {
      return phon.replaceRange(8, 9, phon.substring(8, 9) + "-");
    }
    return null;
  }

  //? Keys
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> expansionTile = new GlobalKey();
  Function scrollTop;
  setScrollTop(Function function) => this.scrollTop = function;

  //----------------------
  //? Validar CNPJ
  @observable
  bool validationCNPJ = true;

  @action
  setValidationCNPJ(bool value) => this.validationCNPJ = value;

  Future validateCNPJ() async {
    if (cnpjController.text.isNotEmpty) {
      String cnpj = cnpjController.text.replaceAll(".", "");
      cnpj = cnpj.replaceFirst("/", "");
      cnpj = cnpj.replaceFirst("-", "");
      bool org = await CnpjRepository.findCNPJ(cnpj);
      setValidationCNPJ(org);
    }
  }

  //-----------------------
  @observable
  bool isError = false;

  @action
  setError(bool value) => this.isError = value;
  //-----------------------------------------------------------

  Future findCNPJ() async {
    if (cnpjController.text.isNotEmpty) {
      String cnpj = cnpjController.text.replaceAll(".", "");
      cnpj = cnpj.replaceFirst("/", "");
      cnpj = cnpj.replaceFirst("-", "");
      Map<String, dynamic> org = await CnpjRepository.searchCNPJ(
        cnpj,
        context,
      );
      if (org != null) setDadosOrg(org);
    }
  }

  Future findCEP({String cep}) async {
    String searchCep = "";
    if (cep != null) {
      searchCep = cep;
      searchCep = searchCep.replaceFirst(".", "");
    } else if (cepController.text.isNotEmpty) {
      searchCep = cepController.text;
    }
    DadosEnderecoModel dadosEndereco = await CepRepository.searchCEP(
      searchCep.replaceFirst("-", ""),
      context,
    );
    if (dadosEndereco != null) setDadosEndereco(dadosEndereco);
  }

  void setDadosEndereco(DadosEnderecoModel dadosEnderecoModel) {
    this.cepController.text = dadosEnderecoModel.cep.toUpperCase();
    this.ruaController.text = dadosEnderecoModel.rua.toUpperCase();
    if (dadosEnderecoModel.numero != null) {
      this.numeroController.text = dadosEnderecoModel.numero;
    }
    if (dadosEnderecoModel.complemento != null) {
      this.compController.text = dadosEnderecoModel.complemento.toUpperCase();
    }
    this.bairroController.text = dadosEnderecoModel.bairro.toUpperCase();
    this.cidadeController.text = dadosEnderecoModel.cidade.toUpperCase();
    // this.setSigleEstado(dadosEnderecoModel.estado.toUpperCase());
  }

  void setDadosOrg(Map<String, dynamic> map) {
    this.nomeOrgController.text = map["nome"];
    if (map["tel1"] != null) {
      this.tel1Controller.text = map["tel1"];
    }
    if (map["tel2"] != null) {
      this.tel2Controller.text = map["tel2"];
    }
    if (map["descricao"] != null) {
      this.descricaoController.text = map["descricao"];
    }
    if (map["numero"] != null) {
      this.numeroController.text = map["numero"];
    }
    this.findCEP(cep: map["cep"]);
  }

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

    String emailUser = "";
    for (var letra in cadastroController.usuario.email.codeUnits) {
      emailUser += letra.toString();
    }

    // Img.Image image = Img.decodeImage(fileImage.readAsBytesSync());
    // Img.Image smallerImg = Img.copyResize(image, width: 256);

    // File compressImg = new File("$path/image_$emailUser.jpg")
    //   ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 10));
    File compressImg = new File("$path/image_$emailUser.jpg")
      ..writeAsBytesSync(fileImage.readAsBytesSync().toList());
    return compressImg;
  }

  //* Verificar CNPJ
  @observable
  bool isCnpjValid;

  @action
  setIsCnpjValid(bool value) => this.isCnpjValid = value;

  Future verificarCnpj() async {
    this.showLoading();
    String cnpj = cnpjController.text.replaceAll(".", "");
    cnpj = cnpj.replaceFirst("/", "");
    cnpj = cnpj.replaceFirst("-", "");
    print(cnpj);
    await this
        .cadastroController
        .checkCnpj(cnpj.trim(), isLoading: false)
        .then((String result) {
      print(result);
      if (result == "Falha na Conexão") {
        isCnpjValid = null;
        //? Mensagem de Erro
        FlushbarHelper.createError(
          duration: Duration(milliseconds: 1750),
          message: "Erro na Conexão!",
        )..show(this.context);
      } else if (result == "Found") {
        setIsCnpjValid(false);
      } else {
        setIsCnpjValid(true);
      }
    });
  }

  //* Navegação
  Future next() async {
    await this.verificarCnpj().whenComplete(() {
      expansionTile.currentState.expand();
      Future.delayed(Duration(milliseconds: 200), () {
        this.validateCNPJ().then((_) async {
          if (formKey.currentState.validate()) {
            scrollTop.call();
            setError(false);
            String foto;
            if (image != null) {
              foto =
                  "images/perfil/" + this.compressedImage.path.split("/").last;
            } else {
              foto = "No Photo";
            }
            DadosEnderecoModel dadosEndereco = DadosEnderecoModel(
              cep: this.cepController.text.trim(),
              rua: this.ruaController.text.trim(),
              numero: this.numeroController.text.trim(),
              comp: this.compController.text.trim(),
              bairro: this.bairroController.text.trim(),
              cidade: this.cidadeController.text.trim(),
              estado: "PE",
            );
            UsuarioInfoJuridicoModel usuarioInfo = UsuarioInfoJuridicoModel(
              cnpj: formatterCNPJ(this.cnpjController.text.trim()),
              nome: this.nomeOrgController.text.trim(),
              tel1: formatterPhone(this.tel1Controller.text.trim()),
              tel2: formatterPhone(this.tel2Controller.text.trim()),
              desc: this.descricaoController.text.trim(),
              type: this.typeJuridico,
              endereco: dadosEndereco,
              urlFoto: foto,
            );
            this.cadastroController.setUsuarioInfo = usuarioInfo;
            // Cadastrar
            await this
                .cadastroController
                .cadastrar(this.compressedImage, false)
                .then((String result) {
              hideLoading();
              if (result == "Falha no Envio" || result == "Not Send") {
                //? Mensagem de Erro
                FlushbarHelper.createError(
                  duration: Duration(milliseconds: 1500),
                  message: "Erro ao Enviar Imagem!",
                )..show(this.context);
              } else if (result == "Registered") {
                this.cadastroController.changePage(3);
              } else if (result == "Falha na Conexão") {
                //? Mensagem de Erro
                FlushbarHelper.createError(
                  duration: Duration(milliseconds: 1500),
                  message: "Erro na Conexão!",
                )..show(this.context);
              } else {
                //? Dados do Login Incorreto
                FlushbarHelper.createInformation(
                  duration: Duration(milliseconds: 1750),
                  title: "Cadastro",
                  message: "Algum dado está Incorreto!",
                )..show(this.context);
              }
            });
            
          } else {
            scrollTop.call();
            hideLoading();
            setError(true);
          }
        });
      });
    });
  }

  void back() {
    this.cadastroController.disposeDadosEndereco();
    this.cadastroController.changePage(0);
  }

  bool isLoading = false;
  showLoading() {
    this.isLoading = true;
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
    this.isLoading = false;
    Modular.to.pop();
  }

  @override
  void dispose() {
    this.cnpjController.dispose();
    this.nomeOrgController.dispose();
    this.tel1Controller.dispose();
    this.tel2Controller.dispose();
    this.descricaoController.dispose();
    this.cepController.dispose();
    this.ruaController.dispose();
    this.numeroController.dispose();
    this.compController.dispose();
    this.bairroController.dispose();
    this.cidadeController.dispose();

    this.focusCep.dispose();
    this.focusRua.dispose();
    this.focusNumero.dispose();
    this.focusComp.dispose();
    this.focusBairro.dispose();
    this.focusCidade.dispose();
    this.focusNomeOrg.dispose();
    this.focusTel1.dispose();
    this.focusTel2.dispose();
    this.focusDescricao.dispose();
  }
}
