import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:petmais/app/modules/home/submodules/pet_shop/pet_shop_controller.dart';
import 'package:petmais/app/modules/home/submodules/pet_shop/pet_shop_module.dart';

void main() {
  initModule(PetShopModule());
  // PetShopController petshop;
  //
  setUp(() {
    //     petshop = PetShopModule.to.get<PetShopController>();
  });

  group('PetShopController Test', () {
    //   test("First Test", () {
    //     expect(petshop, isInstanceOf<PetShopController>());
    //   });

    //   test("Set Value", () {
    //     expect(petshop.value, equals(0));
    //     petshop.increment();
    //     expect(petshop.value, equals(1));
    //   });
  });
}
