import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/utils/NoGlowBehavior.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'package:petmais/app/shared/widgets/CustomTextFieldIcon.dart';
import 'package:petmais/app/shared/widgets/CustomCheckBox.dart';
import 'package:petmais/app/shared/widgets/CustomRadioButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'update_pet_images_controller.dart';

class UpdatePetImagesPage extends StatefulWidget {
  final PetImagesModel petModel;
  const UpdatePetImagesPage({this.petModel});

  @override
  _UpdatePetImagesPageState createState() => _UpdatePetImagesPageState();
}

class _UpdatePetImagesPageState
    extends ModularState<UpdatePetImagesPage, UpdatePetImagesController> {
  PetImagesModel pet;

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
                      _selectFotoNomeData(size),
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

  Widget _selectFotoNomeData(Size size) {
    return FormField<List<Map<String, dynamic>>>(
        initialValue: controller.listImages,
        validator: (images) {
          if (images.length == 0) {
            return "Necessário selecionar uma Imagem do seu pet!";
          }
          return null;
        },
        builder: (FormFieldState<List<Map<String, dynamic>>> state) {
          return Observer(builder: (_) {
            return Container(
              height: size.height * 0.78,
              width: size.width * 0.98,
              padding: EdgeInsets.only(
                bottom: 15,
                left: size.width * 0.175,
                right: size.width * 0.175,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      // reverse: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.listImages.length + 1,
                      itemBuilder: (context, index) {
                        Widget defaultWidget = Container();
                        if (index == controller.listImages.length &&
                            index < 3) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
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
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                                      child: Padding(
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
                                              Container(
                                                height: size.height * 0.45,
                                                width: size.height * 0.45,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: controller.listImages
                                                        .elementAt(
                                                            index)["widget"],
                                                            fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
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
                                  radius: 70,
                                    backgroundImage: controller.listImages
                                          .elementAt(index)["widget"],
                                  
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.delete,
                                      color: DefaultColors.error,
                                      size: 28,
                                    ),
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
        });
  }
}
