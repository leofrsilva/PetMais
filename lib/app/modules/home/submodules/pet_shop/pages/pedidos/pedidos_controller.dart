import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/pedido/pedido_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/pet_shop/pet_shop_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:petmais/app/shared/widgets/CustomTextField.dart';

import '../../pet_shop_controller.dart';

part 'pedidos_controller.g.dart';

@Injectable()
class PedidosController = _PedidosControllerBase with _$PedidosController;

abstract class _PedidosControllerBase extends Disposable with Store {
  BuildContext context;
  setContext(BuildContext value) => this.context = value;

  Function updatePedidos;
  setUpdatePedidos(Function value) => this.updatePedidos = value;

  PetShopController _petShopController;
  _PedidosControllerBase(this._petShopController) {
    this.descricaoController = TextEditingController();
    this.focusDescricao = FocusNode();
  }

  AnimationDrawerController get animationDrawer =>
      this._petShopController.animationDrawer;
  PetShopController get petshop => this._petShopController;
  UsuarioModel get usuario => this._petShopController.auth.usuario;

  TextEditingController descricaoController;

  FocusNode focusDescricao;

  Future<List<PedidoModel>> recuperarPedidos() async {
    final petShopRepository = PetShopRepository();
    if (this.usuario.isPetShop) {
      return await petShopRepository.listPedidos(
        idPetShop: this.usuario.usuarioInfo.id,
      );
    } else {
      return await petShopRepository.listPedidos(
        idUserComum: this.usuario.usuarioInfo.id,
      );
    }
  }

  Future showPedidoForPetshop(PedidoModel pedido, Size size) async {
    if (pedido.estado != null) {
      if (pedido.estado == "Entregue" || pedido.estado == "Cancelado") return;
    }
    final petShopRepository = PetShopRepository();
    List<String> listStatusRow1 = [];
    if (pedido.estado == "Em espera") {
      listStatusRow1 = ["Em espera", "A caminho"];
    } else if (pedido.estado == "A caminho") {
      listStatusRow1 = ["A caminho"];
    }
    List<String> listStatusRow2 = ["Entregue", "Cancelado"];
    String state = pedido.tipo == "entrega" ? pedido.estado : "";
    dynamic retorno = await Modular.to.showDialog(
        barrierDismissible: false,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            child: Center(
              child: Container(
                width: size.width * 0.95,
                height: pedido.tipo == "entrega"
                    ? size.height * 0.8
                    : size.height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child:
                    StatefulBuilder(builder: (BuildContext context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.025),
                            Text(
                              pedido.tipo == "entrega"
                                  ? "Pedido para ENTREGA"
                                  : "Pedido para RETIRADA",
                              style: TextStyle(
                                fontSize: size.height * 0.04,
                                fontFamily: "Changa",
                                color: DefaultColors.backgroundSmooth,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              pedido.nomeProduto,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: DefaultColors.background,
                                                fontFamily: "Changa",
                                                fontSize: size.height * 0.035,
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
                                              pedido.formatarData(
                                                  pedido.dataPedido),
                                              style: TextStyle(
                                                color: Colors.black12,
                                                fontSize: size.height * 0.0275,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.155,
                                  width: size.height * 0.155,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.0085),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(pedido.imagemProduto),
                                      fit: BoxFit.cover,
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
                                        pedido.quantidade.toString(),
                                    style: TextStyle(
                                      color: DefaultColors.secondarySmooth,
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w600,
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
                                    pedido.tipo == "entrega"
                                        ? "R\$ " +
                                            pedido.valorEntrega
                                                .toStringAsFixed(2)
                                                .replaceFirst(".", ",")
                                        : "R\$ " +
                                            pedido.total
                                                .toStringAsFixed(2)
                                                .replaceFirst(".", ","),
                                    style: TextStyle(
                                      color: DefaultColors.secondary,
                                      fontSize: size.height * 0.03,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.045),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    pedido.tipo == "entrega"
                                        ? "CLIENTE"
                                        : "PET SHOP",
                                    maxLines: 1,
                                    style: TextStyle(
                                      height: size.height * 0.001,
                                      color: DefaultColors.background,
                                      fontSize: size.height * 0.0225,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: Colors.black12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    pedido.tipo == "entrega"
                                        ? pedido.complemento != null
                                            ? pedido.endereco +
                                                " | " +
                                                pedido.complemento
                                            : pedido.endereco
                                        : pedido.enderecoPetshop,
                                    maxLines:
                                        pedido.complemento != null ? 4 : 3,
                                    style: TextStyle(
                                      color: DefaultColors.backgroundSmooth,
                                      fontSize: size.height * 0.0285,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (pedido.tipo == "entrega")
                              Container(
                                height: size.height * 0.155,
                                width: size.width * 0.85,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: listStatusRow1.map((status) {
                                        return Expanded(
                                          child: CustomButtonOutline(
                                            height: size.height * 0.06,
                                            width: size.height * 0.225,
                                            text: status,
                                            fontsize: size.height * 0.025,
                                            corText: status == state
                                                ? Colors.white
                                                : DefaultColors.background,
                                            decoration: BoxDecoration(
                                              color: status == state
                                                  ? DefaultColors.background
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                state = status;
                                              });
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Row(
                                      children: listStatusRow2.map((status) {
                                        return Expanded(
                                          child: CustomButtonOutline(
                                            height: size.height * 0.06,
                                            width: size.height * 0.225,
                                            text: status,
                                            fontsize: size.height * 0.025,
                                            corText: status == state
                                                ? Colors.white
                                                : DefaultColors.background,
                                            decoration: BoxDecoration(
                                              color: status == state
                                                  ? DefaultColors.background
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                state = status;
                                              });
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            if (pedido.tipo == "retirada")
                              Container(
                                height: size.height * 0.155,
                                alignment: Alignment.center,
                                child: Container(
                                  height: size.height * 0.085,
                                  width: size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: DefaultColors.secondary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    pedido.codigo,
                                    style: TextStyle(
                                      fontFamily: "Changa",
                                      color: Colors.white,
                                      fontSize: size.height * 0.035,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CustomButtonOutline(
                              height: size.height * 0.065,
                              width: size.width * 0.275,
                              text: pedido.tipo == "entrega"
                                  ? "Cancelar"
                                  : "Voltar",
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
                            SizedBox(width: size.width * 0.025),
                            CustomButtonOutline(
                              height: size.height * 0.065,
                              width: size.width * 0.275,
                              text: pedido.tipo == "entrega" ? "Salvar" : "OK",
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
                                if (pedido.tipo == "entrega") {
                                  Modular.to.pop(state);
                                } else {
                                  Modular.to.pop(true);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        });
    if (retorno is String) {
      if (retorno != pedido.estado) {
        //* Show Loading
        this.showLoading();
        await petShopRepository
            .changeStatus(pedido.id, retorno)
            .then((String result) {
          //* Hide Loading
          this.hideLoading();
          if (result == "Falha na Conexão") {
            //? Mensagem de Erro
            FlushbarHelper.createError(
              duration: Duration(milliseconds: 1500),
              message: "Erro na Conexão!",
            )..show(this.context);
          } else if (result == "Not Found Register" ||
              result == "No Fields were instantiated") {
            //? Problema na Exclusão
            FlushbarHelper.createInformation(
              duration: Duration(milliseconds: 1500),
              message: "Não foi possivel mudar o Status!",
            )..show(this.context);
          } else if (result == "Register Update") {
            FlushbarHelper.createSuccess(
              duration: Duration(milliseconds: 1500),
              message: "Status atualizado co Sucesso!",
            )..show(this.context);
            this.updatePedidos.call();
          }
        });
      }
    }
  }

  Future showPedido(PedidoModel pedido, Size size) async {
    // if (pedido.estado != null) {
    //   if (pedido.estado == "Entregue" || pedido.estado == "Cancelado") return;
    // }
    dynamic retorno = await Modular.to.showDialog(
        barrierDismissible: false,
        builder: (_) {
          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            child: Center(
              child: Container(
                width: size.width * 0.95,
                height: size.height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                child:
                    StatefulBuilder(builder: (BuildContext context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.01),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    pedido.nomeProduto,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: DefaultColors.background,
                                      fontFamily: "Changa",
                                      fontSize: size.height * 0.035,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width * 0.01),
                                IconButton(
                                    icon: Icon(Icons.close,
                                        color: Colors.black26),
                                    onPressed: () {
                                      Modular.to.pop(false);
                                    }),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    pedido.formatarData(pedido.dataPedido),
                                    style: TextStyle(
                                      color: Colors.black12,
                                      fontSize: size.height * 0.0275,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.015),
                            if (pedido.tipo == "entrega")
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      pedido.complemento != null
                                          ? pedido.endereco +
                                              " | " +
                                              pedido.complemento
                                          : pedido.endereco,
                                      maxLines:
                                          pedido.complemento != null ? 4 : 3,
                                      style: TextStyle(
                                        color: DefaultColors.backgroundSmooth,
                                        fontSize: size.height * 0.0285,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (pedido.tipo == "retirada")
                              Container(
                                decoration: BoxDecoration(
                                    color: DefaultColors.backgroundSmooth,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.all(size.height * 0.025),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        pedido.codigo,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.height * 0.0285,
                                          fontWeight: FontWeight.w600,
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
                        margin: EdgeInsets.only(bottom: size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CustomButtonOutline(
                              height: size.height * 0.065,
                              width: size.width * 0.5,
                              text: "Contatar Pet Shop",
                              icon: Icon(
                                Icons.chat,
                                color: DefaultColors.background,
                              ),
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
                                Modular.to.pop(1);
                              },
                            ),
                            SizedBox(width: size.width * 0.025),
                            CustomButtonOutline(
                              height: size.height * 0.065,
                              width: size.width * 0.275,
                              text: "Reportar",
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
                                Modular.to.pop(0);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          );
        });
    if (retorno is int) {
      if (retorno == 1) {
        UsuarioChatModel userChat = UsuarioChatModel(
          identifier: pedido.idPetshop,
          name: pedido.nomePetshop,
          image: pedido.imagemPetshop,
          isShop: true,
        );
        //Abrir tela de mensagens
        bool viewed = false;
        String nome = "Null";
        String url = "Null";
        Modular.to
            .pushNamed("/home/chat/$viewed/$nome/$url", arguments: userChat);
      } else if (retorno == 0) {
        dynamic resposta = await Modular.to.showDialog(
            barrierDismissible: false,
            builder: (_) {
              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: Center(
                  child: Container(
                    width: size.width * 0.95,
                    height: size.height * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.045),
                    child: StatefulBuilder(
                        builder: (BuildContext context, setState) {
                      return GestureDetector(
                        onTap: (){
                          this.focusDescricao.unfocus();
                        },
                                              child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.05),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Reporta algum erro ou observação do Pet Shop:",
                                          style: TextStyle(
                                            color: DefaultColors.backgroundSmooth,
                                            fontSize: size.height * 0.0275,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  CustomTextField(
                                    height: size.height * 0.3,
                                    controller: this.descricaoController,
                                    focusNode: this.focusDescricao,
                                    colorText: DefaultColors.background,
                                    label: "Decrição",
                                    isTitle: false,
                                    hint: "  ...",
                                    numLines: 5,
                                    maxCaracteres: 215,
                                    heightText: size.height,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (String value) {
                                      this.focusDescricao.unfocus();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: size.height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  CustomButtonOutline(
                                    height: size.height * 0.065,
                                    width: size.width * 0.5,
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
                                      Modular.to.pop(0);
                                    },
                                  ),
                                  SizedBox(width: size.width * 0.025),
                                  CustomButtonOutline(
                                    height: size.height * 0.065,
                                    width: size.width * 0.275,
                                    text: "Enviar",
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
                                      if (this.descricaoController.text.isEmpty ||
                                          this.descricaoController.text.length <
                                              3) {
                                        Modular.to.pop(0);
                                      } else {
                                        Modular.to.pop(1);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            });
        if (resposta is int) {
          if (resposta == 1) {
            final petShopRepository = PetShopRepository();
            //* Show Loading
            this.showLoading();
            await petShopRepository
                .sendReport(
                    idPetshop: pedido.idPetshop,
                    idUser: this.usuario.usuarioInfo.id,
                    nomeUser:
                        (this.usuario.usuarioInfo as UsuarioInfoModel).nome,
                    message: this.descricaoController.text)
                .then((String result) {
              //* Hide Loading
              this.hideLoading();
              if (result == "Send") {
                 FlushbarHelper.createSuccess(
              duration: Duration(milliseconds: 1500),
              message: "Sucesso ao enviar a mensagem!",
            )..show(this.context);
              } else if (result == "Not Send" || result == "No Fields were instantiated") {
                //? Problema na Exclusão
            FlushbarHelper.createInformation(
              duration: Duration(milliseconds: 1500),
              message: "Não foi possivel enviar a menssagem!",
            )..show(this.context);
              } else if (result == "Falha na Conexão") {
                //? Mensagem de Erro
                FlushbarHelper.createError(
                  duration: Duration(milliseconds: 1500),
                  message: "Erro na Conexão!",
                )..show(this.context);
              }
            });
          }
        }
      }
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
    this.descricaoController.dispose();
    this.focusDescricao.dispose();
  }
}
