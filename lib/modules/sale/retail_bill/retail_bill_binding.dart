import 'package:get/get.dart';

import 'retail_bill_controller.dart';

class RetailBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RetailBillController());
  }
}
