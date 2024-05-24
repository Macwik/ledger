import 'package:get/get.dart';

import 'product_type_manage_controller.dart';

class ProductTypeManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<ProductTypeManageController>(() => ProductTypeManageController(),
        permanent: false);
  }
}
