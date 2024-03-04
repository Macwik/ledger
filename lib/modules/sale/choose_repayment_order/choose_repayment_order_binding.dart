import 'package:get/get.dart';

import 'choose_repayment_order_controller.dart';

class  ChooseRepaymentOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseRepaymentOrderController());
  }
}
