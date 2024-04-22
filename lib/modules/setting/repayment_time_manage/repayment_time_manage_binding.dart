import 'package:get/get.dart';

import 'repayment_time_manage_controller.dart';

class RepaymentTimeManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepaymentTimeManageController());
  }
}
