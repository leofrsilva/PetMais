import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/auth/submodules/cadastro/utils/cep/cep_repository.dart';
import 'package:petmais/app/shared/models/dados_endereco/dados_endereco_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/models/produto/produto_model.dart';
import 'package:petmais/app/shared/models/pedido/pedido_model.dart';
import 'package:petmais/app/shared/repository/pet_shop/pet_shop_repository.dart';
import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:flushbar/flushbar_helper.dart';

import '../../../../home_controller.dart';

part 'produto_controller.g.dart';

@Injectable()
class ProdutoController = _ProdutoControllerBase with _$ProdutoController;

abstract class _ProdutoControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext value) => this.context = value;

  HomeController _homeController;
  _ProdutoControllerBase(this._homeController) {
    this.cepController = MaskedTextController(
      mask: "00000-000",
    );
    this.ruaController = TextEditingController();
    this.numeroController = TextEditingController();
    this.compController = TextEditingController();
    this.bairroController = TextEditingController();
    this.cidadeController = TextEditingController();
    this.focusCep = FocusNode();
    this.focusRua = FocusNode();
    this.focusNumero = FocusNode();
    this.focusComp = FocusNode();
    this.focusBairro = FocusNode();
    this.focusCidade = FocusNode();
  }

  MaskedTextController cepController;
  TextEditingController ruaController;
  TextEditingController numeroController;
  TextEditingController compController;
  TextEditingController bairroController;
  TextEditingController cidadeController;
  FocusNode focusCep;
  FocusNode focusRua;
  FocusNode focusNumero;
  FocusNode focusComp;
  FocusNode focusBairro;
  FocusNode focusCidade;

  UsuarioModel get usuario => this._homeController.auth.usuario;

  Future<DadosEnderecoModel> findCEP({String cep}) async {
    String searchCep = "";
    if (cep != null) {
      searchCep = cep;
      searchCep = searchCep.replaceFirst(".", "");
    }
    DadosEnderecoModel dadosEndereco = await CepRepository.searchCEP(
      searchCep.replaceFirst("-", ""),
      context,
    );
    if (dadosEndereco != null) return dadosEndereco;
    return null;
  }

  Future fazerPedido(ProdutoModel produto, Size size) async {
    final petShopRepository = PetShopRepository();
    double quantidade = 1;
    double price = (produto.price - ((produto.desconto / 100) * produto.price));
    double total =
        (produto.price - ((produto.desconto / 100) * produto.price)) *
            quantidade;

    this.ruaController.clear();
    this.numeroController.clear();
    this.compController.clear();
    this.bairroController.clear();
    this.cidadeController.clear();
    this.cepController.clear();

    //? Keys
    final formKey = GlobalKey<FormState>();
    bool isError = false;

    dynamic retorno = await Modular.to.showDialog(builder: (_) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: size.height,
            width: size.width * 0.9,
            padding: EdgeInsets.all(size.height * 0.025),
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Scaffold(
                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "R\$ " +
                                                produto.price
                                                    .toStringAsFixed(2)
                                                    .replaceFirst(".", ","),
                                            textAlign: produto.desconto != 0.0
                                                ? TextAlign.start
                                                : TextAlign.end,
                                            style: TextStyle(
                                              height: size.height * 0.001,
                                              color: Colors.grey,
                                              fontFamily:
                                                  'Changa', //GoogleFonts.montserrat().fontFamily,
                                              fontWeight: FontWeight.w500,
                                              fontSize: size.height * 0.0275,
                                              decoration: produto.desconto !=
                                                      0.0
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                            ),
                                          ),
                                        ),
                                        if (produto.desconto != 0.0)
                                          Expanded(
                                            child: Text(
                                              "- " +
                                                  produto.desconto
                                                      .toString()
                                                      .replaceFirst(".", ",") +
                                                  "%",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                height: size.height * 0.001,

                                                color: DefaultColors.background,
                                                fontFamily:
                                                    'Changa', //GoogleFonts.montserrat().fontFamily,
                                                fontWeight: FontWeight.w500,
                                                fontSize: size.height * 0.0275,
                                              ),
                                            ),
                                          ),
                                        if (produto.desconto != 0.0)
                                          Expanded(
                                            child: Text(
                                              "R\$" +
                                                  (produto.price -
                                                          ((produto.desconto /
                                                                  100) *
                                                              produto.price))
                                                      .toStringAsFixed(2)
                                                      .replaceFirst(".", ","),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                height: size.height * 0.001,

                                                color: DefaultColors.secondary,
                                                fontFamily:
                                                    'Changa', //GoogleFonts.montserrat().fontFamily,
                                                fontWeight: FontWeight.w700,
                                                fontSize: size.height * 0.0275,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01),
                                    child: Row(
                                      children: [
                                        Text(
                                          produto.categoria == "Rações"
                                              ? "Quantidade: (KG)"
                                              : "Quantidade:",
                                          style: TextStyle(
                                            color:
                                                DefaultColors.backgroundSmooth,
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.075),
                                        SpinnerInput(
                                          spinnerValue: quantidade,
                                          minValue: 1,
                                          maxValue: 100000,
                                          middleNumberWidth: size.width * 0.15,
                                          middleNumberStyle: TextStyle(
                                            fontFamily: "Changa",
                                            color: DefaultColors.background,
                                            fontSize: size.height * 0.035,
                                          ),
                                          minusButton: SpinnerButtonStyle(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                DefaultColors.backgroundSmooth,
                                            textColor: DefaultColors.tertiary,
                                          ),
                                          plusButton: SpinnerButtonStyle(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                DefaultColors.backgroundSmooth,
                                            textColor: DefaultColors.tertiary,
                                          ),
                                          onChange: (double value) {
                                            setState(() {
                                              quantidade = value;
                                              total = price * value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.065,
                                    decoration: BoxDecoration(
                                      color: DefaultColors.secondary,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.015),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "R\$" +
                                                total
                                                    .toStringAsFixed(2)
                                                    .replaceFirst(".", ","),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  'Changa', //GoogleFonts.montserrat().fontFamily,
                                              fontWeight: FontWeight.w800,
                                              fontSize: size.height * 0.03,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(height: size.height * 0.005),
                                      CustomTextFieldIcon(
                                        height: isError
                                            ? size.height * 0.075
                                            : size.height * 0.055,
                                        colorLabel:
                                            DefaultColors.backgroundSmooth,
                                        colorText: DefaultColors.background,
                                        controller: this.cepController,
                                        focusNode: focusCep,
                                        textInputType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          focusRua.requestFocus();
                                        },
                                        label: "CEP",
                                        hint: "00000-000",
                                        contentPadding:
                                            const EdgeInsets.only(left: 15.0),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                            DadosEnderecoModel
                                                .toNumCaracteres()["cep"],
                                          ),
                                        ],
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return " [Campo Obrigatório]";
                                          }
                                          if (value.length < 9) {
                                            return " [O CEP está Incompleto]";
                                          }
                                          return null;
                                        },
                                        widgetIcon: Icon(
                                          FontAwesomeIcons.searchLocation,
                                          color: Colors.black26,
                                        ),
                                        onPressedIcon: () async {
                                          if (this.cepController.text.isEmpty ||
                                              this.cepController.text.length <
                                                  9) return;
                                          DadosEnderecoModel
                                              dadosEnderecoModel =
                                              await this.findCEP(
                                                  cep: this.cepController.text);
                                          this.cepController.text =
                                              dadosEnderecoModel.cep
                                                  .toUpperCase();
                                          this.ruaController.text =
                                              dadosEnderecoModel.rua
                                                  .toUpperCase();
                                          if (dadosEnderecoModel.numero !=
                                              null) {
                                            this.numeroController.text =
                                                dadosEnderecoModel.numero;
                                          }
                                          if (dadosEnderecoModel.complemento !=
                                              null) {
                                            this.compController.text =
                                                dadosEnderecoModel.complemento
                                                    .toUpperCase();
                                          }
                                          this.bairroController.text =
                                              dadosEnderecoModel.bairro
                                                  .toUpperCase();
                                          this.cidadeController.text =
                                              dadosEnderecoModel.cidade
                                                  .toUpperCase();
                                        },
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 4,
                                            child: CustomTextField(
                                              height: isError
                                                  ? size.height * 0.075
                                                  : size.height * 0.055,
                                              colorLabel: DefaultColors
                                                  .backgroundSmooth,
                                              colorText:
                                                  DefaultColors.background,
                                              controller: this.ruaController,
                                              focusNode: focusRua,
                                              textInputType: TextInputType.text,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (String value) {
                                                focusNumero.requestFocus();
                                              },
                                              label: "Endereço",
                                              hint: " - ",
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  DadosEnderecoModel
                                                      .toNumCaracteres()["rua"],
                                                ),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return " [Campo Obrigatório]";
                                                }
                                                if (value.length < 4) {
                                                  return " [O endereço deve conter mais de 3 caracteres]";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.03),
                                          Expanded(
                                            flex: 2,
                                            child: CustomTextField(
                                              height: isError
                                                  ? size.height * 0.075
                                                  : size.height * 0.055,
                                              colorLabel: DefaultColors
                                                  .backgroundSmooth,
                                              colorText:
                                                  DefaultColors.background,
                                              controller: this.numeroController,
                                              focusNode: focusNumero,
                                              textInputType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (String value) {
                                                focusComp.requestFocus();
                                              },
                                              label: "Número",
                                              hint: "",
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  DadosEnderecoModel
                                                          .toNumCaracteres()[
                                                      "numero"],
                                                ),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return "[Obrigatório]";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      CustomTextField(
                                        height: size.height * 0.05,
                                        heightText: size.height * 0.0015,
                                        colorLabel:
                                            DefaultColors.backgroundSmooth,
                                        colorText: DefaultColors.background, //
                                        controller: this.compController,
                                        focusNode: focusComp,
                                        textInputType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          focusBairro.requestFocus();
                                        },
                                        label: "Complemento",
                                        hint: "",
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                            DadosEnderecoModel
                                                    .toNumCaracteres()[
                                                "complemento"],
                                          ),
                                        ],
                                        contentPadding:
                                            const EdgeInsets.only(left: 15.0),
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      CustomTextField(
                                        height: isError
                                            ? size.height * 0.075
                                            : size.height * 0.055,
                                        colorLabel:
                                            DefaultColors.backgroundSmooth,
                                        colorText: DefaultColors.background,
                                        controller: this.bairroController,
                                        focusNode: focusBairro,
                                        textInputType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (String value) {
                                          focusCidade.requestFocus();
                                        },
                                        label: "Bairro",
                                        hint: " - ",
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(
                                            DadosEnderecoModel
                                                .toNumCaracteres()["bairro"],
                                          ),
                                        ],
                                        contentPadding:
                                            const EdgeInsets.only(left: 15.0),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return " [Campo Obrigatório]";
                                          }
                                          if (value.length < 4) {
                                            return " [O Bairro deve conter mais de 3 caracteres]";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: size.height * 0.03),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 4,
                                            child: CustomTextField(
                                              height: isError
                                                  ? size.height * 0.075
                                                  : size.height * 0.055,
                                              colorLabel: DefaultColors
                                                  .backgroundSmooth,
                                              colorText:
                                                  DefaultColors.background,
                                              controller: this.cidadeController,
                                              focusNode: focusCidade,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              textInputType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (String value) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              label: "Cidade",
                                              hint: " - ",
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                  DadosEnderecoModel
                                                          .toNumCaracteres()[
                                                      "cidade"],
                                                ),
                                              ],
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15.0),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return " [Campo Obrigatório]";
                                                }
                                                if (value.length < 4) {
                                                  return " [A Cidade deve conter mais de 3 caracteres]";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "PE",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: DefaultColors.secondary,
                                                fontFamily: "Changa",
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: size.height * 0.09,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButtonOutline(
                                height: size.height * 0.065,
                                width: size.width * 0.275,
                                text: "Cancelar",
                                fontsize: size.height * 0.0175,
                                corText: DefaultColors.background,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: DefaultColors.background,
                                    width: 2,
                                  ),
                                ),
                                onPressed: () {
                                  Modular.to.pop(false);
                                },
                              ),
                              CustomButtonOutline(
                                height: size.height * 0.065,
                                width: size.width * 0.4,
                                text: "Calcular Frete",
                                fontsize: size.height * 0.0175,
                                corText: DefaultColors.background,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: DefaultColors.background,
                                    width: 2,
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    setState(() {
                                      isError = false;
                                    });
                                    DadosEnderecoModel dadosEndereco =
                                        DadosEnderecoModel(
                                      cep: this.cepController.text.trim(),
                                      rua: this.ruaController.text.trim(),
                                      numero: this.numeroController.text.trim(),
                                      comp: this.compController.text.trim(),
                                      bairro: this.bairroController.text.trim(),
                                      cidade: this.cidadeController.text.trim(),
                                      estado: "PE",
                                    );
                                    return Modular.to.pop(dadosEndereco);
                                  } else {
                                    setState(() {
                                      isError = true;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });

    if (retorno is DadosEnderecoModel) {
      //* Show Loading
      this.showLoading();
      Map<String, dynamic> map = {
        "enderecoPetshop": produto.endereco,
        "enderecoCliente": retorno.toLogadouro(),
        "valorKm": produto.valorKm,
      };
      await petShopRepository
          .cacularFrete(map)
          .then((Map<String, dynamic> result) async {
        //* Hide Loading
        this.hideLoading();
        if (result["Result"] == "Success") {
          double frete = double.tryParse(result["valorEntrega"]);
          PedidoModel pedidoModel = PedidoModel(
            tipo: "entrega",
            quantidade: quantidade.toInt(),
            total: total,
            valEntrega: total + frete,
            endereco: retorno.toLogadouro(),
            comp: retorno.complemento,
            idUserComum: this.usuario.usuarioInfo.id,
            idProduto: produto.id,
          );
          bool fazerPedido = await Modular.to.showDialog(
              barrierDismissible: false,
              builder: (_) {
                return Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: Center(
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.025),
                                Text(
                                  "Confimar Pedido?",
                                  style: TextStyle(
                                    fontSize: size.height * 0.04,
                                    fontFamily: "Changa",
                                    color: DefaultColors.backgroundSmooth,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        produto.nameProd,
                                        style: TextStyle(
                                          color: DefaultColors.background,
                                          fontSize: size.height * 0.03,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.005),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Quantidade: " +
                                            pedidoModel.quantidade.toString(),
                                        style: TextStyle(
                                          color: DefaultColors.background,
                                          fontSize: size.height * 0.0225,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.005),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "R\$ " +
                                            pedidoModel.total
                                                .toStringAsFixed(2)
                                                .replaceFirst(".", ",") +
                                            "\nFrete: R\$ " +
                                            frete
                                                .toString()
                                                .replaceFirst(".", ","),
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: DefaultColors.secondarySmooth,
                                          fontSize: size.height * 0.0225,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Total: R\$ " +
                                            (frete + pedidoModel.total)
                                                .toStringAsFixed(2)
                                                .replaceFirst(".", ","),
                                        style: TextStyle(
                                          color: DefaultColors.secondary,
                                          fontSize: size.height * 0.025,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
          if (fazerPedido) {
            pedidoModel.dataPedido = DateTime.now().toString();
            //* Show Loading
            this.showLoading();
            await petShopRepository
                .pedidoPorEntrega(pedidoModel)
                .then((Map<String, dynamic> result) async {
              //* Hide Loading
              this.hideLoading();
              if (result["Result"] == "Registered") {
                //? Sucesso no Cadastro
                FlushbarHelper.createSuccess(
                  duration: Duration(milliseconds: 1500),
                  message: "Pedido feito com Sucesso",
                )..show(this.context);
                  Modular.to.pop();
                
              } else if (result["Result"] == "Falha na Conexão") {
                //? Mensagem de Erro
                FlushbarHelper.createError(
                  duration: Duration(milliseconds: 1500),
                  message: "Erro na Conexão!",
                )..show(this.context);
              } else {
                //? Dados do Cadastro Incorreto
                FlushbarHelper.createInformation(
                  duration: Duration(milliseconds: 1750),
                  title: "Cadastro",
                  message: "Algum dado está Incorreto!",
                )..show(this.context);
              }
            });
          }
        } else if (result["Result"] == "No Instantiated" ||
            result["Result"] == "Erro to calculate distance") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro ao Calcular Frete!",
          )..show(this.context);
        } else if (result["Result"] == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        }
      });
    }
  }

  Future gerarCodigoDeRetirada(ProdutoModel produto, Size size) async {
    final petShopRepository = PetShopRepository();
    double quantidade = 1;
    double price = (produto.price - ((produto.desconto / 100) * produto.price));
    double total =
        (produto.price - ((produto.desconto / 100) * produto.price)) *
            quantidade;
    dynamic retorno = await Modular.to.showDialog(builder: (_) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: size.height * 0.70,
            width: size.width * 0.85,
            padding: EdgeInsets.all(size.height * 0.025),
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.025),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "R\$ " +
                                        produto.price
                                            .toStringAsFixed(2)
                                            .replaceFirst(".", ","),
                                    textAlign: produto.desconto != 0.0
                                        ? TextAlign.start
                                        : TextAlign.end,
                                    style: TextStyle(
                                      height: size.height * 0.001,
                                      color: Colors.grey,
                                      fontFamily:
                                          'Changa', //GoogleFonts.montserrat().fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.height * 0.0275,
                                      decoration: produto.desconto != 0.0
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                                if (produto.desconto != 0.0)
                                  Expanded(
                                    child: Text(
                                      "- " +
                                          produto.desconto
                                              .toString()
                                              .replaceFirst(".", ",") +
                                          "%",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        height: size.height * 0.001,

                                        color: DefaultColors.background,
                                        fontFamily:
                                            'Changa', //GoogleFonts.montserrat().fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.height * 0.0275,
                                      ),
                                    ),
                                  ),
                                if (produto.desconto != 0.0)
                                  Expanded(
                                    child: Text(
                                      "R\$" +
                                          (produto.price -
                                                  ((produto.desconto / 100) *
                                                      produto.price))
                                              .toStringAsFixed(2)
                                              .replaceFirst(".", ","),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        height: size.height * 0.001,

                                        color: DefaultColors.secondary,
                                        fontFamily:
                                            'Changa', //GoogleFonts.montserrat().fontFamily,
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.height * 0.0275,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.025),
                            child: Row(
                              children: [
                                Text(
                                  produto.categoria == "Rações"
                                      ? "Quantidade: (KG)"
                                      : "Quantidade:",
                                  style: TextStyle(
                                    color: DefaultColors.backgroundSmooth,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.075),
                                SpinnerInput(
                                  spinnerValue: quantidade,
                                  minValue: 1,
                                  maxValue: 100000,
                                  middleNumberWidth: size.width * 0.15,
                                  middleNumberStyle: TextStyle(
                                    fontFamily: "Changa",
                                    color: DefaultColors.background,
                                    fontSize: size.height * 0.035,
                                  ),
                                  minusButton: SpinnerButtonStyle(
                                    borderRadius: BorderRadius.circular(10),
                                    color: DefaultColors.backgroundSmooth,
                                    textColor: DefaultColors.tertiary,
                                  ),
                                  plusButton: SpinnerButtonStyle(
                                    borderRadius: BorderRadius.circular(10),
                                    color: DefaultColors.backgroundSmooth,
                                    textColor: DefaultColors.tertiary,
                                  ),
                                  onChange: (double value) {
                                    setState(() {
                                      quantidade = value;
                                      total = price * value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.35,
                            height: size.height * 0.075,
                            decoration: BoxDecoration(
                              color: DefaultColors.secondary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.025),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "R\$" +
                                        total
                                            .toStringAsFixed(2)
                                            .replaceFirst(".", ","),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          'Changa', //GoogleFonts.montserrat().fontFamily,
                                      fontWeight: FontWeight.w800,
                                      fontSize: size.height * 0.03,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButtonOutline(
                            height: size.height * 0.065,
                            width: size.width * 0.275,
                            text: "Cancelar",
                            fontsize: size.height * 0.0175,
                            corText: DefaultColors.background,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: DefaultColors.background,
                                width: 2,
                              ),
                            ),
                            onPressed: () {
                              Modular.to.pop(false);
                            },
                          ),
                          CustomButtonOutline(
                            height: size.height * 0.065,
                            width: size.width * 0.4,
                            text: "Gerar Código",
                            fontsize: size.height * 0.0175,
                            corText: DefaultColors.background,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: DefaultColors.background,
                                width: 2,
                              ),
                            ),
                            onPressed: () {
                              PedidoModel pedidoModel = PedidoModel(
                                tipo: "retirada",
                                quantidade: quantidade.toInt(),
                                total: total,
                                dataPedido: DateTime.now().toString(),
                                idUserComum: this.usuario.usuarioInfo.id,
                                idProduto: produto.id,
                              );
                              return Modular.to.pop(pedidoModel);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
    if (retorno is PedidoModel) {
      //* Show Loading
      this.showLoading();
      await petShopRepository
          .pedidoPorRetiradaDeCodigo(retorno)
          .then((Map<String, dynamic> result) async {
        //* Hide Loading
        this.hideLoading();
        if (result["Result"] == "Registered") {
          //? Retorna para lista de Produtos
          await Modular.to.showDialog(
              barrierDismissible: true,
              builder: (_) {
                return Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: size.height * 0.40,
                      width: size.width * 0.75,
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.025),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          produto.endereco,
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          style: TextStyle(
                                            height: size.height * 0.0015,
                                            color: DefaultColors.background,
                                            fontFamily:
                                                'Changa', //GoogleFonts.montserrat().fontFamily,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.03,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.6,
                                  height: size.height * 0.1,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: DefaultColors.backgroundSmooth,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      vertical: size.height * 0.025),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          result["codigo"].toString(),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: DefaultColors.tertiary,
                                            fontFamily: 'Changa',
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.045,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: size.height * 0.10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: DefaultColors.background,
                                      fontFamily: "Changa",
                                      fontSize: size.height * 0.03,
                                    ),
                                  ),
                                  onPressed: () {
                                    Modular.to.pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
          Modular.to.pop();
        } else if (result["Result"] == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else {
          //? Dados do Cadastro Incorreto
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1750),
            title: "Cadastro",
            message: "Algum dado está Incorreto!",
          )..show(this.context);
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
    this.ruaController.dispose();
    this.numeroController.dispose();
    this.compController.dispose();
    this.bairroController.dispose();
    this.cidadeController.dispose();
    this.cepController.dispose();

    this.focusCep.dispose();
    this.focusRua.dispose();
    this.focusNumero.dispose();
    this.focusComp.dispose();
    this.focusBairro.dispose();
    this.focusCidade.dispose();
  }
}
