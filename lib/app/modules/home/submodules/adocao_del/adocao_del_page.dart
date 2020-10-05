import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'adocao_del_controller.dart';

class AdocaoDelPage extends StatefulWidget {
  final int id;
  AdocaoDelPage({this.id});

  @override
  _AdocaoDelPageState createState() => _AdocaoDelPageState();
}

class _AdocaoDelPageState
    extends ModularState<AdocaoDelPage, AdocaoDelController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            "Confimar exclusão da Adoção?",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Changa",
              color: DefaultColors.secondary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Não",
                  style: kFlatButtonStyle,
                ),
                onPressed: () {
                  Modular.to.pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  "Sim",
                  style: kFlatButtonStyle,
                ),
                onPressed: () {
                  controller.deletar(widget.id);
                },
              ),
            ],
          ),
        ],
      );
  }
}
