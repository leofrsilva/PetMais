import 'package:flutter/material.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

class ListInfo extends StatelessWidget {
  final UsuarioModel usuario;
  final AnimationDrawerController animationDrawer;
  final Function onPressedUpd;

  ListInfo({this.usuario, this.animationDrawer, this.onPressedUpd});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _listInfo(size);
  }

  Widget _listInfo(Size size) {
    return Container(
      height: size.height * 0.39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft:
              Radius.circular(this.animationDrawer.isShowDrawer ? 40 : 0),
          topLeft: Radius.circular(this.animationDrawer.isShowDrawer ? 40 : 0),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.edit,
                color: DefaultColors.secondary,
              ),
              onPressed: this.onPressedUpd,
            ),
          ),
          _info(
            this.usuario.usuarioInfoModel.nome +
                " " +
                this.usuario.usuarioInfoModel.sobreNome,
            Icon(
              Icons.person_outline,
              color: DefaultColors.others,
            ),
          ),
          _info(
            this.usuario.email,
            Icon(
              Icons.email,
              color: DefaultColors.others,
            ),
          ),
          _info(
            this.usuario.usuarioInfoModel.dataNascimento,
            Icon(
              Icons.date_range,
              color: DefaultColors.others,
            ),
          ),
          _info(
            this.usuario.usuarioInfoModel.numeroTelefone,
            Icon(
              Icons.phone,
              color: DefaultColors.others,
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(String text, Icon icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              icon == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: icon,
                    ),
              Expanded(
                child: Text(
                  text,
                  style: kDescriptionStyle,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: DefaultColors.secondary,
        ),
      ],
    );
  }
}
