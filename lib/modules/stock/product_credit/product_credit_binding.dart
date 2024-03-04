import 'package:get/get.dart';

import 'product_credit_controller.dart';

class ProductCreditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductCreditController());
  }
}
