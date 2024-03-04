import 'package:get/get.dart';

import 'sale_detail_controller.dart';

class SaleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaleDetailController());
  }
}
