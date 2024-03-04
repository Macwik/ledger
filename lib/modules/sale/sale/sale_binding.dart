import 'package:get/get.dart';

import 'sale_controller.dart';

class SaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaleController());
  }
}
