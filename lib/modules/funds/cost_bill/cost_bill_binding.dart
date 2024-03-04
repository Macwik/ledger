import 'package:get/get.dart';

import 'cost_bill_controller.dart';

class CostBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CostBillController());
  }
}
