import 'package:get/get.dart';

import 'pending_retail_bill_controller.dart';

class PendingRetailBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PendingRetailBillController());
  }
}
