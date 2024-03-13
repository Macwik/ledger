import 'package:get/get.dart';

import 'shopping_car_list_controller.dart';

class ShoppingCarListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShoppingCarListController());
  }
}
