import 'package:get/get.dart';

import 'stock_change_record_controller.dart';

class StockChangeRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockChangeRecordController());
  }
}
