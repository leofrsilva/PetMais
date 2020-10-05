import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'pessoa_fisica_controller.dart';

class PessoaFisicaPage extends StatefulWidget {
  final String title;
  const PessoaFisicaPage({Key key, this.title = "DadosEndereco"})
      : super(key: key);

  @override
  _PessoaFisicaPageState createState() => _PessoaFisicaPageState();
}

class _PessoaFisicaPageState
    extends ModularState<PessoaFisicaPage, PessoaFisicaController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: controller.formKey,
        child: AspectRatio(
          aspectRatio: size.aspectRatio,
          child: Container(
            height: size.height * 0.8,
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.075,
              // vertical: size.height * 0.10,
            ),
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.02),
                    _selectFoto(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: size.height * 0.03),
                        Observer(
                          builder: (BuildContext context) {
                            bool isError = controller.isError;
                            return CustomTextField(
                              height: isError ? 70.0 : 50.0,
                              controller: controller.nomeController,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                controller.focusSobrenome.requestFocus();
                              },
                              label: "Nome",
                              hint: "Digite seu Nome",
                              contentPadding: const EdgeInsets.only(left: 15.0),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                  UsuarioInfoModel.toNumCaracteres()["nome"],
                                )
                              ],
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "  [Campo Obrigatório]";
                                }
                                if (value.length < 3) {
                                  return "  [O Nome deve conter mais de 2 caracteres]";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.005),
                        Observer(
                          builder: (BuildContext context) {
                            bool isError = controller.isError;
                            return CustomTextField(
                              height: isError ? 70.0 : 50.0,
                              controller: controller.sobrenomeController,
                              focusNode: controller.focusSobrenome,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String value) {
                                controller.focusData.requestFocus();
                              },
                              label: "Sobrenome",
                              hint: "Digite seu Sobrenome",
                              contentPadding: const EdgeInsets.only(left: 15.0),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                  UsuarioInfoModel.toNumCaracteres()[
                                      "sobrenome"],
                                )
                              ],
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "  [Campo Obrigatório]";
                                }
                                if (value.length < 3) {
                                  return "  [O Nome deve conter mais de 2 caracteres]";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        Observer(builder: (_) {
                          bool isError = controller.isError;
                          return CustomTextFieldIcon(
                            height: isError ? 70.0 : 50.0,
                            controller: controller.dataController,
                            focusNode: controller.focusData,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusTelefone.requestFocus();
                            },
                            label: "Data de Nascimento",
                            hint: "00/00/0000",
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            widgetIcon: Icon(
                              FontAwesomeIcons.calendar,
                              color: Colors.black26,
                            ),
                            onPressedIcon: () {
                              controller.selectData(context);
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "  [Campo Obrigatório]";
                              }
                              if (value.length < 9) {
                                return "  [Data Incompleta]";
                              }
                              if (controller.isValidData(value) == false) {
                                return "  [Data Inválida]";
                              }
                              return null;
                            },
                          );
                        }),                        
                        SizedBox(height: size.height * 0.03),
                        Observer(builder: (_) {
                          bool isError = controller.isError;
                          return CustomTextField(
                            height: isError ? 70.0 : 50.0,
                            controller: controller.phoneController,
                            focusNode: controller.focusTelefone,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).unfocus();
                            },
                            label: "Telefone",
                            hint: "(00) 90000-0000",
                            icon: Icons.phone,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "    [O campo é obrigatório]";
                              }
                              if (value.length < 15) {
                                return "    [Número de telefone Incompleto]";
                              }
                              return null;
                            },
                          );
                        }),
                      ],
                    ),
                    Container(
                      height: size.height * 0.2,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomButtonOutline(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.back();
                            },
                            text: "VOLTAR",
                            elevation: 0.0,
                            width: size.width * 0.3,
                            height: size.height * 0.07,
                            decoration: kDecorationContainerBorder,
                          ),
                          CustomButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              controller.next();
                            },
                            text: "AVANÇAR",
                            elevation: 0.0,
                            width: size.width * 0.4,
                            height: size.height * 0.07,
                            decoration: kDecorationContainer,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectFoto() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Observer(builder: (_) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 1.0,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor:
                        DefaultColors.primarySmooth, //Colors.black12,
                    backgroundImage: controller.image == null
                        ? null
                        : FileImage(controller.image),
                    child: controller.image != null
                        ? null
                        : Icon(
                            Icons.person,
                            color: DefaultColors.secondarySmooth,
                            size: 50,
                          ),
                    maxRadius: 55,
                  ),
                );
              }),
              Text(
                "(Opicional)",
                style: TextStyle(color: Colors.black26, fontFamily: "Changa"),
              )
            ],
          ),
          Column(
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () {
                  controller.capturar("camera");
                },
                icon: Icon(Icons.camera_alt),
                label: Text("Câmera"),
                elevation: 0,
                color: DefaultColors.primarySmooth, //Colors.grey[100],
                textColor: DefaultColors.secondarySmooth,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              RaisedButton.icon(
                onPressed: () {
                  controller.capturar("galeria");
                },
                icon: Icon(Icons.photo),
                label: Text("Galeria"),
                elevation: 0,
                color: DefaultColors.primarySmooth,
                textColor: DefaultColors.secondarySmooth,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
