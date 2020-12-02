import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petmais/app/modules/home/submodules/pet_shop/submodules/meus_produtos/meus_produtos_controller.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/pet_shop_module.dart';

void main() {
  initModule(PetShopModule());
  // MeusProdutosController meusprodutos;
  //
  setUp(() {
    //     meusprodutos = PetShopModule.to.get<MeusProdutosController>();
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
