import 'package:get/get.dart';

import 'add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<AddProductController>(() => AddProductController(), permanent: false);
  }
}
