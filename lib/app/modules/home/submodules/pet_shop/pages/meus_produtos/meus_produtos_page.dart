import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'meus_produtos_controller.dart';

class MeusProdutosPage extends StatefulWidget {
  final String title;
  const MeusProdutosPage({Key key, this.title = "MeusProdutos"})
      : super(key: key);

  @override
  _MeusProdutosPageState createState() => _MeusProdutosPageState();
}

class _MeusProdutosPageState
    extends ModularState<MeusProdutosPage, MeusProdutosController> {
  //use 'controller' variable to access controller
  Widget floatButton = Container();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // controller.updateListAdption = this.onRefreshAdoption;

    if (controller.usuario.isJuridico) {
      if (controller.usuario.isPetShop) {
        floatButton = FloatingActionButton(
          backgroundColor: DefaultColors.background,
          child: Icon(
            FontAwesomeIcons.plusSquare,
            color: Colors.white,
          ),
          onPressed: () {
            Modular.to.pushNamed("/home/addProduto");
          },
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: DefaultColors.secondary,
      body: Observer(builder: (_) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
                0)// controller.animationDrawer.isShowDrawer ? 40 : 0),
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                     0) // controller.animationDrawer.isShowDrawer ? 40 : 0),
                ),
              ),
            ),
          ),
        );
      }),
      floatingActionButton: floatButton,
    );
  }
}
