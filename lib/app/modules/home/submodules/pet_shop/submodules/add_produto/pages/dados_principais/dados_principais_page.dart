import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'dados_principais_controller.dart';

class DadosPrincipaisPage extends StatefulWidget {
  final String title;
  const DadosPrincipaisPage({Key key, this.title = "DadosPrincipais"})
      : super(key: key);

  @override
  _DadosPrincipaisPageState createState() => _DadosPrincipaisPageState();
}

class _DadosPrincipaisPageState
    extends ModularState<DadosPrincipaisPage, DadosPrincipaisController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Center(
        child: Text("Dados Principais"),
      ),
    );
  }
}
