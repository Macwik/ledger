import 'package:get/get.dart';

import 'product_owner_list_container.dart';

class ProductOwnerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductOwnerListContainer());
  }
}
