import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/post_adocao/post_adocao_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'adocao_upd_controller.dart';

class AdocaoUpdPage extends StatefulWidget {
  final PostAdocaoModel postModel;
  const AdocaoUpdPage({this.postModel});

  @override
  _AdocaoUpdPageState createState() => _AdocaoUpdPageState();
}

class _AdocaoUpdPageState
    extends ModularState<AdocaoUpdPage, AdocaoUpdController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.init(widget.postModel);
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black26,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        title: Text(
          "Atualizar Adoção",
          style: kLabelTitleAppBarStyle,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _selectPet(size),
                Container(
                  child: Observer(builder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (controller.pet != null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Data",
                                          style: kLabelTitleStyle,
                                        ),
                                        Container(
                                          width: size.width * 0.4,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  controller.pet
                                                              .dataNascimento ==
                                                          null
                                                      ? " - "
                                                      : controller
                                                          .pet.dataNascimento,
                                                  style: kLabelSmoothStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Especie",
                                          style: kLabelTitleStyle,
                                        ),
                                        Container(
                                          width: size.width * 0.4,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  controller.pet.especie,
                                                  style: kLabelSmoothStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Raça",
                                          style: kLabelTitleStyle,
                                        ),
                                        Container(
                                          width: size.width * 0.38,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  controller.pet.raca == null
                                                      ? " - "
                                                      : controller.pet.raca,
                                                  style: controller.pet.raca ==
                                                          "SRD (Sem Raça Definida)"
                                                      ? TextStyle(
                                                          color: DefaultColors
                                                              .secondarySmooth,
                                                          fontFamily: 'Changa',
                                                          fontSize: 13,
                                                        )
                                                      : kLabelSmoothStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 7.5),
                              Container(
                                child: Form(
                                  key: controller.formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Sexo",
                                            style: kLabelTitleStyle,
                                          ),
                                          Container(
                                            width: size.width * 0.45,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    controller.pet.sexo == "M"
                                                        ? "Macho"
                                                        : "Fêmea",
                                                    style: kLabelSmoothStyle,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: size.width * 0.5,
                                        child: Observer(builder: (_) {
                                          bool isError = controller.isError;
                                          return CustomTextField(
                                            height: isError ? 70.0 : 40.0,
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            controller:
                                                controller.emailController,
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (String value) {
                                              controller.focusTelefone
                                                  .requestFocus();
                                            },
                                            label: "Email",
                                            hint: "Entre com seu Email",
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                UsuarioModel.toNumCaracteres()[
                                                    "email"],
                                              ),
                                            ],
                                            textInputType:
                                                TextInputType.emailAddress,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return "[O campo é obrigatório]";
                                              }
                                              if (value.contains("@") ==
                                                      false ||
                                                  value.length < 4) {
                                                return "[Email Inválido]";
                                              }
                                              return null;
                                            },
                                          );
                                        }),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        width: size.width * 0.5,
                                        child: Observer(builder: (_) {
                                          bool isError = controller.isError;
                                          return CustomTextField(
                                            height: isError ? 70.0 : 40.0,
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            controller:
                                                controller.phoneController,
                                            focusNode: controller.focusTelefone,
                                            textInputType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            onFieldSubmitted: (String value) {
                                              controller.focusDescricao
                                                  .requestFocus();
                                            },
                                            label: "Telefone",
                                            hint: "(00) 90000-0000",
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return "[O campo é obrigatório]";
                                              }
                                              if (value.length < 15) {
                                                return "[Número de telefone Incompleto]";
                                              }
                                              return null;
                                            },
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        Container(
                          height: size.height * 0.35,
                          width: size.width * 0.9,
                          child: CustomTextField(
                            height: size.height * 0.3,
                            controller: controller.descricaoController,
                            focusNode: controller.focusDescricao,
                            label: "Decrição",
                            hint: "  ...",
                            numLines: 5,
                            maxCaracteres: 215,
                            textCapitalization: TextCapitalization.sentences,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomButton(
                            text: "ATUALIZAR",
                            onPressed: controller.atualizar,
                            elevation: 0.0,
                            width: size.width * 0.85,
                            decoration: kDecorationContainer,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectPet(Size size) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0, top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Observer(builder: (_) {
                  return Container(
                    width: size.width * 0.4,
                    height: 150,
                    decoration: BoxDecoration(
                      color: DefaultColors.others.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.pet == null
                        ? Icon(
                            Icons.pets,
                            color: Colors.white,
                            size: 50,
                          )
                        : controller.image != null ? controller.image : null,
                  );
                }),
              ),
            ],
          ),
          // Container(width: size.width * 0.5),
          Container(
            width: size.width * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(),
                Observer(builder: (_) {
                  return Container(
                    child: Text(
                      controller.pet != null ? controller.pet.nome : "",
                      style: kLabelSmoothStyle,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
