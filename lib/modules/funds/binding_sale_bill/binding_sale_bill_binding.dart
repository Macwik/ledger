import 'package:get/get.dart';

import 'binding_sale_bill_controller.dart';

class BindingSaleBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BindingSaleBillController());
  }
}
