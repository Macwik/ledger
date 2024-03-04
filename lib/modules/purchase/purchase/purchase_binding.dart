import 'package:get/get.dart';

import 'purchase_controller.dart';

class PurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseController());
  }
}
