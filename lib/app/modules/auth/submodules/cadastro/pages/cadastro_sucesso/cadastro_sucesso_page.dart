import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

class CadastroSucessoPage extends StatefulWidget {
  final String title;
  const CadastroSucessoPage({Key key, this.title = "CadastroSucesso"})
      : super(key: key);

  @override
  _CadastroSucessoPageState createState() => _CadastroSucessoPageState();
}

class _CadastroSucessoPageState extends State<CadastroSucessoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
    Container(
      height: size.height * 0.5,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FaIcon(
            FontAwesomeIcons.checkCircle,
            color: Colors.greenAccent,
            size: 60,
          ),
          SizedBox(height: 25.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Cadastro realizado com sucesso!",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: DefaultColors.secondary,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Changa"
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    CustomButton(
      onPressed: () {
        Modular.to.pushNamedAndRemoveUntil("/home", (_) => false);
      },
      text: "ENTRAR",
      elevation: 0.0,
      width:  size.width * 0.4,
      decoration: kDecorationContainer,
    ),
        ],
      );
  }
}
