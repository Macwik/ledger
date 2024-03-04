import 'package:get/get.dart';

import 'stock_change_bill_controller.dart';

class StockChangeBillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockChangeBillController());
  }
}
