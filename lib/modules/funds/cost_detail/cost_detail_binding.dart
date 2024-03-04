import 'package:get/get.dart';

import 'cost_detail_controller.dart';

class CostDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CostDetailController());
  }
}
