import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/repository/adocao_remote/adocao_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';

part 'adocao_del_controller.g.dart';

@Injectable()
class AdocaoDelController = _AdocaoDelControllerBase with _$AdocaoDelController;

abstract class _AdocaoDelControllerBase with Store {
  BuildContext context;
  setContext(BuildContext contx) => this.context = contx;

  AdocaoRemoteRepository _adocaoRemoteRepository;
  _AdocaoDelControllerBase(this._adocaoRemoteRepository);

  Future deletar(int id) async {
    //* Start Loading
    this.showLoading();
    await _adocaoRemoteRepository
        .deleteAdocao(id)
        .then((Map<String, dynamic> result) {
      //* Stop Loading
      Modular.to.pop();
      if (result["Result"] == "Falha na Conexão") {
        //? Mensagem de Erro
        FlushbarHelper.createError(
          duration: Duration(milliseconds: 1500),
          message: "Erro na Conexão!",
        )..show(this.context);
        Future.delayed(Duration(milliseconds: 1000), () {
          Modular.to.pop(false);
        });
      } else if (result["Result"] == "Not Found Register" ||
          result["Result"] == "No Instantiated") {
        //? Problema na Exclusão
        FlushbarHelper.createInformation(
          duration: Duration(milliseconds: 1500),
          message: "Não foi possivel executar a Exclusão!",
        )..show(this.context);
        Future.delayed(Duration(milliseconds: 1000), () {
          Modular.to.pop(false);
        });
      } else if (result["Result"] == "Delete Register") {
        Modular.to.pop(true);
      }
    });
  }

  void showLoading() {
    Modular.to.showDialog(
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Center(
              child: Container(
                color: Colors.transparent,
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(DefaultColors.primarySmooth),
                ),
              ),
            ),
          );
        });
  }
}
