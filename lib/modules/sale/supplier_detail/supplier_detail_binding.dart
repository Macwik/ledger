import 'package:get/get.dart';

import 'supplier_detail_controller.dart';

class SupplierDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupplierDetailController());
  }
}
