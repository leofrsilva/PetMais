import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:petmais/app/modules/auth/submodules/cadastro/utils/cep/cep_repository.dart';
import 'package:petmais/app/modules/auth/submodules/cadastro/utils/cnpj/cnpj_repository.dart';
import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';

import '../../perfil_controller.dart';
part 'update_user_juridico_controller.g.dart';

class UpdateUserJuridicoController = _UpdateUserJuridicoControllerBase
    with _$UpdateUserJuridicoController;

abstract class _UpdateUserJuridicoControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  PerfilController _perfilController;
  _UpdateUserJuridicoControllerBase(this._perfilController) {
    this.emailController = TextEditingController(
      text: this.usuario.email,
    );
    this.cnpjController = MaskedTextController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).cnpj,
      mask: "00.000.000/0000-00",
    );
    this.tel1Controller = MaskedTextController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).telefone1,
      mask: "(00) 000000000",
    );
    this.tel2Controller = MaskedTextController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).telefone2,
      mask: "(00) 000000000",
    );
    this.nomeOrgController = TextEditingController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).nomeOrg,
    );
    this.descricaoController = TextEditingController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).descricao,
    );
    this.cepController = MaskedTextController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).endereco.cep,
      mask: "00000-000",
    );
    this.ruaController = TextEditingController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).endereco.rua,
    );
    this.numeroController = TextEditingController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
          .endereco
          .numero,
    );
    this.compController = TextEditingController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
          .endereco
          .complemento,
    );
    this.bairroController = TextEditingController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
          .endereco
          .bairro,
    );
    this.cidadeController = TextEditingController(
      text: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
          .endereco
          .cidade,
    );
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

  UsuarioModel get usuario => this._perfilController.usuario;

  TextEditingController emailController;
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
  bool isEmailValid;

  @action
  setIsEmailValid(bool value) => this.isEmailValid = value;

  //* VerificarEmail
  Future<bool> verificarEmail() async {
    bool record = false;
    if (this.emailController.text.trim().toLowerCase() !=
        this.usuario.email.toLowerCase()) {
      // Start Loading
      this.showLoading();
      await this
          ._perfilController
          .checkEmail(this.emailController.text.trim(), isLoading: false)
          .then((String result) {
        if (result == "Falha na Conexão") {
          Modular.to.pop();
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1750),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else if (result == "Found") {
          Modular.to.pop();
          setIsEmailValid(false);
        } else {
          setIsEmailValid(true);
          record = false;
        }
      });
    } else {
      setIsEmailValid(true);
      record = true;
    }
    return record;
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

  //* ----------------------------------------------------------------
  //* Atualizar
  Future atualizar() async {
    expansionTile.currentState.expand();
    Future.delayed(Duration(milliseconds: 200), () async {
      await verificarEmail().then((bool record) async {
        if (formKey.currentState.validate()) {
          scrollTop.call();
          //* Start Loading
          if (record) this.showLoading();
          setError(false);
          if (((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).nomeOrg.toLowerCase() !=
                  nomeOrgController.text.trim().toLowerCase()) ||
              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).telefone1.toLowerCase() !=
                  formatterPhone(this.tel1Controller.text.trim())) ||
              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).telefone2.toLowerCase() !=
                  formatterPhone(this.tel2Controller.text.trim())) ||
              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).descricao.toLowerCase() !=
                  descricaoController.text.trim().toLowerCase()) ||
              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                      .endereco
                      .cep
                      .toLowerCase() !=
                  cepController.text.trim().toLowerCase()) ||
              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                      .endereco
                      .rua
                      .toLowerCase() !=
                  ruaController.text.trim().toLowerCase()) ||
              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                      .endereco
                      .numero
                      .toLowerCase() !=
                  numeroController.text.trim().toLowerCase()) ||


              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                      .endereco
                      .complemento != null ? (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                      .endereco
                      .complemento
                      .toLowerCase() !=
                  compController.text.trim().toLowerCase() : compController.text.isNotEmpty) ||


              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                      .endereco
                      .bairro
                      .toLowerCase() !=
                  bairroController.text.trim().toLowerCase()) ||
              ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                      .endereco
                      .cidade
                      .toLowerCase() !=
                  cidadeController.text.trim().toLowerCase()) ||
              (this.usuario.email.toLowerCase() !=
                  emailController.text.trim().toLowerCase())) {
            //* Adicionando no UsuarioModel
            UsuarioModel usuarioModel = this.usuario;
            usuarioModel.email = this.emailController.text.trim();
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
              identifier:
                  (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).id,
              cnpj: this.cnpjController.text.trim(),
              nome: this.nomeOrgController.text.trim(),
              tel1: formatterPhone(this.tel1Controller.text.trim()),
              tel2: formatterPhone(this.tel2Controller.text.trim()),
              desc: this.descricaoController.text.trim(),
              type: TypeJuridico.ong,
              endereco: dadosEndereco,
              urlFoto: (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel)
                  .urlFoto
                  .split("files/")
                  .last,
            );
            usuarioModel.usuarioInfo = usuarioInfo;
            print("-- Atualização em Andamento --");

            await this
                ._perfilController
                .update(usuarioModel)
                .then((String result) {
              //* Stop Loading
              this.hideLoading();
              if (result == "Falha na Conexão") {
                //? Mensagem de Erro
                FlushbarHelper.createError(
                  duration: Duration(milliseconds: 1500),
                  message: "Erro na Conexão!",
                )..show(this.context);
              } else if (result == "Not Found Register") {
                //? Dados da Atualização Incorreto
                FlushbarHelper.createInformation(
                  duration: Duration(milliseconds: 1750),
                  title: "Atualização",
                  message: "Algum dado está Incorreto!",
                )..show(this.context);
              } else if (result == "Register Update") {
                //? Sair do Update User e  Confirma Atualização
                (usuarioModel.usuarioInfo as UsuarioInfoJuridicoModel).urlFoto =
                    UsuarioRemoteRepository.URL +
                        "/files/" +
                        (usuarioModel.usuarioInfo as UsuarioInfoJuridicoModel)
                            .urlFoto;
                Navigator.pop(context, usuarioModel);
              } else {
                //? Mensagem de Falha na Atualização
                FlushbarHelper.createError(
                  duration: Duration(milliseconds: 1500),
                  message: "Falha na atualização dos Dados!",
                )..show(this.context);
              }
            });
          } else {
            this.hideLoading();
            this.exit();
          }
        } else {
          setError(true);
        }
      });
    });
  }

  //* ----------------------------------------------------------------
  //* Exit
  void exit() {
    Navigator.pop(context, null);
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
    this.emailController.dispose();
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
