import 'package:get/get.dart';
import 'stock_change_detail_controller.dart';

class StockChangeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockChangeDetailController());
  }
}
