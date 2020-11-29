import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/modules/home/controllers/animation_drawer_controller.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_juridico_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_info_model.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

// ignore: must_be_immutable
class ListInfo extends StatelessWidget {
  final UsuarioModel usuario;
  final AnimationDrawerController animationDrawer;
  final Function onPressedUpd;

  Widget listInfo;

  ListInfo({this.usuario, this.animationDrawer, this.onPressedUpd});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _listInfo(size);
  }

  Widget _listInfo(Size size) {
    if (this.usuario.usuarioInfo is UsuarioInfoModel) {
      listInfo = Column(
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
            (this.usuario.usuarioInfo as UsuarioInfoModel).nome,
            Icon(
              Icons.person_outline,
              color: DefaultColors.others,
            ),
            size,
          ),
          _info(
            this.usuario.email,
            Icon(
              Icons.email,
              color: DefaultColors.others,
            ),
            size,
          ),
          _info(
            this.usuario.usuarioInfo is UsuarioInfoModel
                ? (this.usuario.usuarioInfo as UsuarioInfoModel).dataNascimento
                : "",
            Icon(
              Icons.date_range,
              color: DefaultColors.others,
            ),
            size,
          ),
          _info(
            this.usuario.usuarioInfo is UsuarioInfoModel
                ? (this.usuario.usuarioInfo as UsuarioInfoModel).numeroTelefone
                : "",
            Icon(
              Icons.phone,
              color: DefaultColors.others,
            ),
            size,
          ),
        ],
      );
    } else {
      // Usuario Júridico ONG
      UsuarioInfoJuridicoModel user =
          (this.usuario.usuarioInfo as UsuarioInfoJuridicoModel);
      // Telefones
      String tels = user.telefone1;
      if ((this.usuario.usuarioInfo as UsuarioInfoJuridicoModel).telefone2 !=
          null) {
        tels = tels + " | " + user.telefone2;
      }
      return Container(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.0125),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.nomeOrg,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: size.height * 0.0018,
                              fontSize: size.height * 0.029,
                              fontFamily: "Changa",
                              color: DefaultColors.secondarySmooth),
                        ),
                      ),
                    ),
                  ],
                ),
                _info(
                  " " + user.formCnpj,
                  Icon(
                    FontAwesomeIcons.idCard,
                    color: DefaultColors.others,
                  ),
                  size,
                ),
                _info(
                  " " + user.endereco.toLogadouro(),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      FontAwesomeIcons.mapMarkedAlt,
                      color: DefaultColors.others,
                    ),
                  ),
                  size,
                ),
                _info(
                  " " + this.usuario.email,
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      Icons.email,
                      color: DefaultColors.others,
                    ),
                  ),
                  size,
                ),
                _info(
                  tels,
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Icon(
                      Icons.phone,
                      color: DefaultColors.others,
                    ),
                  ),
                  size,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.085),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    FontAwesomeIcons.userEdit,
                    color: DefaultColors.secondary,
                  ),
                  onPressed: this.onPressedUpd,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: size.height * 0.419,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft:
              Radius.circular(this.animationDrawer.isShowDrawer ? 40 : 0),
          topLeft: Radius.circular(this.animationDrawer.isShowDrawer ? 40 : 0),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: listInfo,
    );
  }

  Widget _info(String text, Widget icon, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.004),
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
