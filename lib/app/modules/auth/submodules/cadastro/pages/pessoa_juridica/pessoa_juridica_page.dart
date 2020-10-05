import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/widgets/CustomButton.dart';
import 'package:petmais/app/shared/widgets/CustomButtonOutline.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
import 'pessoa_juridica_controller.dart';

class PessoaJuridicaPage extends StatefulWidget {
  final String title;
  const PessoaJuridicaPage({Key key, this.title = "DadosConta"}) : super(key: key);

  @override
  _PessoaJuridicaPageState createState() => _PessoaJuridicaPageState();
}

class _PessoaJuridicaPageState
    extends ModularState<PessoaJuridicaPage, PessoaJuridicaController> {
  //use 'controller' variable to access controller

  bool obscureText = true;
  bool obscureTextConf = true;

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: controller.formKey,
        child: AspectRatio(
          aspectRatio: size.aspectRatio,
          child: Container(
            height: size.height * 0.8,
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.075,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.05),
                      
                      
                    ],
                  ),
                  Container(
                    height: size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomButtonOutline(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            controller.back();
                          },
                          text: "VOLTAR",
                          elevation: 0.0,
                          width: size.width * 0.3,
                          
                          height: size.height * 0.07,
                          decoration: kDecorationContainerBorder,
                        ),
                        CustomButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            // controller.next();
                          },
                          text: "AVANÇAR",
                          elevation: 0.0,
                          width: size.width * 0.4,
                          
                          height: size.height * 0.07,
                          decoration: kDecorationContainer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
