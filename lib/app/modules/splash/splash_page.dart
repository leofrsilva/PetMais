import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.checkUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        color: DefaultColors.primarySmooth,
        width: size.width,
        height: size.height,
        child: Center(
          child: Container(
            width: 300,
            child: Observer(
              builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/images/logo.png"),
                      height: size.height * 0.20,
                    ),
                    SizedBox(height: 30),
                    controller.isErrorConnection == false
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                DefaultColors.secondary),
                          )
                        : Container(
                            child: Text(
                              "Falha na Conexão!",
                              style: TextStyle(
                                color: DefaultColors.error,
                                fontFamily: "Changa",
                                fontSize: 16,
                              ),
                            ),
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
