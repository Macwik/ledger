import 'package:get/get.dart';

import 'remittance_record_controller.dart';

class RemittanceRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemittanceRecordController());
  }
}
