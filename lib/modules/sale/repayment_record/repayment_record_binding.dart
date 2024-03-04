import 'package:get/get.dart';

import 'repayment_record_controller.dart';

class RepaymentRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepaymentRecordController());
  }
}
