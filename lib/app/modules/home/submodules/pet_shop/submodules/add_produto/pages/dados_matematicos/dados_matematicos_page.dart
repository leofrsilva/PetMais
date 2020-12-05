import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dados_matematicos_controller.dart';

class DadosMatematicosPage extends StatefulWidget {
  @override
  _DadosMatematicosPageState createState() => _DadosMatematicosPageState();
}

class _DadosMatematicosPageState extends ModularState<DadosMatematicosPage, DadosMatematicosController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Center(
        child: Text("Dados Matemáticos"),
      ),
    );
  }
}