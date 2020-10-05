import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'cadastro_controller.dart';
import 'models/highlighter_page/highlighter_page_model.dart';
import 'pages/cadastro_sucesso/cadastro_sucesso_page.dart';
import 'pages/dados_principais/dados_principais_page.dart';
import 'pages/pessoa_fisica/pessoa_fisica_page.dart';
import 'pages/pessoa_juridica/pessoa_juridica_page.dart';
import 'widgets/ProgressHighlighterPage.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> {
  //use 'controller' variable to access controller

  Widget get _background {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: AlignmentDirectional.topCenter,
        end: AlignmentDirectional.bottomCenter,
        colors: DefaultColors.gradient,
        stops: [0.3, 0.9],
      )),
    );
  }

  List<Widget> _listPages = [
    DadosPrincipaisPage(),
    PessoaFisicaPage(),
    PessoaJuridicaPage(),
    CadastroSucessoPage(),
  ];

  List<HighlighterPageModel> _listNavHighlighter = [
    HighlighterPageModel(index: 0, isNowPage: false),
    HighlighterPageModel(index: 1, isNowPage: false),
    HighlighterPageModel(index: 3, isNowPage: false),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            _background,
            Container(
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.2,
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(height: size.height * 0.063),
                              Observer(builder: (_) {
                                if (controller.page < 3) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black26,
                                    ),
                                    onPressed: () {
                                      if (controller.page == 0) {
                                        Modular.to
                                            .pushNamedAndRemoveUntil("/auth", (_) => false);
                                      } else if (controller.page == 1 ||
                                          controller.page == 2) {
                                        controller.changePage(0);
                                      }
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(height: size.height * 0.05),
                              Container(
                                height: size.height * 0.10,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "CADASTRO",
                                      style: TextStyle(
                                        color: DefaultColors.secondarySmooth,
                                        fontFamily: "OpenSans",
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    FaIcon(
                                      FontAwesomeIcons.addressCard,
                                      size: 40,
                                      color: DefaultColors.secondarySmooth,
                                    ),
                                  ],
                                ),
                                // child: Text(
                                //   "CADASTRO",
                                //   style: TextStyle(
                                //     color: DefaultColors.secondary,
                                //     fontFamily: "OpenSans",
                                //     fontSize: 30.0,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                              ),
                              Observer(builder: (_) {
                                return Container(
                                  height: size.height * 0.05,
                                  width: size.width,
                                  child: AnimatedBuilder(
                                    builder:
                                        (BuildContext context, Widget child) =>
                                            child,
                                    animation: controller.pageController,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: _listNavHighlighter.map((item) {
                                        bool isNow = false;
                                        if (item.index <=
                                            controller.page.toInt())
                                          isNow = true;
                                        return ProgressHighlighterPage(isNow);
                                      }).toList(),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.80,
                      child: PageView.builder(
                        controller: controller.pageController,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _listPages.length,
                        itemBuilder: (context, index) {
                          return _listPages[index];
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
