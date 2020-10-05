import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/perfil_pet/pages/update_pet/update_pet_controller.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';
import 'package:petmais/app/shared/widgets/CustomRadioButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpdatePetPage extends StatefulWidget {
  final PetModel petModel;
  const UpdatePetPage({this.petModel});

  @override
  _UpdatePetPageState createState() => _UpdatePetPageState();
}

class _UpdatePetPageState
    extends ModularState<UpdatePetPage, UpdatePetController> {
  PetModel pet;

  @override
  void initState() {
    super.initState();
    this.pet = widget.petModel;
    controller.init(this.pet);
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DefaultColors.secondary,
      body: Center(
        child: Container(
          height: size.height * 0.9,
          width: size.width * 0.9,
          padding: const EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                offset: Offset(10.0, 10.0),
                blurRadius: 1.0,
              ),
            ],
          ),
          child: Form(
            key: controller.formKey,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextField(
                            height: error ? 60.0 : 40.0,
                            controller: controller.nomeController,
                            focusNode: controller.focusNome,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String value) {
                              FocusScope.of(context).unfocus();
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
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (String value) {
                            controller.focusData.unfocus();
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
                            if(value.length > 0){
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
                            textInputAction: TextInputAction.done,
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
                        child: Observer(builder: (_) {
                          bool error = controller.isError;
                          return CustomTextField(
                            height: error ? 70.0 : 40.0,
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
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 14),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              "Cancelar",
                              style: kFlatButtonStyle,
                            ),
                            onPressed: () {
                              controller.exit();
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Atualizar",
                              style: kFlatButtonStyle,
                            ),
                            onPressed: () {
                              controller.atualizar();
                              // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                              // setState(() {
                              //   _isLoading = true;
                              // });
                              // _onTap();
                              // Map<String, dynamic> value = await _atualizar(context);
                              // setState(() {
                              //   _isLoading = false;
                              // });
                              // if (value != null) {
                              //   print(value.toString());
                              //   Navigator.pop(context, value);
                              // } else {
                              //   Navigator.pop(context, null);
                              // }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
