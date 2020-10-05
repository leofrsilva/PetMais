import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/modules/home/submodules/meus_pets/pages/add_pet/add_pet_controller.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';
import 'package:petmais/app/shared/widgets/CustomRadioButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';

class AddPetPage extends StatefulWidget {
  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends ModularState<AddPetPage, AddPetController> {
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Adicionar Pet",
          style: kLabelTitleAppBarStyle,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: controller.formKey,
          child: Container(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: [
                _screenData(size),
                _screenAdocao(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _screenData(Size size) {
    return Container(
      height: size.height * 0.8,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _selectFotoNomeData(size),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Observer(builder: (_) {
                bool error = controller.isError;
                return CustomTextField(
                  height: error ? 60.0 : 40.0,
                  controller: controller.nomeController,
                  focusNode: controller.focusNome,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String value) {
                    controller.focusData.requestFocus();
                  },
                  label: "Nome",
                  hint: "Digite nome do pet...",
                  contentPadding: const EdgeInsets.only(left: 15.0),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      PetModel.toNumCaracteres()["nome"],
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
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomTextFieldIcon(
                height: 40.0,
                controller: controller.dataController,
                focusNode: controller.focusData,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (String value) {
                  controller.focusEspecie.requestFocus();
                },
                label: "Data de Nascimento",
                hint: "00/00/0000",
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                widgetIcon: Icon(
                  FontAwesomeIcons.calendar,
                  color: Colors.black26,
                ),
                onPressedIcon: () {
                  controller.selectData(context);
                },
                validator: (String value) {
                  if (value.length > 0) {
                    if (value.length < 9) {
                      return "  [Data Incompleta]";
                    }
                    if (controller.isValidData(value) == false) {
                      return "  [Data Inválida]";
                    }
                  }
                  return null;
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Observer(builder: (_) {
                      return CustomRadioButton(
                        label: "Sexo",
                        primaryTitle: "Macho",
                        secondyTitle: "Fêmea",
                        primaryValue: "M",
                        secondyValue: "F",
                        groupValue: controller.valueSexo,
                        primaryOnChanged: controller.setSexo,
                        secondyOnChanged: controller.setSexo,
                        activeColor: DefaultColors.primary,
                      );
                    }),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextField(
                            height: error ? 70.0 : 40.0,
                            label: "Espécie",
                            hint: "Espécie do pet ...",
                            controller: controller.especieController,
                            focusNode: controller.focusEspecie,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            readOnly: true,
                            onTap: controller.showEspecie,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "  [Campo Obrigatório]";
                              }
                              return null;
                            },
                          );
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CustomTextField(
                          height: 40.0,
                          label: "Raça",
                          hint: "Raça do pet ...",
                          controller: controller.racaController,
                          focusNode: controller.focusRaca,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.words,
                          onFieldSubmitted: (_) {
                            controller.focusRaca.unfocus();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: size.height * 0.075,
              width: size.width,
              alignment: Alignment.bottomCenter,
              child: IconButton(
                iconSize: 34,
                icon: Icon(Icons.keyboard_arrow_right,
                    color: DefaultColors.secondary),
                onPressed: () {
                  if (controller.formKey.currentState.validate()) {
                    controller.setError(false);
                    controller.pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 150),
                      curve: Curves.easeIn,
                    );
                  } else {
                    controller.setError(true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _screenAdocao(Size size) {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.075,
              width: size.width,
              alignment: Alignment.bottomCenter,
              child: IconButton(
                iconSize: 30,
                icon: Icon(Icons.keyboard_arrow_left,
                    color: DefaultColors.secondary),
                onPressed: () {
                  controller.pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 150),
                      curve: Curves.easeIn,
                    );
                },
              ),
            ),
            Observer(builder: (_) {
              bool isError = controller.isError;
              return controller.forAdocao
                  ? Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomTextField(
                            height: isError ? 60.0 : 40.0,
                            isDense: true,
                            controller: controller.emailController,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusPhone.requestFocus();
                            },
                            label: "Email",
                            hint: "Entre com seu Email",
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(
                                UsuarioModel.toNumCaracteres()["email"],
                              ),
                            ],
                            textInputType: TextInputType.emailAddress,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "[O campo é obrigatório]";
                              }
                              if (value.contains("@") == false ||
                                  value.length < 4) {
                                return "[Email Inválido]";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CustomTextField(
                            height: isError ? 60.0 : 40.0,
                            isDense: true,
                            controller: controller.phoneController,
                            focusNode: controller.focusPhone,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String value) {
                              controller.focusDescricao.requestFocus();
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomTextField(
                            height: size.height * 0.28,
                            controller: controller.descricaoController,
                            focusNode: controller.focusDescricao,
                            label: "Decrição",
                            hint: "  ...",
                            numLines: 5,
                            maxCaracteres: 215,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: size.height * 0.30,
                    );
            }),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Observer(builder: (_) {
                return CustomCheckBox(
                  text: "Para adoção?",
                  value: controller.forAdocao,
                  onChanged: controller.setForAdocao,
                  activeColor: DefaultColors.primary,
                  onTap: () {                    
                    controller.setForAdocao(!controller.forAdocao);
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                text: "ADICIONAR",
                corText: Colors.white,
                elevation: 0.0,
                width: size.width * 0.6,
                decoration: kDecorationContainerGradient,
                onPressed: controller.adicionar,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectFotoNomeData(Size size) {
    return FormField<List<File>>(
      initialValue: controller.listImages,
      validator: (images) {
        if (images.length == 0) {
          return "Necessário selecionar uma Imagem do seu pet!";
        }
        return null;
      },
      builder: (FormFieldState<List<File>> state) {
        return Observer(builder: (_) {
          return Container(
            height: size.height * 0.21,
            width: size.width * 0.98,
            margin: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listImages.length + 1,
                    itemBuilder: (context, index) {
                      Widget defaultWidget = Container();
                      if (index == controller.listImages.length && index < 3) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black26,
                              radius: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  Text(
                                    "Adicionar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "RussoOne",
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      if (controller.listImages.length > 0 && index < 3) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.file(controller.listImages
                                              .elementAt(index)),
                                          FlatButton(
                                            onPressed: () {
                                              controller.removeItem(
                                                controller.listImages
                                                    .elementAt(index),
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Excluir",
                                              style: TextStyle(
                                                fontFamily: "RussoOne",
                                                color: DefaultColors.error,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                controller.listImages.elementAt(index),
                              ),
                              child: Container(
                                color: Color.fromRGBO(255, 255, 255, 0.4),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.delete,
                                  color: DefaultColors.error,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return defaultWidget;
                    },
                  ),
                ),
                if (state.hasError)
                  Container(
                    child: Text(
                      "[${state.errorText}]",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.red[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          );
        });        
      },
    );
  }
}
