import 'package:get/get.dart';

import 'pending_order_controller.dart';

class PendingOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PendingOrderController());
  }
}
