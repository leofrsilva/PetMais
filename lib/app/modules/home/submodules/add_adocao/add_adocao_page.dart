import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/models/pet/pet_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';
import 'add_adocao_controller.dart';

class AddAdocaoPage extends StatefulWidget {
  final PetModel petModel;
  AddAdocaoPage({this.petModel});

  @override
  _AddAdocaoPageState createState() => _AddAdocaoPageState();
}

class _AddAdocaoPageState
    extends ModularState<AddAdocaoPage, AddAdocaoController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    if (widget.petModel != null) {
      controller.setPet(widget.petModel);
      controller.setImage(ClipRRect(
        child: Image.network(
          controller.pet.petImages.imgPrincipal,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ));
    }
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
          "Adicionar Adoção",
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
                  child: Form(
                    key: controller.formKey,
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
                                                    style: controller
                                                                .pet.raca ==
                                                            "SRD (Sem Raça Definida)"
                                                        ? TextStyle(
                                                            color: DefaultColors
                                                                .secondarySmooth,
                                                            fontFamily:
                                                                'Changa',
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
                                SizedBox(width: size.width * 0.005),
                                Container(
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
                                              if (controller.usuario.usuarioInfo
                                                  is UsuarioInfoModel) {
                                                if (value.length < 15) {
                                                  return "[Número de telefone Incompleto]";
                                                }
                                              } else {
                                                if (value.length < 13) {
                                                  return "[Telefone Incompleto]";
                                                }
                                              }
                                              return null;
                                            },
                                          );
                                        }),
                                      ),
                                    ],
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
                              heightText: size.height,
                              textCapitalization: TextCapitalization.sentences,
                              onFieldSubmitted: (String value) {
                                FocusScope.of(context).unfocus();
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "[O campo é obrigatório]";
                                }

                                if (value.length < 3) {
                                  return "[Descrição deve conter mais de 3 caracteres]";
                                }

                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Observer(builder: (_) {
                              return CustomButton(
                                text: "ADICIONAR PARA ADOÇÃO",
                                onPressed: controller.addAdocao,
                                elevation: 0.0,
                                width: size.width * 0.85,
                                decoration: kDecorationContainer,
                                isLoading: controller.isLoading,
                              );
                            }),
                          ),
                        ],
                      );
                    }),
                  ),
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
      padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
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
                        : controller.image != null
                            ? controller.image
                            : null,
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
                FlatButton(
                  onPressed: () {
                    _showPet(size);
                  },
                  child: Text(
                    "SELECIONAR PET",
                    style: kFlatButtonStyle,
                  ),
                ),
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

  void _showPet(Size size) async {
    PetModel selectedPet;
    controller.setPetSelect(controller.pet?.id?.toString() ?? null);
    PetModel p = await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<List<PetModel>>(
                      future: controller.recuperarPets(),
                      builder: (context, snapshot) {
                        Widget defaultWidget;
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data != null) {
                            List<PetModel> listPets = snapshot.data;
                            if (listPets.length > 0) {
                              defaultWidget = SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: listPets.map((PetModel pet) {
                                    return Observer(builder: (_) {
                                      return _radioButtonFromImage(
                                        text: pet.nome,
                                        activeColor: DefaultColors.background,
                                        selected: controller.petIdSelect ==
                                                pet.id.toString()
                                            ? true
                                            : false,
                                        value: pet.id.toString(),
                                        groupValue: controller.petIdSelect,
                                        onChange: (dynamic value) {
                                          controller.setPetSelect(value);
                                          selectedPet = pet;
                                        },
                                        secondary: Container(
                                          width: 50,
                                          height: 50,
                                          color: DefaultColors.others
                                              .withOpacity(0.5),
                                          child: Image.network(
                                            pet.petImages.imgPrincipal,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    });
                                  }).toList(),
                                ),
                              );
                            } else {
                              defaultWidget = Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    "Você não possui nenhum Pet!",
                                    style: TextStyle(
                                      color: DefaultColors.background,
                                      fontSize: 16,
                                      fontFamily: "Changa",
                                    ),
                                  ),
                                ),
                              );
                            }
                          } else {
                            defaultWidget = Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Erro na Conexão",
                                  style: TextStyle(
                                    color: DefaultColors.error,
                                    fontSize: 16,
                                    fontFamily: "Changa",
                                  ),
                                ),
                              ),
                            );
                          }
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          defaultWidget = Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    DefaultColors.secondary),
                              ),
                            ),
                          );
                        } else {
                          defaultWidget = Container();
                        }
                        return defaultWidget;
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          "Cancelar",
                          style: kFlatButtonStyle,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Ok",
                          style: kFlatButtonStyle,
                        ),
                        onPressed: () {
                          PetModel p = PetModel();
                          if (selectedPet != null) {
                            if (selectedPet.petImages.imgPrincipal != null) {
                              p = selectedPet;
                              Navigator.pop(context, p);
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (p != null) {
      controller.setPet(p);
      controller.setImage(ClipRRect(
        child: Image.network(
          controller.pet.petImages.imgPrincipal,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ));
    }
  }

  static Widget _radioButtonFromImage({
    String text,
    Widget secondary,
    TextAlign alignText = TextAlign.start,
    double fontSize = 20,
    Color activeColor,
    bool selected,
    dynamic value,
    dynamic groupValue,
    Function onChange,
  }) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.black26),
      child: RadioListTile(
        title: Row(
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Changa",
                    color: DefaultColors.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        activeColor: activeColor,
        selected: selected,
        value: value,
        groupValue: groupValue,
        onChanged: onChange,
        secondary: secondary,
      ),
    );
  }
}
