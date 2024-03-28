import 'package:get/get.dart';

import 'purchase_record_controller.dart';

class PurchaseRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<PurchaseRecordController>(() => PurchaseRecordController(),
        permanent: false);
  }
}
