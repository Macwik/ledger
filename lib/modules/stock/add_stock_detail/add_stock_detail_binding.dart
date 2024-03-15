import 'package:get/get.dart';

import 'add_stock_detail_controller.dart';

class AddStockDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddStockDetailController());
  }
}
