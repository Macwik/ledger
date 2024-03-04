import 'package:get/get.dart';

import 'sale_record_controller.dart';

class SaleRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<SaleRecordController>(() => SaleRecordController(), permanent: false);
  }
}
