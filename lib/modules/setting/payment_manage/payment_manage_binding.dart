import 'package:get/get.dart';

import 'payment_manage_controller.dart';

class PaymentManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentManageController());
  }
}
