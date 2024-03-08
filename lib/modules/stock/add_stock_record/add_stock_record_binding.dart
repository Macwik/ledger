import 'package:get/get.dart';

import 'add_stock_record_controller.dart';

class AddStockRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddStockRecordController());
  }
}
