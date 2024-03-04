import 'package:get/get.dart';

import 'shopping_car_controller.dart';

class ShoppingCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShoppingCarController());
  }
}
