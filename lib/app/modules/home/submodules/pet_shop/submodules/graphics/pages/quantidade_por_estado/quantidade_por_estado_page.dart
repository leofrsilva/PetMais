import 'package:flutter/material.dart';
import 'quantidade_por_estado_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/submodules/graphics/widgets/Indicator.dart';

class QuantidadePorEstadoPage extends StatefulWidget {
  final String title;
  const QuantidadePorEstadoPage({Key key, this.title = "QuantidadePorEstado"})
      : super(key: key);

  @override
  _QuantidadePorEstadoPageState createState() =>
      _QuantidadePorEstadoPageState();
}

class _QuantidadePorEstadoPageState extends ModularState<
    QuantidadePorEstadoPage, QuantidadePorEstadoController> {
  //use 'controller' variable to access controller

  int totalGraphic;
  List<String> typesGraphic;
  List<String> titlesGraphic;
  List<Map<String, dynamic>> data = [];
  Map<String, dynamic> qtdGraphic = {};

  _agruparGraficos() {
    qtdGraphic.clear();
    totalGraphic = 0;
    typesGraphic.forEach((nameGraphic) {
      int qtd = 0;
      data.forEach((map) {
        if (map["Estado"] == nameGraphic) {
          qtd = int.tryParse(map["Quantidade"]);
        }
      });
      qtdGraphic.addAll({nameGraphic: qtd});
    });
    qtdGraphic.forEach((key, value) {
      totalGraphic += value;
    });
  }

  @override
  void initState() {
    super.initState();
    this.typesGraphic = ["Em espera", "A caminho", "Entregue", "Cancelado"];
    this.titlesGraphic = ["EM ESPERA", "A CAMINHO", "ENTREGUR", "CANCELADO"];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black12,
        width: size.width,
        child: AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: controller.getListQuantEstados(),
                  builder: (context, snapshot) {
                    Widget defaultWidget;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      defaultWidget = Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Text(
                              "Carregando Dados",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontFamily: "Courier New",
                              ),
                            ),
                            SizedBox(height: 5),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        defaultWidget =
                            Center(child: Text("Erro ao carregar dados!"));
                      } else {
                        List<Map<String, dynamic>> listResults = snapshot.data;
                        if (listResults.length == 1 &&
                            listResults[0].containsKey("Result")) {
                          return Container(
                            child: Center(
                                child: Text(
                              "Nenhum dado salvo :(",
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          );
                        } else {
                          data.clear();
                          this.typesGraphic = [
                            "Em espera",
                            "A caminho",
                            "Entregue",
                            "Cancelado"
                          ];
                          this.titlesGraphic = [
                            "EM ESPERA",
                            "A CAMINHO",
                            "ENTREGUR",
                            "CANCELADO"
                          ];
                          listResults.forEach((result) {
                            data.add(result);
                          });
                          _agruparGraficos();

                          defaultWidget = _getGraphic();
                        }
                      }
                    } else {
                      defaultWidget = Container();
                    }
                    return defaultWidget;
                  }),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(int touchedIndex) {
    List<PieChartSectionData> listWidget = [];
    qtdGraphic.forEach((key, value) {
      int index;
      Color cor;
      if (key == typesGraphic[0]) {
        cor = DefaultColors.backgroundSmooth;
        index = 0;
      } else if (key == typesGraphic[1]) {
        cor = DefaultColors.secondarySmooth;
        index = 1;
      } else if (key == typesGraphic[2]) {
        cor = DefaultColors.primarySmooth;
        index = 2;
      } else if (key == typesGraphic[3]) {
        cor = DefaultColors.background;
        index = 3;
      }
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 17 : 12;
      final double radius = isTouched ? 45 : 35;
      final double valor = double.tryParse(
        ((value * 100) / totalGraphic as double).toStringAsFixed(1),
      );

      listWidget.add(
        PieChartSectionData(
          color: cor,
          value: valor,
          title: value == 0 ? '' : '$valor %',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        ),
      );
    });
    return listWidget;
  }

  Widget _getGraphic() {
    return Row(
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Expanded(
          flex: 2,
          child: Observer(builder: (_) {
            int index = controller.touchedIndex;
            return PieChart(
              PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  // setState(() {
                  if (pieTouchResponse.touchInput is FlLongPressEnd ||
                      pieTouchResponse.touchInput is FlPanEnd) {
                    controller.setTouchedIndex(-1);
                  } else {
                    controller
                        .setTouchedIndex(pieTouchResponse.touchedSectionIndex);
                  }
                  // });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                sections: showingSections(index),
              ),
            );
          }),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getLegends(),
          ),
        ),
      ],
    );
  }

  List<Widget> _getLegends() {
    List<Widget> listWidget = [];
    qtdGraphic.forEach((key, value) {
      Color cor;
      String title;
      if (key == typesGraphic[0]) {
        cor = DefaultColors.backgroundSmooth;
        title = titlesGraphic[0];
      } else if (key == typesGraphic[1]) {
        cor = DefaultColors.secondarySmooth;
        title = titlesGraphic[1];
      } else if (key == typesGraphic[2]) {
        cor = DefaultColors.primarySmooth;
        title = titlesGraphic[2];
      } else if (key == typesGraphic[3]) {
        cor = DefaultColors.background;
        title = titlesGraphic[3];
      }

      listWidget.add(
        Indicator(
          color: cor,
          text: title,
          isSquare: true,
        ),
      );
      listWidget.add(SizedBox(height: 4));
    });
    listWidget.add(SizedBox(height: 14));
    return listWidget;
  }
}
