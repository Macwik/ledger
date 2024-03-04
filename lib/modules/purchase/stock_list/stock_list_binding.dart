import 'package:get/get.dart';

import 'stock_list_controller.dart';

class StockListBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<StockListController>(() => StockListController(), permanent: false);
  }
}
