import 'package:get/get.dart';

import 'product_cost_detail_controller.dart';

class ProductCostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductCostDetailController());
  }
}
