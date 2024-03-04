import 'package:get/get.dart';

import 'repayment_detail_controller.dart';

class RepaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepaymentDetailController());
  }
}
