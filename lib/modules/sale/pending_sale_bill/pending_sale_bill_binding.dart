import 'package:get/get.dart';

import 'pending_sale_bill_controller.dart';

class PendingSaleBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<PendingSaleBillController>(() => PendingSaleBillController(),permanent: false);
  }
}
