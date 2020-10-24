import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import '../../shared/widgets/CustomButton.dart';
import 'auth_controller.dart';
import '../../shared/widgets/CustomButtonOutline.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends ModularState<AuthPage, AuthController> {
  //use 'controller' variable to access controller

  Widget get _backGround {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 10,
          left: 0,
          child: Container(
            width: 154 * 0.35,
            height: 705 * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundLine.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomEnd,
              colors: DefaultColors.gradient,
              stops: [0.3, 0.9],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              "Potato Company ©",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "OpenSans",
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _backGround,
          Container(
            color: Colors.transparent,
            height: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(size.width * 0.10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo.png",
                        height: size.height * 0.4,
                        width: size.height * 0.4,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.125),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomButtonOutline(
                        onPressed: () {
                          Modular.to.pushReplacementNamed("/auth/cadastro");
                        },
                        text: "CADASTRAR",
                        paddingRaised: 12.5,
                        elevation: 0.0,
                        width: size.width * 0.65,
                        decoration: kDecorationContainerBorder,
                      ),
                      SizedBox(height: size.height * 0.025),
                      CustomButton(
                        onPressed: () {
                          Modular.to.pushReplacementNamed("/auth/logincomum");
                        },
                        text: "LOGIN",
                        paddingRaised: 15.0,
                        elevation: 0.0,
                        width: size.width * 0.65,
                        decoration: kDecorationContainer,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25.0,
                      horizontal:  16.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: <Color>[
                                Colors.white10,
                                Colors.black12,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )),
                          ),
                        ),
                        SizedBox(width: 7.5),
                        Expanded(
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.white10,
                                  Colors.black12,
                                ],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Modular.to.pushReplacementNamed("/home");
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Entrar como",
                              style: TextStyle(
                                color: DefaultColors.secondarySmooth,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "RussoOne",
                              ),
                            ),
                            TextSpan(
                              text: " Convidado",
                              style: TextStyle(
                                  color: DefaultColors.secondarySmooth,
                                  fontSize: 16.0,
                                  fontFamily: "RussoOne"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Column(
                  //   children: <Widget>[
                  //     Text(
                  //       "- OR -",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //     SizedBox(height: 15.0),
                  //     Text(
                  //       "Entrar com",
                  //       style: kLabelStyle,
                  //     ),
                  //   ],
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15.0, bottom: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       CustomIconButtonAuth(
                  //           onPressed: () {},
                  //           icon: FaIcon(FontAwesomeIcons.facebookF).icon,
                  //           cor: Colors.blue[700]),
                  //       SizedBox(width: 20),
                  //       CustomIconButtonAuth(
                  //         onPressed: () {},
                  //         icon: FaIcon(FontAwesomeIcons.google).icon,
                  //         cor: Colors.redAccent,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
