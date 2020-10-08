import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:petmais/app/shared/models/pet/pet_images_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as Img;
import 'package:petmais/app/shared/utils/font_style.dart';

import '../../perfil_pet_controller.dart';
part 'update_pet_images_controller.g.dart';

class UpdatePetImagesController = _UpdatePetImagesControllerBase
    with _$UpdatePetImagesController;

abstract class _UpdatePetImagesControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  final _picker = ImagePicker();
  PerfilPetController _perfilPetController;
  _UpdatePetImagesControllerBase(this._perfilPetController);

  final formKey = GlobalKey<FormState>();

  Future<File> setFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName = p.join(dir.path, filename);
    return File(pathName);
  }

  //? --------------------------------------------------------------
  //? Inicializar Form
  Future disposeImg(File file) async {
    await file.exists().then((bool value) {
      if (value == true) {
        print("Delete path $file");
        file.delete();
      }
    });
  }

  void init(PetImagesModel images) {
    this.petImagesModel = images;
    //

    //
    this.petImagesModel.listImages.forEach((img) async {
      if (img != "No Photo") {
        this.disposeImg(await setFile(img.split("/").last));
        File fileImg = await setFile(img.split("/").last);

        ImageProvider widgetImg = new NetworkToFileImage(
          url: img,
          file: fileImg,
          debug: true,
        );
        Map<String, dynamic> map = {
          "widget": widgetImg,
          "file": fileImg,
          "url": fileImg.path,
        };
        listImages.add(map);
      }
    });
  }

  PetImagesModel petImagesModel;

  //? -----------------------------------------------------------------------
  //? Lista de Imagem
  @observable
  ObservableList<Map<String, dynamic>> listImages =
      List<Map<String, dynamic>>().asObservable();

  @computed
  int get totalImg => this.listImages.length;

  @computed
  List get listFileImg {
    List<File> listFile = [];
    this
        .listImages
        .where((img) => img["widget"] is FileImage)
        .toList()
        .forEach((file) {
      listFile.add(file["file"]);
    });
    return listFile;
  }

  @action
  addItem(Map<String, dynamic> value) {
    listImages.add(value);
  }

  @action
  removeItem(Map<String, dynamic> value) {
    (value["file"] as File).exists().then((bool exist) {
      if (exist == true) {
        print("Delete path ${(value["file"] as File)}");
        (value["file"] as File).delete().then((_) {
          listImages.removeWhere((map) => map["url"] == value["url"]);
          redefinirPathImages();
        });
      } else {
        listImages.removeWhere((map) => map["url"] == value["url"]);
        redefinirPathImages();
      }
    });
  }

  Future redefinirPathImages() async {
    this.listImages.forEach((i) async {
      int index = this.listImages.indexOf(i) + 1;
      if (index == 1) {
        this.listImages[index - 1]["file"] = await _treatImage(
          this.listImages[index - 1]["file"],
          index,
        );
      } else if (index == 2) {
        if (this.petImagesModel.imgSecundario != "No Photo") {
          this.listImages[index - 1]["file"] = await _treatImage(
            this.listImages[index - 1]["file"],
            index,
          );
        }
      } else if (index == 3) {
        if (this.petImagesModel.imgTerciaria != "No Photo") {
          this.listImages[index - 1]["file"] = await _treatImage(
            this.listImages[index - 1]["file"],
            index,
          );
        }
      }
    });
  }

  Future selectImage() async {
    String op = await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop("camera");
                  },
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: DefaultColors.background,
                  child: Text(
                    "Câmera",
                    style: kButtonStyle,
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop("galeria");
                  },
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: DefaultColors.background,
                  child: Text(
                    "Galeria",
                    style: kButtonStyle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (op == null) return;

    int index = this.totalImg;
    File imagem = await _captureFoto(op);
    if (imagem != null) {
      File tmpImagem = await _treatImage(imagem, index + 1);
      Map<String, dynamic> map = {
        "widget": FileImage(imagem),
        "url": tmpImagem.path,
        "file": tmpImagem,
      };
      bool isImgExist = this.listImages.contains(map);
      if (!isImgExist) {
        this.addItem(map);
      }
    }
  }

  Future<File> _captureFoto(String op) async {
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
        return auxImage;
      }
    }
    return null;
  }

  Future<File> _treatImage(File fileImage, int indexImg) async {
    Directory tempDir = await getTemporaryDirectory();
    String path = tempDir.path;
    //? String title = _titleController.text;
    String caminho;
    if (indexImg == 1) {
      caminho = this.petImagesModel.imgPrincipal.split("/").last;
    } else if (indexImg == 2) {
      if (this.petImagesModel.imgSecundario != "No Photo") {
        caminho = this.petImagesModel.imgSecundario.split("/").last;
      } else {
        String id =
            this._perfilPetController.usuario.usuarioInfoModel.id.toString();
        String rand = DateTime.now().millisecondsSinceEpoch.toString();
        caminho = "image_$id" + "_$rand.jpg";
      }
    } else if (indexImg == 3) {
      if (this.petImagesModel.imgTerciaria != "No Photo") {
        caminho = this.petImagesModel.imgTerciaria.split("/").last;
      } else {
        String id =
            this._perfilPetController.usuario.usuarioInfoModel.id.toString();
        String rand = DateTime.now().millisecondsSinceEpoch.toString();
        caminho = "image_$id" + "_$rand.jpg";
      }
    }

    File compressImg = new File("$path/$caminho")
      ..writeAsBytesSync(fileImage.readAsBytesSync().toList());
    print(compressImg.toString());
    return compressImg;
  }

  //? -----------------------------------------------------------------------
  //? Atualizar
  Future atualizar() async {
    if (formKey.currentState.validate()) {
      //* Start Loading
      this.showLoading();
      int i = 0;
      for (File img in this.listFileImg) {
        i++;
        // print("******************************************");
        // print(img);
        Map<String, dynamic> result = await this
            ._perfilPetController
            .petRepository
            .uploadImagePet(img, false);
        if (result["Result"] == "Falha no Envio" ||
            result["Result"] == "Not Send") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro ao Enviar Imagem!",
          )..show(this.context);
          return;
        }
      }
      int qtd = 0;
      this.petImagesModel.listImages.forEach((img) {
        if (img != "No Photo") qtd++;
      });
      int qtdNow = this.listImages.length;
      //? Retira Imagens retiradas
      if (qtdNow < qtd) {
        List<String> listImgDelete = [];
        int cont = 1;
        this.petImagesModel.listImages.forEach((img) {
          if (cont > qtdNow) {
            if (img != "No Photo") listImgDelete.add(img);
          }
          cont++;
        });
        listImgDelete.forEach((urlImg) async {
          Map<String, dynamic> result = await this
              ._perfilPetController
              .petRepository
              .deleteImagePet(urlImg.split("/").last);
          print("[${result['Result']}]");
        });
      }
      //
      PetImagesModel petImages = PetImagesModel(
        idPet: this.petImagesModel.idPet,
        imgP: "images/pets/" + this.petImagesModel.imgPrincipal.split("/").last,
        imgS: this.listImages.length > 1 && this.listImages.length < 4
            ? this.petImagesModel.imgSecundario != "No Photo"
                ? "images/pets/" +
                    this.petImagesModel.imgSecundario.split("/").last
                : "images/pets/" +
                    this.listImages[1]["file"].path.split("/").last
            : "No Photo",
        imgT: this.listImages.length == 3
            ? this.petImagesModel.imgTerciaria != "No Photo"
                ? "images/pets/" +
                    this.petImagesModel.imgTerciaria.split("/").last
                : "images/pets/" +
                    this.listImages[2]["file"].path.split("/").last
            : "No Photo",
      );
      if (qtd != qtdNow) {
        // Upadate Pet Images
        Map<String, dynamic> result = await this
            ._perfilPetController
            .petRepository
            .updatePetImages(petImages);
        //* Stop Loading
        Modular.to.pop();
        if (result["Result"] == "Falha na Conexão") {
          //? Mensagem de Erro
          FlushbarHelper.createError(
            duration: Duration(milliseconds: 1500),
            message: "Erro na Conexão!",
          )..show(this.context);
        } else if (result["Result"] == "Register Update") {
          //? Exit Update
          this.exit(imagesPet: petImages);
          //? Mensagem de Sucesso
          FlushbarHelper.createSuccess(
            duration: Duration(milliseconds: 1500),
            message: "Sucesso na Atualização da Imagem!",
          )..show(this.context);
        } else if (result["Result"] == "Not Found Register") {
          //? Mensagem de Sucesso
          FlushbarHelper.createInformation(
            duration: Duration(milliseconds: 1500),
            message: "Falha na Atualização da Imagem!",
          )..show(this.context);
        }
      } else {
        //* Stop Loading
        Modular.to.pop();
        //? Exit Update
        if (i > 0) {
          this.exit(imagesPet: petImages);
        } else {
          this.exit();
        }
      }
      // print("*********************************************");
      // print(petImages.idPet);
      // print(petImages.imgPrincipal);
      // print(petImages.imgSecundario);
      // print(petImages.imgTerciaria);
    }
  }

  void exit({PetImagesModel imagesPet}) {
    if (imagesPet == null) {
      Modular.to.pop();
    } else {
      imagesPet.imgPrincipal = imagesPet.imgPrincipal != "No Photo"
          ? "http://app.petsmais.com/files/" + imagesPet.imgPrincipal
          : "No Photo";
      imagesPet.imgSecundario = imagesPet.imgSecundario != "No Photo"
          ? "http://app.petsmais.com/files/" + imagesPet.imgSecundario
          : "No Photo";
      imagesPet.imgTerciaria = imagesPet.imgTerciaria != "No Photo"
          ? "http://app.petsmais.com/files/" + imagesPet.imgTerciaria
          : "No Photo";
      Modular.to.pop(imagesPet);
    }
  }

  void showLoading() {
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
  void dispose() async {
    this.listImages.forEach((element) {
      (element["file"] as File).exists().then((bool value) {
        if (value == true) {
          print("Delete path ${(element["file"] as File)}");
          (element["file"] as File).delete();
        }
      });
    });
  }
}
