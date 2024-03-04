import 'package:get/get.dart';

import 'repayment_bill_controller.dart';

class RepaymentBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepaymentBillController());
  }
}
