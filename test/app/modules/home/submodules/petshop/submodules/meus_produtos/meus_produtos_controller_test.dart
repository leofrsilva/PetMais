import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petmais/app/modules/home/submodules/petshop/submodules/meus_produtos/meus_produtos_controller.dart';
import 'package:petmais/app/modules/home/submodules/petshop/submodules/meus_produtos/meus_produtos_module.dart';

void main() {
  initModule(MeusProdutosModule());
  // MeusProdutosController meusprodutos;
  //
  setUp(() {
    //     meusprodutos = MeusProdutosModule.to.get<MeusProdutosController>();
  });

  group('MeusProdutosController Test', () {
    //   test("First Test", () {
    //     expect(meusprodutos, isInstanceOf<MeusProdutosController>());
    //   });

    //   test("Set Value", () {
    //     expect(meusprodutos.value, equals(0));
    //     meusprodutos.increment();
    //     expect(meusprodutos.value, equals(1));
    //   });
  });
}
